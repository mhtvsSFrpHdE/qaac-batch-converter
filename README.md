# qaac-batch-converter
**What's this**  
So this is the one you're looking for to convert every file inside a folder.  
Right-click on the qaac.ps1 file, choose edit and fill every argument, save and run.

**How to use**  
It's require my another powershell library to work:  
https://github.com/mhtvsSFrpHdE/folder-iterator  
Download the iterator and put it into the same folder as qaac ps1.

The first few line until five blank line in qaac ps1 that the most common argument you want to change.  
They're:
- $inputFolder: Where the input folder, all subfolder and files are reconized.
- $outputFolder: Where the output folder, all output stored together and subfolder from source is ignored.
- $inputFileType: Only convert file extension like this, other will be ignored.
- $inputFileType2: In rare case you want to convert two format, only two is supported but no three support.
- $QAAC_BIN: A working QAAC bin path.
- $FFMPEG_BIN: In case to convert a file format that not supported by QAAC or not, FFMPEG bin is required like QAAC.

To change QAAC encoding argument, find:
```
...$myCommand = "$FFMPEG_BIN -i...
```
At the end of this line, there is QAAC argument.  
Carefully edit it or you are risk in breaking the code.

**LICENSE**  
Only if your project is **fully** open-source, under any LICENSE,  
you can republish the code, even without to indicate the author.  
Otherwise to republish the code that embedded into other project is **denied**.
