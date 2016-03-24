dsc_package{ 'fooproduct':
  dsc_ensure    => "Present",
  dsc_name      => "FooProduct",
  dsc_productid => "{E1F581BF-09C4-48B2-991A-429D61F48199}",
  dsc_path      => "c:\\vagrant\\artifacts\\foosetup.msi",
}

file { 'c:\Program Files (x86)\FooProduct\fooservice.exe.config':
  require => Dsc_package['fooproduct'],
  notify  => Service['fooservice'],
  content => @(APPCONFIG)
  <?xml version="1.0" encoding="utf-8"?>
  <configuration>
    <appSettings>
      <add key="environment" value="production"/>
    </appSettings>
  </configuration>
  |- APPCONFIG
}

service { 'fooservice':
  require => Dsc_package['fooproduct'],
  ensure  => 'running',
  enable  => true,
}
