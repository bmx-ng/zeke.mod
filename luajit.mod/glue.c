#include "luajit/src/lua.h"
#include "brl.mod/blitz.mod/blitz.h"

lua_Debug * bmx_luajit_lua_Debug_new() {
	return (lua_Debug*)malloc(sizeof(lua_Debug));
}

void bmx_luajit_lua_Debug_free(lua_Debug * dbg) {
	free(dbg);
}

int bmx_luajit_lua_Debug_event(lua_Debug * dbg) {
	return dbg->event;
}

BBString * bmx_luajit_lua_Debug_name(lua_Debug * dbg) {
	return bbStringFromCString(dbg->name);
}

BBString * bmx_luajit_lua_Debug_namewhat(lua_Debug * dbg) {
	return bbStringFromCString(dbg->namewhat);
}

BBString * bmx_luajit_lua_Debug_what(lua_Debug * dbg) {
	return bbStringFromCString(dbg->what);
}

BBString * bmx_luajit_lua_Debug_source(lua_Debug * dbg) {
	return bbStringFromCString(dbg->source);
}

int bmx_luajit_lua_Debug_currentline(lua_Debug * dbg) {
	return dbg->currentline;
}

int bmx_luajit_lua_Debug_nups(lua_Debug * dbg) {
	return dbg->nups;
}

int bmx_luajit_lua_Debug_linedefined(lua_Debug * dbg) {
	return dbg->linedefined;
}

int bmx_luajit_lua_Debug_lastlinedefined(lua_Debug * dbg) {
	return dbg->lastlinedefined;
}

char * bmx_luajit_lua_Debug_short_src(lua_Debug * dbg) {
	return dbg->short_src;
}

