SuperStrict

Framework zeke.maxluajit

Import brl.standardio
Import brl.filesystem

Type TDemo
	Method SayHello:String(name:String)
		Print "Hello " + name + "! BlitzMax Rocks!"
	End Method
	
	Method LoadLuaSource:String(file:String)

		If FileType(file) <> 1 Return ""

		Local source:String = LoadText(file)

		Return source
		
	End Method
	
End Type

Local demo:TDemo = New TDemo
LuaRegisterObject(demo, "Demo")
Local luaFile:String = "object.lua"

Local source:String = demo.LoadLuaSource(luaFile)

Local class:TLuaClass = TLuaClass.Create(source)
Local instance:TLuaObject = TLuaObject.Create(class, Null)

If instance = Null
	Local debuginfo:String = "???"
	Print "Error: " + debuginfo
Else
	instance.Invoke "hello", Null
	instance.Invoke "goodbye", Null
EndIf
		

