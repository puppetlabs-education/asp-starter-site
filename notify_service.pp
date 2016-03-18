dsc_package{ 'fooproduct':
  dsc_ensure    => "Present",
  dsc_name      => "FooProduct",
  dsc_productid => "{49CBC02D-A641-43B2-9B1E-190A96D647F6}",
  dsc_path      => "c:\\vagrant\\artifacts\\foosetup.msi",
}

service { 'fooservice':
  ensure  => 'running',
  enable  => true,
  require => Dsc_package['fooproduct'],
}

file { 'c:\Program Files\Foo\FooProduct\fooservice.exe.config':
  notify  => Service['fooservice'],
  require => Dsc_package['fooproduct'],
  content => @(APPCONFIG)
  <?xml version="1.0" encoding="utf-8"?>
  <configuration>
    <appSettings>
      <add key="environment" value="production"/>
    </appSettings>
  </configuration>
  |- APPCONFIG
}
