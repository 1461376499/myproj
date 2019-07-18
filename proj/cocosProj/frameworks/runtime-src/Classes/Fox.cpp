#include "Fox.h"
//#include "scripting/lua-bindings/manual/CCComponentLua.h"
//#include "scripting/lua-bindings/manual/tolua_fix.h"
#include "scripting/lua-bindings/manual/LuaBasicConversions.h"
#include "platform/CCPlatformMacros.h"

int Fox::getFileMD5(lua_State* tolua_S)
{
	int argc = 0;
	std::string filename;
	bool ok = true;
#if COCOS2D_DEBUG >= 1
	tolua_Error tolua_err;
#endif
	argc = lua_gettop(tolua_S);

	if (argc == 1)
	{
		ok &= luaval_to_std_string(tolua_S, 1, &filename, "Fox.getFileMD5");
		if (!ok)
		{
			tolua_error(tolua_S, "invalid arguments in function 'Fox.getFileMD5'", nullptr);
			return 0;
		}
		std::string ret = cocos2d::utils::getFileMD5Hash(filename);
		lua_pushlstring(tolua_S, ret.c_str(), ret.length());
		return 1;
	}
	luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "Fox.getFileMD5", argc, 0);
	return 0;

#if COCOS2D_DEBUG >= 1
	tolua_lerror:
				tolua_error(tolua_S, "#ferror in function 'Fox.getFileMD5'.", &tolua_err);
#endif
	return 0;
}
int Fox::getDataMD5(lua_State* tolua_S)
{
	int argc = 0;
	
	bool ok = true;
#if COCOS2D_DEBUG >= 1
	tolua_Error tolua_err;
#endif
	argc = lua_gettop(tolua_S);

	std::string filename;
	ssize_t length;
	if (argc == 2)
	{
		ok &= luaval_to_std_string(tolua_S, 1, &filename, "Fox.getDataMD5");
		if (!ok)
		{
			tolua_error(tolua_S, "invalid arguments in function 'Fox.getDataMD5'", nullptr);
			return 0;
		}

		ok &= luaval_to_ssize(tolua_S, 2, &length, "Fox.getFileMD5");
		if (!ok)
		{
			tolua_error(tolua_S, "invalid arguments in function 'Fox.getDataMD5'", nullptr);
			return 0;
		}
		Data d;
		d.fastSet((unsigned char*)filename.c_str(), length);
		std::string ret = cocos2d::utils::getDataMD5Hash(d);
		lua_pushlstring(tolua_S, ret.c_str(), ret.length());

		d.fastSet(nullptr, 0);
		return 1;
	}
	luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "Fox.getDataMD5", argc, 2);
	return 0;

#if COCOS2D_DEBUG >= 1
	tolua_lerror:
				tolua_error(tolua_S, "#ferror in function 'Fox.getDataMD5'.", &tolua_err);
#endif
	return 0;
}

int Fox::captureNode(lua_State* L)
{

	//cocos2d::Image* image = cocos2d::utils::captureNode(startNode, scale);

	return 0;
}

int Fox::luaLog(lua_State* L)
{
	int argc = 0;

	bool ok = true;
#if COCOS2D_DEBUG >= 1
	tolua_Error tolua_err;
#endif
	argc = lua_gettop(L);

	std::string content;
	if (argc == 1)
	{
		ok &= luaval_to_std_string(L, 1, &content, "Fox.Log");
		if (!ok)
		{
			tolua_error(L, "invalid arguments in function 'Fox.Log'", nullptr);
			return 0;
		}
		CCLOG("%s", content);
	}
	luaL_error(L, "%s has wrong number of arguments: %d, was expecting %d \n", "Fox.Log", argc, 1);
	return 0;

#if COCOS2D_DEBUG >= 1
	tolua_lerror:
				tolua_error(L, "#ferror in function 'Fox.getDataMD5'.", &tolua_err);
#endif
	return 0;
}

void registerFoxPackage(lua_State*tolua_S)
{
	tolua_open(tolua_S);
	tolua_module(tolua_S, "Fox", 0);
	tolua_beginmodule(tolua_S, "Fox");
		tolua_function(tolua_S, "getFileMD5", Fox::getFileMD5);
		tolua_function(tolua_S, "getDataMD5", Fox::getDataMD5);
		tolua_function(tolua_S, "luaLog", Fox::luaLog);
	tolua_endmodule(tolua_S);
}