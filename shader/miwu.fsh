#ifdef GL_ES
precision highp float;
#endif
varying vec2 v_texCoord;
uniform vec2 pos;
uniform float radius;
uniform vec2 resolution;
uniform int isGradual;
const float pi = 3.1415926;
 
vec2 getDis(vec2 center, vec2 texv)
{
	vec2 v = center - texv;
	return length(v);
}
vec2 reduce(float dis)
{
	float a = dis * dis * 50;
	float alpha = a > 0.0f ? a : 0.0f ; 
	if (isGradual == 1)
	{
		if (alpha < 1)
			alpha = 0;
	}
	return alpha;
}
void main(){
	vec2 rate = vec2(32.0 / resolution.x, 32.0 / resolution.y);
	vec2 center = vec2(pos.x / resolution.x, pos.y / resolution.y);
	float dis = getDis(center, gl_FragCoord / resolution);
	float alpha = reduce(dis);
	
	gl_FragColor = vec4(0,0,0, alpha);
}