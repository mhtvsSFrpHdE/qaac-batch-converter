# Preset argument
$inputFolder="C:\Program Files\7-zip"
$outputFolder="C:\Program Files\7-zip\out"
# Filter file extension name
$inputFileType=".tta"
# 2nd format, use only with rare situation
$inputFileType2=$inputFileType
# Const var write as upper case with underscore
# NOTE: There are three quote with the BIN variable
$QAAC_BIN = "C:\qaac.exe"
$FFMPEG_BIN = "C:\ffmpeg.exe"





# Other default values
$OUTPUT_FORMAT = ".m4a"
$CMD_SCRIPT_FILE = "$outputFolder\QaacBatch.cmd"

# Import library
# cmd script lib
. ".\cstpw.ps1"
# folder itr lib
. ".\folder-iterator.ps1"

# Create cmd script file by using library
CreateCmdScript

# So Windows XP doesn't really have a UTF-8 code page, will not work on that.
# Use 65001 code page to cover the non-ANSI file name.
WriteCmdScript "chcp 65001"

# Fill folder iterator function
function DoSomethingFunction {
    param (
        $InputFile,
        $OutputFileName
    )

    # Filter Output file extension
    $OutputFile = $OutputFileName + $OUTPUT_FORMAT

	# Generate command
    $myCommand = "`"$FFMPEG_BIN`" -i `"$InputFile`" -f wav pipe: | `"$QAAC_BIN`" --tvbr 127 -q 2 --no-optimize - -o `"$OutPutFile`""

	# Write command with argument to cmd script
	WriteCmdScript $myCommand
}

# Run function
FolderIterator -InputFolder $inputFolder -OutputFolder $outputFolder -inputFileType $inputFileType -inputFileType2 $inputFileType2

# Extreme hack method to execute part 3
# Write pause and exit at the end of cmd script
WriteCmdScript "pause"
WriteCmdScript "exit"

# Call explorer to simulate user double-click behavior
# Double click this damn cmd script
explorer "$CMD_SCRIPT_FILE"
exit