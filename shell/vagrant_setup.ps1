iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
choco install puppet-agent -y

$p = [System.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::Machine)
if(-not($p.EndsWith(";")){
  [System.Environment]::SetEnvironmentVariable("PATH", ($p + ";"), [System.EnvironmentVariableTarget]::Machine)
}
