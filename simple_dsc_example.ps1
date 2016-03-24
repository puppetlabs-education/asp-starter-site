configuration Example
{
  Import-DscResource xPSDesiredStateConfiguration

  xArchive SampleCompressArchive
  {
      Path             = "c:\foo\logs"
      Destination      = "c:\foo\logbackup"
      CompressionLevel = "Optimal"
      DestinationType  = "File"
  }
  
  File ExampleTextFile
  {
    Ensure          = 'Present'
    Type            = 'File'
    DestinationPath = 'C:\foo.txt'
    Contents        = 'example text'
  }
}
