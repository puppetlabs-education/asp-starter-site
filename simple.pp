# typical DSC Resource declaration
File ExampleTextFile
{
  Ensure          = 'Present'
  Type            = 'File'
  DestinationPath = 'C:\foo.txt'
  Contents        = 'example text'
}

# Puppet DSC translation
dsc_file{'ExampleTextFile':
  dsc_ensure          => 'Present',
  dsc_type            => 'File',
  dsc_destinationpath => 'C:\foo.txt',
  dsc_contents        => 'example text',
}
