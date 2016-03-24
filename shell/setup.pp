# This file was only used to bootstrap the machine for the online demo
# this is not needed for running the examples
# However it is a nice example of Puppet and DSC

reboot{ 'dsc_reboot':
  when    => pending,
  timeout => 5
}

$key = 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate'
$au_key = "${key}\\AU"

registry_key { [$key, $au_key]:
  ensure => present,
}

registry_value { "${au_key}\\NoAutoUpdate":
  ensure => present,
  type   => 'dword',
  data   => 0,
}

registry_value { "${au_key}\\AUOptions":
  ensure => present,
  type   => 'dword',
  data   => 2,
}

service { 'wuauserv':
  ensure  => 'running',
  enable  => true,
}

package{ 'dotnet4.5.2':
  ensure => latest,
  provider => 'chocolatey',
  notify => Reboot['dsc_reboot'],
}->

package{ 'powershell':
  ensure => latest,
  provider => 'chocolatey',
  install_options => ['-pre'],
  notify          => Reboot['dsc_reboot'],
}->

dsc_windowsfeature{ 'iis':
  dsc_ensure => 'Present',
  dsc_name   => 'Web-Server',
}->

dsc_windowsfeature{ 'iisscriptingtools':
  dsc_ensure => 'Present',
  dsc_name   => 'Web-Scripting-Tools',
}->

dsc_windowsfeature{ 'aspnet45':
  dsc_ensure => 'Present',
  dsc_name   => 'Web-Asp-Net45',
}->

exec{'remove-web':
command=> "remove-website 'Default Web Site'",
provider => 'powershell'
}
