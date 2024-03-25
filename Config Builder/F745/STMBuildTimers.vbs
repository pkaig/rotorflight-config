Const ForReading = 1
Dim file, content, line, AF1, AF2, AF3, AF4, AF5, AF6, AF9, AF10, AF11 , pin, newline
dim scriptDir, mcu

AF1 = "---------------"
AF2 = "---------------"
AF3 = "---------------"
AF4 = "---------------"
AF5 = "---------------"
AF6 = "---------------"
AF9 = "---------------"
AF10 = "---------------"
AF11 = "---------------"

scriptDir = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName) & "\"

Set fso = CreateObject("Scripting.FileSystemObject")
Set file = fso.OpenTextFile(scriptDir & "STM32_buildfile.txt", ForReading)

do until myLine = "# Status" 
	myLine = file.ReadLine
	line = line + 1
	if line > 100 Then
		WScript.echo "MCU not found. File not correct"
		WScript.Quit
	end if
loop

myLine = file.ReadLine
mcu = right(left(myLine,8),4)

outFile= scriptDir & "STM32_timers_" & mcu & ".txt"
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.CreateTextFile(outFile,True)

Do Until file.AtEndOfStream
	myLine = file.ReadLine
	line = left(myLine,6)
	  
	select case line
		case "# time"
			pin = right(left(myLine, 11),3)
		case "# AF1:"
			AF1 = right(myLine, len(myLine)-7) & " (AF1)"
		case "# AF2:"
			AF2 = right(myLine, len(myLine)-7) & " (AF2)"
		case "# AF3:"
			AF3 = right(myLine, len(myLine)-7) & " (AF3)"
		case "# AF4:"
			AF4 = right(myLine, len(myLine)-7) & " (AF4)"
		case "# AF5:"
			AF5 = right(myLine, len(myLine)-7) & " (AF5)"
		case "# AF6:"
			AF6 = right(myLine, len(myLine)-7) & " (AF6)"
		case "# AF9:"
			AF9 = right(myLine, len(myLine)-7) & " (AF9)"
		case "# AF10"
			AF10 = right(myLine, len(myLine)-8) & " (AF10)"
		case "# AF11"
			AF11 = right(myLine, len(myLine)-8) & " (AF11)"
		case else
			if pin <> "" then
				objFile.Write pin & vbTab & AF1 & vbTab & AF2 & vbTab & AF3 & vbTab & AF4 & vbTab & AF5 & vbTab & AF6 & vbTab & AF9 & vbTab & AF10 & vbTab & AF11 & vbCrLf 
			end if 
			pin = ""
			AF1 = "---------------"
			AF2 = "---------------"
			AF3 = "---------------"
			AF4 = "---------------"
			AF5 = "---------------"
			AF6 = "---------------"
			AF9 = "---------------"
			AF10 = "---------------"
			AF11 = "---------------"
			'WScript.Echo newline
	end select
Loop

objFile.Close
