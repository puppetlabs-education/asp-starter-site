dsc_xarchive{ 'SampleCompressArchive':
    dsc_path             => "c:/foo/logs",
    dsc_destination      => "c:/foo/logbackup",
    dsc_compressionlevel => "Optimal",
    dsc_destinationtype  => "File",
}

dsc_file{ 'ExampleTextFile':
  dsc_ensure          => 'Present',
  dsc_type            => 'File',
  dsc_destinationpath => 'C:/foo.txt',
  dsc_contents        => 'example text',
}
