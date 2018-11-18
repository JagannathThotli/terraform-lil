/*
resource "aws_instance" "dc2" {
  ami = "ami-050202fb72f001b47"
  instance_type = "t2.micro"
  subnet_id = "subnet-0dde1b1035a358e73"
  #count = "${var.howmany}"
  security_groups = [
    "${aws_security_group.allow-all.id}"]

  tags {
    #Name = "dc-${count.index + 1}"
    Name = "dc2"
    Managedby = "Terraform"
  }
  user_data = <<EOF
  <powershell>
    net user ${var.INSTANCE_USERNAME} ‘${var.INSTANCE_PASSWORD}’ /add /y
    net localgroup administrators ${var.INSTANCE_USERNAME} /add

    winrm quickconfig -q
    net stop winrm
    sc.exe config winrm start=auto
    net start winrm

    #Rename-Computer -NewName "dc-${count.index + 1}" -Restart

    Install-WindowsFeature -Name AD-Domain-Services -IncludeAllSubFeature -IncludeManagementTools
    Rename-Computer -NewName "dc1" -Restart
    Start-Sleep -s 1200


Import-Module ADDSDeployment
Install-ADDSForest `
-CreateDnsDelegation:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainMode "WinThreshold" `
-DomainName "jag.local" `
-DomainNetbiosName "JAG" `
-ForestMode "WinThreshold" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$false `
-SysvolPath "C:\Windows\SYSVOL" `
-Force:$true



    #Set-ExecutionPolicy RemoteSigned -Force
  </powershell>
  EOF
}
*/
