SuperStrict

Framework zeke.luajit

Import brl.standardio

Global l:Byte Ptr = luaL_newstate()

luaL_openlibs(l)

Function LUA(file:String)
	If luaL_dofile(l , file) Then
		Print lua_tostring(l , - 1)
		End
	EndIf
End Function

Print "FFI:"
LUA("ffi.lua")

Print "~n~nMetaMethods:"
LUA("metamethods.lua")

Print "~n~nImage pixels:"
LUA("image.lua")

Print "~n~nImage pixels plain LUA:"
LUA("image_plain_lua.lua")

Print "~nSCIMARK:"
LUA("scimark.lua")

Print "~n~nMessagebox:"
LUA("messagebox.lua")


'WaitKey