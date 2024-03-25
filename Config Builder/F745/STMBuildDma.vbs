Const ForReading = 1
Dim file, DMAcontent, line, num, tabString, pin, dma0, dma1, dma2
dim scriptDir, mcu

DMAcontent = ""
newline = ""
num = 0
dma0 = ""
dma1 = ""
dma2 = ""

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

outFile= scriptDir & "STM32_dma_" & mcu & ".txt"
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.CreateTextFile(outFile,True)

Do Until file.AtEndOfStream
	myLine = file.ReadLine
		select case right(myLine, 4)
			case " AF1"
				num = 1

			case " AF2"
				num = 2

			case " AF3"
				num = 3
				
			case " AF4"
				num = 4
			
			case " AF5"
				num = 5
				
			case " AF6"
				num = 6

			case " AF9"
				num = 7
				
			case "AF10"
				num = 8
			
			case "AF11"
				num = 9

		end select
	
		select case left(myLine, 8)
			case "# dma pi"
				objFile.WriteLine pin & vbCrLf & dma0 & vbCrLf & dma1 & vbCrLf & dma2
				tabString = ""
				for i = 1 to num
					tabString = tabString & vbTab
				Next
				pin = tabString & right(left(myLine, 13), 11)
				dma0 = tabString & ""
				dma1 = tabString & ""
				dma2 = tabString & ""
				
			case "# 0: DMA"
				dma0 = tabString & right(myLine, len(myLine)-2)
			
			case "# 1: DMA"
				dma1 = tabString & right(myLine, len(myLine)-2)

			case "# 2: DMA"
				dma2 = tabString & right(myLine, len(myLine)-2)

			case else

		end select
	
Loop

objFile.Close
