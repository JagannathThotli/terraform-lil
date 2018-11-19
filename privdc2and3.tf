resource "aws_instance" "priv" {
  ami = "ami-050202fb72f001b47"
  instance_type = "t2.micro"
  subnet_id = "subnet-00853b3c40f6cbe97"
  count = "${var.howmany}"
  #private_dns = "10.0.178.130"
  #security_groups = ["sg-03ce52ba586d94397"]

  tags {
    Name = "priv-${count.index + 2}"
    #Name = "priv"
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
    Install-WindowsFeature DNS -IncludeManagementTools
    $pwd = ConvertTo-SecureString 'Password2008' -AsPlainText -Force
    $Username = "jag1\Administrator"
    $SecurePassword = ConvertTo-SecureString "Password2008" -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential($Username, $SecurePassword)
    #Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath "C:\Windows\NTDS" -DomainMode "WinThreshold" -DomainName "jag1.local" -DomainNetbiosName "JAG1" -ForestMode "WinThreshold" -InstallDns:$false -LogPath "C:\Windows\NTDS" -NoRebootOnCompletion:$false -SysvolPath "C:\Windows\SYSVOL" -Force:$true -SafeModeAdministratorPassword $pwd
    Install-ADDSDomainController -NoGlobalCatalog:$false -CriticalReplicationOnly:$false -DatabasePath "C:\Windows\NTDS" -DomainName "priv.local" -InstallDns:$true -LogPath "C:\Windows\NTDS" -NoRebootOnCompletion:$false -SysvolPath "C:\Windows\SYSVOL" -Force:$true -SafeModeAdministratorPassword $pwd -ReadOnlyReplica:$false -SiteName Default-First-Site-Name -Credential $credential
    </powershell>
  EOF
}
