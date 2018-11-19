resource "aws_instance" "privdc" {
  ami = "ami-050202fb72f001b47"
  instance_type = "t2.micro"
  subnet_id = "subnet-00853b3c40f6cbe97"
  #count = "${var.howmany}"
  #security_groups = ["sg-03ce52ba586d94397"]

  tags {
    #Name = "dc-${count.index + 1}"
    Name = "privdc"
    Managedby = "Terraform"
  }
  user_data = <<EOF
  <powershell>
    net user Administrator "Password2008" /y


    winrm quickconfig -q
    net stop winrm
    sc.exe config winrm start=auto
    net start winrm

    Install-WindowsFeature -Name AD-Domain-Services -IncludeAllSubFeature -IncludeManagementTools
    #Install-WindowsFeature DNS -IncludeManagementTools
    $pwd = ConvertTo-SecureString 'Password2008' -AsPlainText -Force
    Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath "C:\Windows\NTDS" -DomainMode "WinThreshold" -DomainName "priv.local" -DomainNetbiosName "priv" -ForestMode "WinThreshold" -InstallDns:$true -LogPath "C:\Windows\NTDS" -NoRebootOnCompletion:$false -SysvolPath "C:\Windows\SYSVOL" -Force:$true -SafeModeAdministratorPassword $pwd
    </powershell>
  EOF
}