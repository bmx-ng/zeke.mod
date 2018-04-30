SuperStrict

Rem
bbdoc: LuaJIT
end rem
Module zeke.luajit

ModuleInfo "Version: 1.14"
ModuleInfo "Author: Zeke"

ModuleInfo "History: 1.14"
ModuleInfo "History: Fixed reflection issues."
ModuleInfo "History: 1.13"
ModuleInfo "History: Updated to LuaJIT 2.0.5"
ModuleInfo "History: V1.12"
ModuleInfo "History: Updated to LuaJIT 2.0.4"
ModuleInfo "History: Added 64-bit support."
ModuleInfo "History: V1.11 Release"
ModuleInfo "History: updated to LuaJIT 2.0.1"
ModuleInfo "History: V1.10 Release"
ModuleInfo "History: Stable LuaJIT 2.0.0 release"
ModuleInfo "History: V1.09 Release"
ModuleInfo "History: updated to LuaJIT 2.0.0-rc3"
ModuleInfo "History: V1.08 Release"
ModuleInfo "History: Updated to LUAJIT 2.0.0-rc2"
ModuleInfo "History: V1.07 Release"
ModuleInfo "History: Updated to LuaJIT 2.0.0-rc1"
ModuleInfo "History: V1.06 Release"
ModuleInfo "History: Updated to LuaJIT 2.0 beta 11"
ModuleInfo "History: V1.05 Release"
ModuleInfo "History: Updated to LuaJIT 2.0 beta 10"
ModuleInfo "History: V1.04 Release"
ModuleInfo "History: Updated to LuaJIT 2.0 beta 9"
ModuleInfo "History: V1.03 Release"
ModuleInfo "History: Updated to LuaJIT 2.0 beta 8"
ModuleInfo "History: V1.02 Release"
ModuleInfo "History: Updated to LuaJIT 2.0 beta 7"
ModuleInfo "History: v1.01 Release"
ModuleInfo "History: Updated to LuaJIT 2.0 beta 5"
ModuleInfo "History: 1.00 Release"
ModuleInfo "History: First release"



' linkage
?linuxx86
ModuleInfo "LD_OPTS: -L%PWD%/lib/linux"
Import "-lluajit_x86"
?linuxx64
ModuleInfo "LD_OPTS: -L%PWD%/lib/linux"
Import "-lluajit_x64"
?win32x86
ModuleInfo "LD_OPTS: -L%PWD%/lib/win32"
Import "-lluajit_x86"
?win32x64
ModuleInfo "LD_OPTS: -L%PWD%/lib/win32"
Import "-lluajit_x64"
?osxx86
ModuleInfo "LD_OPTS: -L%PWD%/lib/macos"
Import "-lluajit_x86"
?osxx64
ModuleInfo "LD_OPTS: -L%PWD%/lib/macos"
ModuleInfo "LD_OPTS: -pagezero_size 10000 -image_base 100000000"
Import "-lluajit_x64"
?ios
ModuleInfo "LD_OPTS: -L%PWD%/lib/ios"
?raspberrypi
ModuleInfo "LD_OPTS: -L%PWD%/lib/linux"
?

?linux
Import "-ldl"
?

' source

Import "luajit/src/*.h"
Import "glue.c"







' ******************************************************************************
' *                                                                            *
' *                            Constant Definitions                            *
' *                                                                            *
' ******************************************************************************

  Const LUA_IDSIZE:Int = 1024

' **** (lua.h) some basic definitions - just to be complete ****

  Const LUA_VERSION:String   = "Lua 5.1"
  Const LUA_RELEASE:String   = "Lua 5.1.4"
  Const LUA_VERSION_NUM:Int  = 501
  Const LUA_COPYRIGHT:String = "Copyright (C) 1994-2008 Lua.org, PUC-Rio"
  Const LUA_AUTHORS:String   = "R. Ierusalimschy, L. H. de Figueiredo & W. Celes"

' **** (lua.h) option for multiple returns in `lua_pcall' and `lua_call' ****

  Const LUA_MULTRET:Int = -1

' **** (lua.h) pseudo-indices ****

  Const LUA_REGISTRYINDEX:Int = -10000
  Const LUA_ENVIRONINDEX:Int  = -10001
  Const LUA_GLOBALSINDEX:Int  = -10002

' **** (lua.h) thread status (0 is OK) ****

  Const LUA_YIELD_:Int    = 1   ' added _ after LUA_YIELD because of lua_yield function
  Const LUA_ERRRUN:Int    = 2
  Const LUA_ERRSYNTAX:Int = 3
  Const LUA_ERRMEM:Int    = 4
  Const LUA_ERRERR:Int    = 5

' **** (lua.h) basic types ****

  Const LUA_TNONE:Int          = -1
  Const LUA_TNIL:Int           =  0
  Const LUA_TBOOLEAN:Int       =  1
  Const LUA_TLIGHTUSERDATA:Int =  2
  Const LUA_TNUMBER:Int        =  3
  Const LUA_TSTRING:Int        =  4
  Const LUA_TTABLE:Int         =  5
  Const LUA_TFUNCTION:Int      =  6
  Const LUA_TUSERDATA:Int      =  7
  Const LUA_TTHREAD:Int        =  8

' **** (lua.h) garbage-collection options ****

  Const LUA_GCSTOP:Int = 0
  Const LUA_GCRESTART:Int    = 1
  Const LUA_GCCOLLECT:Int    = 2
  Const LUA_GCCOUNT:Int      = 3
  Const LUA_GCCOUNTB:Int     = 4
  Const LUA_GCSTEP:Int       = 5
  Const LUA_GCSETPAUSE:Int = 6
  Const LUA_GCSETSTEPMUL:Int = 7

' **** (lua.h) event codes ****

  Const LUA_HOOKCALL:Int    = 0
  Const LUA_HOOKRET:Int     = 1
  Const LUA_HOOKLINE:Int    = 2
  Const LUA_HOOKCOUNT:Int   = 3
  Const LUA_HOOKTAILRET:Int = 4

' **** (lua.h) event masks ****

  Const LUA_MASKCALL:Int  = (1 Shl LUA_HOOKCALL)
  Const LUA_MASKRET:Int   = (1 Shl LUA_HOOKRET)
  Const LUA_MASKLINE:Int  = (1 Shl LUA_HOOKLINE)
  Const LUA_MASKCOUNT:Int = (1 Shl LUA_HOOKCOUNT)

	Const LUAJIT_MODE_ENGINE:Int 	 	 = 0 'Set mode for whole JIT engine.
	Const LUAJIT_MODE_DEBUG:Int 		 	 = 1 'Set debug mode (idx = level).
	
	Const LUAJIT_MODE_FUNC:Int 			 = 2 'Change mode for a function.
	Const LUAJIT_MODE_ALLFUNC:Int		 = 3 'Recurse into subroutine protos.
	Const LUAJIT_MODE_ALLSUBFUNC:Int	 = 4 'Change only the subroutines.
	
	
	Const LUAJIT_MODE_TRACE:Int 			 = 5 'Flush a compiled trace.
	
	Const LUAJIT_MODE_WRAPFUNC:Int 		 = $10 'Set wrapper mode for C function calls.
	
	Const LUAJIT_MODE_MAX:Int 			 = $11
	

	Const LUAJIT_MODE_OFF:Int		 = 0
	Const LUAJIT_MODE_ON:Int		 = $100
	Const LUAJIT_MODE_FLUSH:Int	 = $200
	
	

' ******************************************************************************
' *                                                                            *
' *                          The Lua API (Functions)                           *
' *                                                                            *
' ******************************************************************************

Extern

Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_atpanic">Lua Reference Manual</a>
end rem
  Function lua_atpanic:Byte Ptr (lua_state:Byte Ptr, panicf:Int(ls:Byte Ptr))
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_call">Lua Reference Manual</a>
end rem
  Function lua_call (lua_state:Byte Ptr, nargs:Int, nresults:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_checkstack">Lua Reference Manual</a>
end rem
  Function lua_checkstack:Int (lua_state:Byte Ptr, extra:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_close">Lua Reference Manual</a>
end rem
  Function lua_close (lua_state:Byte Ptr)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_concat">Lua Reference Manual</a>
end rem
  Function lua_concat (lua_state:Byte Ptr, n:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_cpcall">Lua Reference Manual</a>
end rem
  Function lua_cpcall:Int (lua_state:Byte Ptr, func:Int(ls:Byte Ptr), ud:Byte Ptr)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_createtable">Lua Reference Manual</a>
end rem
  Function lua_createtable (lua_state:Byte Ptr, narr:Int, nrec:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_dump">Lua Reference Manual</a>
end rem
?Not bmxng
  Function lua_dump:Int (lua_state:Byte Ptr, writer:Int(ls:Byte Ptr,p:Byte Ptr,sz:Int,ud:Byte Ptr), data:Byte Ptr)
?bmxng
  Function lua_dump:Int (lua_state:Byte Ptr, writer:Int(ls:Byte Ptr,p:Byte Ptr,sz:Size_T,ud:Byte Ptr), data:Byte Ptr)
?
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_equal">Lua Reference Manual</a>
end rem
  Function lua_equal:Int (lua_state:Byte Ptr, index1:Int, index2:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_error">Lua Reference Manual</a>
end rem
  Function lua_error:Int (lua_state:Byte Ptr)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_gc">Lua Reference Manual</a>
end rem
  Function lua_gc:Int (lua_state:Byte Ptr, what:Int, data:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_getallocf">Lua Reference Manual</a>
end rem
  Function lua_getallocf:Byte Ptr (lua_state:Byte Ptr, ud:Byte Ptr Ptr)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_getfenv">Lua Reference Manual</a>
end rem
  Function lua_getfenv (lua_state:Byte Ptr, index:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_getfield">Lua Reference Manual</a>
end rem
  Function lua_getfield (lua_state:Byte Ptr, index:Int, k$z)              ' no ~0 expected
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_gethook">Lua Reference Manual</a>
end rem
  Function lua_gethook:Byte Ptr (lua_state:Byte Ptr)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_gethookcount">Lua Reference Manual</a>
end rem
  Function lua_gethookcount:Int (lua_state:Byte Ptr)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_gethookmask">Lua Reference Manual</a>
end rem
  Function lua_gethookmask:Int (lua_state:Byte Ptr)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_getmetatable">Lua Reference Manual</a>
end rem
  Function lua_getmetatable:Int (lua_state:Byte Ptr, index:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_gettable">Lua Reference Manual</a>
end rem
  Function lua_gettable (lua_state:Byte Ptr, index:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_gettop">Lua Reference Manual</a>
end rem
  Function lua_gettop:Int (lua_state:Byte Ptr)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_getupvalue">Lua Reference Manual</a>
end rem
  Function lua_getupvalue$z (lua_state:Byte Ptr, funcindex:Int, n:Int)        ' no ~0 expected
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_insert">Lua Reference Manual</a>
end rem
  Function lua_insert (lua_state:Byte Ptr, index:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_iscfunction">Lua Reference Manual</a>
end rem
  Function lua_iscfunction:Int (lua_state:Byte Ptr, index:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_isnumber">Lua Reference Manual</a>
end rem
  Function lua_isnumber:Int (lua_state:Byte Ptr, index:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_isstring">Lua Reference Manual</a>
end rem
  Function lua_isstring:Int (lua_state:Byte Ptr, index:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_isuserdata">Lua Reference Manual</a>
end rem
  Function lua_isuserdata:Int (lua_state:Byte Ptr, index:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_lessthan">Lua Reference Manual</a>
end rem
  Function lua_lessthan:Int (lua_state:Byte Ptr, index1:Int, index2:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_load">Lua Reference Manual</a>
end rem
?Not bmxng
  Function lua_load:Int (lua_state:Byte Ptr, reader:Byte Ptr(ls:Byte Ptr,data:Byte Ptr,sz:Int Ptr), data:Byte Ptr, chunkname$z) ' no ~0 expected
?bmxng
  Function lua_load:Int (lua_state:Byte Ptr, reader:Byte Ptr(ls:Byte Ptr,data:Byte Ptr,sz:Size_T Ptr), data:Byte Ptr, chunkname$z) ' no ~0 expected
?
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_newstate">Lua Reference Manual</a>
end rem
?Not bmxng
  Function lua_newstate:Byte Ptr (f:Byte Ptr(ud:Byte Ptr, p:Byte Ptr, osize:Int, nsize:Int), ud:Byte Ptr)
?bmxng
  Function lua_newstate:Byte Ptr (f:Byte Ptr(ud:Byte Ptr, p:Byte Ptr, osize:Size_T, nsize:Size_T), ud:Byte Ptr)
?
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_newthread">Lua Reference Manual</a>
end rem
  Function lua_newthread:Byte Ptr (lua_state:Byte Ptr)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_newuserdata">Lua Reference Manual</a>
end rem
?Not bmxng
  Function lua_newuserdata:Byte Ptr (lua_state:Byte Ptr, size:Int)
?bmxng
  Function lua_newuserdata:Byte Ptr (lua_state:Byte Ptr, size:Size_T)
?
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_next">Lua Reference Manual</a>
end rem
  Function lua_next:Int (lua_state:Byte Ptr, index:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_objlen">Lua Reference Manual</a>
end rem
?Not bmxng
  Function lua_objlen:Int (lua_state:Byte Ptr, index:Int)
?bmxng
  Function lua_objlen:Size_T (lua_state:Byte Ptr, index:Int)
?
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_pcall">Lua Reference Manual</a>
end rem
  Function lua_pcall:Int (lua_state:Byte Ptr, nargs:Int, nresults:Int, errfunc:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_pushboolean">Lua Reference Manual</a>
end rem
  Function lua_pushboolean (lua_state:Byte Ptr, b:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_pushcclosure">Lua Reference Manual</a>
end rem
  Function lua_pushcclosure (lua_state:Byte Ptr, fn:Int(ls:Byte Ptr), n:Int)
' function lua_pushfstring$z (lua_state:byte ptr, fmt$z, ...)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_pushinteger">Lua Reference Manual</a>
end rem
  Function lua_pushinteger (lua_state:Byte Ptr, n:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_pushlightuserdata">Lua Reference Manual</a>
end rem
  Function lua_pushlightuserdata (lua_state:Byte Ptr, p:Byte Ptr)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_pushlstring">Lua Reference Manual</a>
end rem
?Not bmxng
  Function lua_pushlstring (lua_state:Byte Ptr, s:Byte Ptr, size:Int)    ' without any conversion!
?bmxng
  Function lua_pushlstring (lua_state:Byte Ptr, s:Byte Ptr, size:Size_T)    ' without any conversion!
?
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_pushnil">Lua Reference Manual</a>
end rem
  Function lua_pushnil (lua_state:Byte Ptr)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_pushnumber">Lua Reference Manual</a>
end rem
  Function lua_pushnumber (lua_state:Byte Ptr, n:Double)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_pushstring">Lua Reference Manual</a>
end rem
  Function lua_pushstring (lua_state:Byte Ptr, s$z)                         ' no ~0 expected
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_pushthread">Lua Reference Manual</a>
end rem
  Function lua_pushthread:Int (lua_state:Byte Ptr)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_pushvalue">Lua Reference Manual</a>
end rem
  Function lua_pushvalue (lua_state:Byte Ptr, index:Int)
' function lua_pushvfstring$z (lua_state:byte ptr, fmt$z, argp:???)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_rawequal">Lua Reference Manual</a>
end rem
  Function lua_rawequal:Int (lua_state:Byte Ptr, index1:Int, index2:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_rawget">Lua Reference Manual</a>
end rem
  Function lua_rawget (lua_state:Byte Ptr, index:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_rawgeti">Lua Reference Manual</a>
end rem
  Function lua_rawgeti (lua_state:Byte Ptr, index:Int, n:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_rawset">Lua Reference Manual</a>
end rem
  Function lua_rawset (lua_state:Byte Ptr, index:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_rawseti">Lua Reference Manual</a>
end rem
  Function lua_rawseti (lua_state:Byte Ptr, index:Int, n:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_remove">Lua Reference Manual</a>
end rem
  Function lua_remove (lua_state:Byte Ptr, index:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_replace">Lua Reference Manual</a>
end rem
  Function lua_replace (lua_state:Byte Ptr, index:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_resume">Lua Reference Manual</a>
end rem
  Function lua_resume:Int (lua_state:Byte Ptr, narg:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_setallocf">Lua Reference Manual</a>
end rem
?Not bmxng
  Function lua_setallocf (lua_state:Byte Ptr, f:Byte Ptr(ud:Byte Ptr, p:Byte Ptr, osize:Int, nsize:Int), ud:Byte Ptr)
?bmxng
  Function lua_setallocf (lua_state:Byte Ptr, f:Byte Ptr(ud:Byte Ptr, p:Byte Ptr, osize:Size_T, nsize:Size_T), ud:Byte Ptr)
?
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_setfenv">Lua Reference Manual</a>
end rem
  Function lua_setfenv:Int (lua_state:Byte Ptr, index:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_setfield">Lua Reference Manual</a>
end rem
  Function lua_setfield (lua_state:Byte Ptr, index:Int, k$z)              ' no ~0 expected
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_setmetatable">Lua Reference Manual</a>
end rem
  Function lua_setmetatable:Int (lua_state:Byte Ptr, index:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_settable">Lua Reference Manual</a>
end rem
  Function lua_settable (lua_state:Byte Ptr, index:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_settop">Lua Reference Manual</a>
end rem
  Function lua_settop (lua_state:Byte Ptr, index:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_setupvalue">Lua Reference Manual</a>
end rem
  Function lua_setupvalue$z (lua_state:Byte Ptr, funcindex:Int, n:Int)        ' no ~0 expected
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_status">Lua Reference Manual</a>
end rem
  Function lua_status:Int (lua_state:Byte Ptr)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_toboolean">Lua Reference Manual</a>
end rem
  Function lua_toboolean:Int (lua_state:Byte Ptr, index:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_tocfunction">Lua Reference Manual</a>
end rem
  Function lua_tocfunction:Byte Ptr (lua_state:Byte Ptr, index:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_tointeger">Lua Reference Manual</a>
end rem
  Function lua_tointeger:Int (lua_state:Byte Ptr, index:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_tolstring">Lua Reference Manual</a>
End Rem
?Not bmxng
  Function lua_tolstring:Byte Ptr (lua_state:Byte Ptr, index:Int, size:Int Ptr) ' without any conversion!
?bmxng
  Function lua_tolstring:Byte Ptr (lua_state:Byte Ptr, index:Int, size:Size_T Ptr) ' without any conversion!
?
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_tonumber">Lua Reference Manual</a>
end rem
  Function lua_tonumber:Double (lua_state:Byte Ptr, index:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_topointer">Lua Reference Manual</a>
end rem
  Function lua_topointer:Byte Ptr (lua_state:Byte Ptr, index:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_tothread">Lua Reference Manual</a>
end rem
  Function lua_tothread:Byte Ptr (lua_state:Byte Ptr, index:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_touserdata">Lua Reference Manual</a>
end rem
  Function lua_touserdata:Byte Ptr (lua_state:Byte Ptr, index:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_type">Lua Reference Manual</a>
end rem
  Function lua_type:Int (lua_state:Byte Ptr, index:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_typename">Lua Reference Manual</a>
end rem
  Function lua_typename$z (lua_state:Byte Ptr, tp:Int)                      ' no ~0 expected
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_xmove">Lua Reference Manual</a>
end rem
  Function lua_xmove                (fromState:Byte Ptr, toState:Byte Ptr, n:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_yield">Lua Reference Manual</a>
end rem
  Function lua_yield:Int (lua_state:Byte Ptr, nresults:Int)

	'## LuaJIT functions ##
	
Rem
bbdoc: see <a href="../../../../mod/zeke.mod/luajit2.mod/LuaJIT-2.0.0/doc/api.html#luaJIT_setmode">LuaJIT doc</a>
end rem
	Function luaJIT_setmode:Int(lua_state:Byte Ptr , idx:Int , Mode:Int)
End Extern


' ******************************************************************************
' *                                                                            *
' *                            The Lua Debugger API                            *
' *                                                                            *
' ******************************************************************************

Type lua_Debug

	Field debugPtr:Byte Ptr

	Method New()
		debugPtr = bmx_luajit_lua_Debug_new()
	End Method
	
	Method event:Int()
		Return bmx_luajit_lua_Debug_event(debugPtr)
	End Method
	
	Method name:String()                                         ' no ~0 expected
		Return bmx_luajit_lua_Debug_name(debugPtr)
	End Method
	
	Method namewhat:String()                                               ' dto.
		Return bmx_luajit_lua_Debug_namewhat(debugPtr)
	End Method

	Method what:String()                                                   ' dto.
		Return bmx_luajit_lua_Debug_what(debugPtr)
	End Method

	Method source:String()                                                 ' dto.
		Return bmx_luajit_lua_Debug_source(debugPtr)
	End Method

	Method currentline:Int()
		Return bmx_luajit_lua_Debug_currentline(debugPtr)
	End Method

	Method nups:Int()
		Return bmx_luajit_lua_Debug_nups(debugPtr)
	End Method

	Method linedefined:Int()
		Return bmx_luajit_lua_Debug_linedefined(debugPtr)
	End Method

	Method lastlinedefined:Int()
		Return bmx_luajit_lua_Debug_lastlinedefined(debugPtr)
	End Method

	Method short_src:Byte Ptr()
		Return bmx_luajit_lua_Debug_short_src(debugPtr)
	End Method
	
	Method Delete()
		If debugPtr Then
			bmx_luajit_lua_Debug_free(debugPtr)
			debugPtr = Null
		End If
	End Method
End Type

Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_getinfo">Lua Reference Manual</a>
End Rem
Function lua_getinfo:Int (lua_state:Byte Ptr, what:String, ar:lua_Debug)    ' no ~0 expected
End Function
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_getlocal">Lua Reference Manual</a>
End Rem
Function lua_getlocal:String(lua_state:Byte Ptr, ar:lua_Debug Var, n:Int)     ' no ~0 expected
End Function
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_getstack">Lua Reference Manual</a>
End Rem
Function lua_getstack:Int (lua_state:Byte Ptr, level:Int, ar:lua_Debug) ' no ~0 expected
End Function
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_sethook">Lua Reference Manual</a>
End Rem
Function lua_sethook:Int (lua_state:Byte Ptr, f(ls:Byte Ptr,ar:lua_Debug), mask:Int, count:Int)
End Function
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_setlocal">Lua Reference Manual</a>
End Rem
Function lua_setlocal:String(lua_state:Byte Ptr, ar:lua_Debug, n:Int)     ' no ~0 expected
End Function

' ******************************************************************************
' *                                                                            *
' *                            The Lua API (Macros)                            *
' *                                                                            *
' ******************************************************************************

Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_getglobal">Lua Reference Manual</a>
end rem
  Function lua_getglobal (lua_state:Byte Ptr, name:String)
    lua_getfield(lua_state, LUA_GLOBALSINDEX, name)
  End Function

Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_isboolean">Lua Reference Manual</a>
end rem
  Function lua_isboolean:Int (lua_state:Byte Ptr, index:Int)
    Return (lua_type(lua_state,index) = LUA_TBOOLEAN)
  End Function

Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_isfunction">Lua Reference Manual</a>
end rem
  Function lua_isfunction:Int (lua_state:Byte Ptr, index:Int)
    Return (lua_type(lua_state,index) = LUA_TFUNCTION)
  End Function

Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_islightuserdata">Lua Reference Manual</a>
end rem
  Function lua_islightuserdata:Int (lua_state:Byte Ptr, index:Int)
    Return (lua_type(lua_state,index) = LUA_TLIGHTUSERDATA)
  End Function

Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_isnil">Lua Reference Manual</a>
end rem
  Function lua_isnil:Int (lua_state:Byte Ptr, index:Int)
    Return (lua_type(lua_state,index) = LUA_TNIL)
  End Function

Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_isnone">Lua Reference Manual</a>
end rem
  Function lua_isnone:Int (lua_state:Byte Ptr, index:Int)
    Return (lua_type(lua_state,index) = LUA_TNONE)
  End Function

Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_isnoneornil">Lua Reference Manual</a>
end rem
  Function lua_isnoneornil:Int (lua_state:Byte Ptr, index:Int)
    Return (lua_type(lua_state,index) <= 0)
  End Function

Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_istable">Lua Reference Manual</a>
end rem
  Function lua_istable:Int (lua_state:Byte Ptr, index:Int)
    Return (lua_type(lua_state,index) = LUA_TTABLE)
  End Function

Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_isthread">Lua Reference Manual</a>
end rem
  Function lua_isthread:Int (lua_state:Byte Ptr, index:Int)
    Return (lua_type(lua_state,index) = LUA_TTHREAD)
  End Function

Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_newtable">Lua Reference Manual</a>
end rem
  Function lua_newtable (lua_state:Byte Ptr)
    lua_createtable(lua_state,0,0)
  End Function

Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_pop">Lua Reference Manual</a>
end rem
  Function lua_pop (lua_state:Byte Ptr, n:Int)
    lua_settop(lua_state,-(n)-1)
  End Function

  Function lua_pushbytearray (lua_state:Byte Ptr, Buffer:Byte[])
    lua_pushlstring(lua_state, Varptr Buffer[0], Size_T(Buffer.length))
  End Function

Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_pushcfunction">Lua Reference Manual</a>
end rem
  Function lua_pushcfunction (lua_state:Byte Ptr, fn:Int(ls:Byte Ptr))
    lua_pushcclosure(lua_state, fn, 0)
  End Function

Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_register">Lua Reference Manual</a>
end rem
  Function lua_register (lua_state:Byte Ptr, name:String, f:Int(ls:Byte Ptr))
    lua_pushcfunction(lua_state, f)
    lua_setglobal    (lua_state, name)
  End Function

Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_setglobal">Lua Reference Manual</a>
end rem
  Function lua_setglobal (lua_state:Byte Ptr, name:String)
    lua_setfield(lua_state, LUA_GLOBALSINDEX, name)
  End Function

  Function lua_tobytearray:Byte[] (lua_state:Byte Ptr, index:Int)
?bmxng
    Local Length:Size_T
?Not bmxng
   	Local Length:Int
?
    Local DataPtr:Byte Ptr = lua_tolstring(lua_state, index, Varptr Length)
    If DataPtr = Null Then
      Return Null
    Else
      Local Result:Byte[] = New Byte[Length]
?bmxng
      MemCopy(Varptr Result[0], DataPtr, Size_T(Length))
?Not bmxng
      MemCopy(Varptr Result[0], DataPtr, Length)
?
      Return Result
    End If
  End Function

Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#lua_tostring">Lua Reference Manual</a>
end rem
  Function lua_tostring:String (lua_state:Byte Ptr, index:Int)
?bmxng
    Local Length:Size_T
?Not bmxng
   	Local Length:Int
?
    Local StringPtr:Byte Ptr = lua_tolstring(lua_state, index, Varptr Length)
    	If StringPtr = Null Then
      Return Null
    Else
    	  Return String.fromBytes(StringPtr,Int(Length))
    End If
  End Function

' ******************************************************************************
' *                                                                            *
' *                     The Auxiliary Library (Functions)                      *
' *                                                                            *
' ******************************************************************************

Extern
?bmxng
  Struct lua_Reg
?Not bmxng
  Type lua_Reg
?
    Field name:Byte Ptr                                         ' no ~0 expected
    Field func:Int(ls:Byte Ptr)
?bmxng
  End Struct
?Not bmxng
  End Type
?
End Extern

Extern
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_addlstring">Lua Reference Manual</a>
end rem
?Not bmxng
  Function luaL_addlstring (B:Byte Ptr, s:Byte Ptr, l:Int)
?bmxng
  Function luaL_addlstring (B:Byte Ptr, s:Byte Ptr, l:Size_T)
?
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_addsize">Lua Reference Manual</a>
end rem
  Function luaL_addsize (B:Byte Ptr, size:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_addstring">Lua Reference Manual</a>
end rem
  Function luaL_addstring (B:Byte Ptr, s$z)                                 ' no ~0 allowed!
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_addvalue">Lua Reference Manual</a>
end rem
  Function luaL_addvalue (B:Byte Ptr)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_argerror">Lua Reference Manual</a>
end rem
  Function luaL_argerror:Int (lua_state:Byte Ptr, narg:Int, extramsg$z)     ' no ~0 expected
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_buffinit">Lua Reference Manual</a>
end rem
  Function luaL_buffinit (lua_state:Byte Ptr, B:Byte Ptr)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_callmeta">Lua Reference Manual</a>
end rem
  Function luaL_callmeta:Int (lua_state:Byte Ptr, obj:Int, e$z)             ' no ~0 expected
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_checkany">Lua Reference Manual</a>
end rem
  Function luaL_checkany (lua_state:Byte Ptr, narg:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_checkinteger">Lua Reference Manual</a>
end rem
  Function luaL_checkinteger:Int (lua_state:Byte Ptr, narg:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_checklstring">Lua Reference Manual</a>
end rem
?Not bmxng
  Function luaL_checklstring:Byte Ptr (lua_state:Byte Ptr, narg:Int, size:Int Ptr)
?bmxng
  Function luaL_checklstring:Byte Ptr (lua_state:Byte Ptr, narg:Int, size:Size_T Ptr)
?
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_checknumber">Lua Reference Manual</a>
end rem
  Function luaL_checknumber:Double (lua_state:Byte Ptr, narg:Int)
' function luaL_checkoption:int (lua_state:byte ptr, narg:int, def$z, lst$z[])
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_checkstack">Lua Reference Manual</a>
end rem
  Function luaL_checkstack (lua_state:Byte Ptr, sz:Int, msg$z)                     ' no ~0 expected
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_checktype">Lua Reference Manual</a>
end rem
  Function luaL_checktype (lua_state:Byte Ptr, narg:Int, t:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_checkudata">Lua Reference Manual</a>
end rem
  Function luaL_checkudata:Byte Ptr (lua_state:Byte Ptr, narg:Int, tname$z)        ' no ~0 expected
' function luaL_error:int (lua_state:byte ptr, fmt$z, ...)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_getmetafield">Lua Reference Manual</a>
end rem
  Function luaL_getmetafield:Int (lua_state:Byte Ptr, obj:Int, e$z)                ' no ~0 expected
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_gsub">Lua Reference Manual</a>
end rem
  Function luaL_gsub$z (lua_state:Byte Ptr, s$z, p$z, r$z)                         ' no ~0 expected
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_loadbuffer">Lua Reference Manual</a>
end rem
  Function luaL_loadbuffer:Int (lua_state:Byte Ptr, buff:Byte Ptr, sz:Int, name$z) ' no ~0 expected
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_loadfile">Lua Reference Manual</a>
end rem
  Function luaL_loadfile:Int (lua_state:Byte Ptr, filename$z)                      ' no ~0 expected
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_loadstring">Lua Reference Manual</a>
end rem
  Function luaL_loadstring:Int (lua_state:Byte Ptr, s$z)                           ' no ~0 allowed!
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_newmetatable">Lua Reference Manual</a>
end rem
  Function luaL_newmetatable:Int (lua_state:Byte Ptr, tname$z)                     ' no ~0 expected
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_newstate">Lua Reference Manual</a>
end rem
  Function luaL_newstate:Byte Ptr ()
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_openlibs">Lua Reference Manual</a>
end rem
  Function luaL_openlibs (lua_state:Byte Ptr)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_optinteger">Lua Reference Manual</a>
end rem
  Function luaL_optinteger:Int (lua_state:Byte Ptr, narg:Int, d:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_optlstring">Lua Reference Manual</a>
end rem
?Not bmxng
  Function luaL_optlstring:Byte Ptr (lua_state:Byte Ptr, narg:Int, d$z, size:Int Ptr) ' no ~0 expected in "d"
?bmxng
  Function luaL_optlstring:Byte Ptr (lua_state:Byte Ptr, narg:Int, d$z, size:Size_T Ptr) ' no ~0 expected in "d"
?
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_optnumber">Lua Reference Manual</a>
end rem
  Function luaL_optnumber:Double (lua_state:Byte Ptr, narg:Int, d:Double)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_prepbuffer">Lua Reference Manual</a>
end rem
  Function luaL_prepbuffer:Byte Ptr (B:Byte Ptr)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_pushresult">Lua Reference Manual</a>
end rem
  Function luaL_pushresult (B:Byte Ptr)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_ref">Lua Reference Manual</a>
end rem
  Function luaL_ref:Int (lua_state:Byte Ptr, t:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_register">Lua Reference Manual</a>
end rem
  Function luaL_register (lua_state:Byte Ptr, libname$z, l:lua_Reg Ptr)            ' no ~0 expected
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_typerror">Lua Reference Manual</a>
end rem
  Function luaL_typerror:Int (lua_state:Byte Ptr, narg:Int, tname$z)               ' no ~0 expected
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_unref">Lua Reference Manual</a>
end rem
  Function luaL_unref (lua_state:Byte Ptr, t:Int, ref:Int)
Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_where">Lua Reference Manual</a>
end rem
  Function luaL_where (lua_state:Byte Ptr, lvl:Int)
End Extern

' ******************************************************************************
' *                                                                            *
' *                       The Auxiliary Library (Macros)                       *
' *                                                                            *
' ******************************************************************************

Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_addchar">Lua Reference Manual</a>
end rem
  Function luaL_addchar (B:Byte Ptr, c:String)
'    luaL_addstring(B,Left$(c,1))     ' not really efficient, just to be complete
	luaL_addstring( B,c[..Min(c.Length,1)] )	'functionally equivalent?
  End Function

Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_argcheck">Lua Reference Manual</a>
end rem
  Function luaL_argcheck (lua_state:Byte Ptr, cond:Int, narg:Int, extramsg:String)
    If (Not cond) Then luaL_argerror(lua_state, narg, extramsg)
  End Function

Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_checkint">Lua Reference Manual</a>
end rem
  Function luaL_checkint:Int (lua_state:Byte Ptr, narg:Int)
    Return Int(luaL_checkinteger(lua_state, narg))   ' Lua itself does the same!
  End Function

Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_checklong">Lua Reference Manual</a>
end rem
  Function luaL_checklong:Long (lua_state:Byte Ptr, narg:Int)
    Return luaL_checkinteger(lua_state, narg)
  End Function

Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_checkstring">Lua Reference Manual</a>
end rem
  Function luaL_checkstring:String (lua_state:Byte Ptr, narg:Int)
?Not bmxng
    Local Size:Int
    Local StringPtr:Byte Ptr = luaL_checklstring(lua_state, narg, Varptr Size)
?bmxng
    Local Size:Size_T
    Local StringPtr:Byte Ptr = luaL_checklstring(lua_state, narg, Varptr Size)
?
    If (StringPtr = Null) Then
      Return Null
    Else
      Return String.fromBytes(StringPtr,Int(Size))
    End If
  End Function

Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_dofile">Lua Reference Manual</a>
end rem
  Function luaL_dofile:Int (lua_state:Byte Ptr, filename:String)
    If (luaL_loadfile(lua_state,filename) <> 0) Then
      Return 1
    Else
      Return lua_pcall(lua_state, 0, LUA_MULTRET, 0)
    End If
  End Function

Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_dostring">Lua Reference Manual</a>
end rem
  Function luaL_dostring:Int (lua_state:Byte Ptr, str:String)
    If (luaL_loadstring(lua_state,str) <> 0) Then
      Return 1
    Else
      Return lua_pcall(lua_state, 0, LUA_MULTRET, 0)
    End If
  End Function

Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_getmetatable">Lua Reference Manual</a>
end rem
  Function luaL_getmetatable (lua_state:Byte Ptr, tname:String)
    lua_getfield(lua_state, LUA_REGISTRYINDEX, tname)
  End Function

Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_optint">Lua Reference Manual</a>
end rem
  Function luaL_optint:Int (lua_state:Byte Ptr, narg:Int, d:Int)
    Return luaL_optinteger(lua_state, narg, d)
  End Function

Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_optlong">Lua Reference Manual</a>
end rem
  Function luaL_optlong:Long (lua_state:Byte Ptr, narg:Int, d:Long)
    If ((Abs(narg) > lua_gettop(lua_state)) Or lua_isnil(lua_state,narg)) Then
      Return d
    Else
      Return luaL_checklong(lua_state,narg)
    End If
  End Function

Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_optstring">Lua Reference Manual</a>
end rem
  Function luaL_optstring:String (lua_state:Byte Ptr, narg:Int, d:String)
?Not bmxng
    Local Size:Int
    Local StringPtr:Byte Ptr = luaL_optlstring(lua_state, narg, d, Varptr Size)
?bmxng
    Local Size:Size_T
    Local StringPtr:Byte Ptr = luaL_optlstring(lua_state, narg, d, Varptr Size)
?
    If (StringPtr = Null) Then
      Return Null
    Else
      Return String.fromBytes(StringPtr,Int(Size))
    End If
  End Function

Rem
bbdoc: see <a href="../../../../mod/pub.mod/lua.mod/lua-5.1.4/doc/manual.html#luaL_typename">Lua Reference Manual</a>
end rem
  Function luaL_typename:String (lua_state:Byte Ptr, idx:Int)
    Return lua_typename(lua_state, lua_type (lua_state,idx))
  End Function


' ******************************************************************************
' *                                                                            *
' *     compatibility extensions (not to break existing axe.lua programs)      *
' *                                                                            *
' ******************************************************************************

Extern
  Function luaopen_base:Int    (lua_state:Byte Ptr)
  Function luaopen_debug:Int   (lua_state:Byte Ptr)
  Function luaopen_io:Int      (lua_state:Byte Ptr)
  Function luaopen_math:Int    (lua_state:Byte Ptr)
  Function luaopen_os:Int      (lua_state:Byte Ptr)
  Function luaopen_package:Int (lua_state:Byte Ptr)
  Function luaopen_string:Int  (lua_state:Byte Ptr)
  Function luaopen_table:Int (lua_state:Byte Ptr)
  Function luaopen_jit:Int		(lua_state:Byte Ptr)
End Extern

  Function lua_dobuffer:Int (lua_state:Byte Ptr, buff:String, sz:Int, name:String)
    If (luaL_loadbuffer(lua_state,buff,sz,name) <> 0) Then
      Return 1
    Else
      Return lua_pcall(lua_state, 0, LUA_MULTRET, 0)
    End If
  End Function

  Function lua_dofile:Int (lua_state:Byte Ptr, filename:String)
    Return luaL_dofile(lua_state,filename)
  End Function

  Function lua_dostring:Int (lua_state:Byte Ptr, str:String)
    Return luaL_dostring(lua_state,str)
  End Function

  Function lua_strlen:Int (lua_state:Byte Ptr, index:Int)
    Return lua_objlen(lua_state,index)
  End Function
	

Extern
	Function bmx_luajit_lua_Debug_new:Byte Ptr()
	Function bmx_luajit_lua_Debug_free(handle:Byte Ptr)
	
	Function bmx_luajit_lua_Debug_event:Int(handle:Byte Ptr)
	Function bmx_luajit_lua_Debug_name:String(handle:Byte Ptr)
	Function bmx_luajit_lua_Debug_namewhat:String(handle:Byte Ptr)
	Function bmx_luajit_lua_Debug_what:String(handle:Byte Ptr)
	Function bmx_luajit_lua_Debug_source:String(handle:Byte Ptr)
	Function bmx_luajit_lua_Debug_currentline:Int(handle:Byte Ptr)
	Function bmx_luajit_lua_Debug_nups:Int(handle:Byte Ptr)
	Function bmx_luajit_lua_Debug_linedefined:Int(handle:Byte Ptr)
	Function bmx_luajit_lua_Debug_lastlinedefined:Int(handle:Byte Ptr)
	Function bmx_luajit_lua_Debug_short_src:Byte Ptr(handle:Byte Ptr)
End Extern
