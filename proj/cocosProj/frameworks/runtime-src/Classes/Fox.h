
#include "iostream"
#include "cocos2d.h"

#ifndef _FOX_H_
#define _FOX_H_

namespace Fox 
{
	int getFileMD5(lua_State* tolua_S);
	int getDataMD5(lua_State* tolua_S);

	int captureNode(lua_State* tolua_S, cocos2d::Node* startNode, float scale = 1.0f);
};

extern void registerFoxPackage(lua_State*tolua_S);

#endif // !_FOX_H_