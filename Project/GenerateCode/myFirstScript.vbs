'==========================================================================
'
' VBScript Source File -- Created with SAPIEN Technologies PrimalScript 2011
'
' NAME: 
'
' AUTHOR: user , Litle & Co.
' DATE  : 4/6/2012
'
' COMMENT: 
'
'==========================================================================

Function GetFileContents(FullPath)
   	Dim fso, fileBeingRead, stringToReturn
   	Const ForReading = 1
   	Set fso = CreateObject("Scripting.FileSystemObject")
   	
   	' Read the contents of the file.
    Set fileBeingRead = fso.OpenTextFile(FullPath, ForReading)
   	Do Until fileBeingRead.AtEndOfStream
	   stringToReturn = Trim(stringToReturn & Trim(Replace(fileBeingRead.Readline, vbCrLf, "")))
	Loop
   	fileBeingRead.Close
    GetFileContents = stringToReturn
End Function

Function WriteFileContents(stringToWrite, filePathToWrite)
   Dim fso, fileToWrite
   Set fso = CreateObject("Scripting.FileSystemObject")
   Set fileToWrite = fso.CreateTextFile(filePathToWrite, True)
   ' Write the contents.
   fileToWrite.Write (stringToWrite)
   fileToWrite.Close
   WriteFileContents = filePathToWrite
End Function

Function EditTheXSDString(stringToEdit)
	Dim stringToReturn
	stringToReturn = Replace(stringToEdit, "<xs:choice><xs:sequence>", "<xs:sequence>")
	stringToReturn = Replace(stringToReturn, "</xs:sequence></xs:choice>", "</xs:sequence>")
	stringToReturn = Replace(stringToReturn, "</xs:sequence><xs:sequence>", "")
	stringToReturn = Replace(stringToReturn, "base64binary", "string")
	EditTheXSDString = stringToReturn
End Function

WScript.Echo "Hello World!"
Dim xmlFileFullContents, xmlFileEditedContents, editedXml, writeFilePath

xmlFileFullContents = GetFileContents("C:\\msysgit\\litle-sdk-for-dotNet\\Project\\GenerateCode\\GenerateCode\\xsd\\litleTransaction_v8.10.xsd")
editedXml = EditTheXSDString(xmlFileFullContents)
writeFilePath = WriteFileContents(editedXml, "C:\\msysgit\\litle-sdk-for-dotNet\\Project\\GenerateCode\\GenerateCode\\xsd\\litleTransaction_v8.10_arch.xsd")
WScript.Quit
