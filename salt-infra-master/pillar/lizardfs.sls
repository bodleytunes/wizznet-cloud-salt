lizardfs:
  source_folder: /zpool1/lizardfs
  mounted_folder: /liz1
  nodes:
    - name: p20
      mfsmaster: True
      shadowmaster: False
      metalogger: True
      cgiserver: True
      chunkserver: True
      chunkservername: chunkserver1
    - name: p21
      mfsmaster: False
      shadowmaster: True
      metalogger: True
      cgiserver: True
      chunkserver: True
      chunkservername: chunkserver2

    
