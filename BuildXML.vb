wscript.echo "BEGIN"

filePath = WScript.Arguments(0)
filePath = "C:\Phils Projects\fileBuilder\STM32F411.txt"
Set ObjFso = CreateObject("Scripting.FileSystemObject")
Set ObjFile = ObjFso.OpenTextFile(filePath)
StrData = ObjFile.ReadLine
wscript.echo "END OF FIRST PART"

Do Until StrData = EOF(ObjFile.ReadLine)
    wscript.echo StrData
    StrData = ObjFile.ReadLine
Loop

wscript.echo "END"