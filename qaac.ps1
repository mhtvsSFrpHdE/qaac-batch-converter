# Preset argument
$inputFolder="C:\Program Files\7-zip"
$outputFolder="C:\Program Files\7-zip\out"
# Filter file extension name
$inputFileType=".tta"
# 2nd format, use only with rare situation
$inputFileType2=$inputFileType
# Const var write as upper case with underscore
# NOTE: There are three quote with the BIN variable
$QAAC_BIN = """C:\qaac.exe"""
$FFMPEG_BIN = """C:\ffmpeg.exe"""





$OUTPUT_FORMAT = ".m4a"
$HACK_CMD = "$outputFolder\qaac.cmd"

# Extreme hack method to execute part 1
# Write cmd script

# This meanless line to trigger a common type error
# But it can let cmd.exe ignore the unsupported UTF-8 "BOM"
"gUsJAzrtybEx" | Out-File -LiteralPath "$HACK_CMD" -Encoding UTF8
# So Windows XP doesn't really have a UTF-8 code page, will not work on that.
# Use 65001 code page to cover the non-ANSI file name.
"chcp 65001" | Add-Content -LiteralPath "$HACK_CMD" -Encoding UTF8

function DoSomethingFunction {
    param (
        $InputFile,
        $OutputFileName
    )

    # Filter Output file extension
    $OutputFile = $OutputFileName + $OUTPUT_FORMAT

    $myCommand = "$FFMPEG_BIN -i ""$InputFile"" -f wav pipe: | $QAAC_BIN --tvbr 127 -q 2 --no-optimize - -o ""$OutPutFile"""
	# Extreme hack method to execute part 2
	# Write command with argument to cmd script
	$myCommand | Add-Content -LiteralPath "$HACK_CMD" -Encoding UTF8
}

# Load folder itr function
. ".\folder-iterator.ps1"
# Run function
FolderIterator -SourceFolder $inputFolder -OutputFolder $outputFolder -inputFileType $inputFileType -inputFileType2 $inputFileType2

# Extreme hack method to execute part 3
# Write pause and exit at the end of cmd script
"pause" | Add-Content -LiteralPath "$HACK_CMD" -Encoding UTF8
"exit" | Add-Content -LiteralPath "$HACK_CMD" -Encoding UTF8

# Call explorer to simulate user double-click behavior
# Double click this damn cmd script
explorer "$HACK_CMD"
exit