SuperStrict

Framework zeke.luajit

Import brl.standardio

Global l:Byte Ptr = luaL_newstate()

luaL_openlibs(l)


If luaL_dofile(l , "mandelbrot.lua") Then 
	Print lua_tostring(l , - 1)
EndIf
