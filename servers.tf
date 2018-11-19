/*
resource "aws_instance" "dc1" {
  ami = "ami-050202fb72f001b47"
  instance_type = "t2.micro"
  subnet_id = "subnet-00853b3c40f6cbe97"
  #count = "${var.howmany}"
  #security_groups = ["sg-03ce52ba586d94397"]
  tags {
    #Name = "dc-${count.index + 1}"
    Name = "dc1"
    Managedby = "Terraform"
  }
  user_data = <<EOF
  <powershell>
    net user Administrator "Password2008" /y /y

    winrm quickconfig -q
    net stop winrm
    sc.exe config winrm start=auto
    net start winrm

    #Rename-Computer -NewName "dc-${count.index + 1}" -Restart

    Install-WindowsFeature -Name AD-Domain-Services -IncludeAllSubFeature -IncludeManagementTools
    #Rename-Computer -NewName "dc1" -Restart
    </powershell>


        #Set-ExecutionPolicy RemoteSigned -Force

  EOF

      provisioner "file" {
        source = "test.ps1"
        destination = "c:/users/administrator/test.ps1"
      }
      provisioner "remote-exec" {
        inline = [
        "powershell.exe -command c:/test.ps1"]
      }
}


*/
/*inline = [
    "$pwd = ConvertTo-SecureString 'Password2008' -AsPlainText -Force",
    "Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath 'C:\\Windows\\NTDS' -DomainMode 'WinThreshold' -DomainName 'jag.local' -DomainNetbiosName 'JAG' -ForestMode 'WinThreshold' -InstallDns:$false -LogPath 'C:\\Windows\\NTDS' -NoRebootOnCompletion:$false -SysvolPath 'C:\\Windows\\SYSVOL' -Force:$true -SafeModeAdministratorPassword $pwd"
  ]*//*

*/
/*
  interpreter = ["PowerShell"]
  connection {
    type     = "winrm"
    user     = "Admin"
    password = "${var.INSTANCE_PASSWORD}"
  }*/
