iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
choco upgrade chocolatey -pre -y
choco install puppet-agent -y
