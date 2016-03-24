Configuration InstallIIS
{
  Import-DscResource -Module xWebAdministration
  Import-DscResource -Module cChoco

  cChocoInstaller installChoco {
    InstallDir = 'c:\tools'
  }
  
  cChocoPackageInstaller dotnet452 {
    Name = 'dotnet452'
  }
  
  cChocoPackageInstaller powershell {
    Name = 'powershell'
  }
  
  WindowsFeature iis {
    Ensure    = 'Present'
    Name      = 'Web-Server'
    DependsOn = @("[cChocoPackageInstaller]PowerShell")
  }
  
  WindowsFeature aspnet45 {
    Ensure    = 'Present'
    Name      = 'Web-Asp-Net45'
    DependsOn = @("[WindowsFeature]iis")
  }
  
  xWebsite defaultsite {
    Ensure       = 'Present'
    Name         = 'Default Web Site'
    State        = 'Stopped'
    PhysicalPath = 'C:\inetpub\wwwroot'
    DependsOn    = @("[WindowsFeature]aspnet45")
  }
  
  File websitefolder {
    Ensure          = 'present'
    SourcePath      = 'C:\vagrant\artifacts\website_code'
    DestinationPath = 'c:\inetpub\foo'
    Recurse         = $true
    Type            = 'Directory'
    DependsOn       = @("[xWebsite]defaultsite")
  }
  
  xWebAppPool newwebapppool {
    Name                      = 'PuppetCodezAppPool'
    Ensure                    = 'Present'
    ManagedRuntimeVersion     = 'v4.0'
    LogEventOnRecycle         = 'Memory'
    RestartMemoryLimit        = '1000'
    RestartPrivateMemoryLimit = '1000'
    IdentityType              = 'ApplicationPoolIdentity'
    State                     = 'Started'
    DependsOn                 = @("[WindowsFeature]iis",
                                  "[WindowsFeature]aspnet45",
                                  "[cChocoPackageInstaller]dotnet452")
  }
  
  xWebsite newwebsite {
    Ensure          = 'Present'
    Name            = 'PuppetCodez'
    State           = 'Started'
    PhysicalPath    = 'c:\inetpub\foo'
    ApplicationPool = 'PuppetCodezAppPool'
    BindingInfo     = MSFT_xWebBindingInformation{
      Protocol = 'HTTP'
      Port     = 80
    }
    DependsOn = @("[WindowsFeature]iis",
                  "[WindowsFeature]aspnet45",
                  "[cChocoPackageInstaller]dotnet452",
                  "[File]websitefolder",
                  "[xWebAppPool]newwebapppool")
  }
}

InstallIIS

Start-DscConfiguration -Path .\InstallIIS -Verbose -Wait
