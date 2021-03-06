#version 400 core
layout(triangles,cw) in;

uniform sampler2D heightMap;
uniform float time;

uniform mat4 modelMatrix;
uniform mat4 viewMatrix;
uniform mat4 projMatrix;


in Vertex{
	vec2 texCoord;
} IN[];

out Vertex{
	vec2 texCoord;
} OUT; 


vec3 TriMixVec3(vec3 a, vec3 b, vec3 c)
{
  vec3 p0 = gl_TessCoord.x * a;
  vec3 p1 = gl_TessCoord.y * b;
  vec3 p2 = gl_TessCoord.z * c;

  return p0 + p1 + p2;
}

vec2 TriMixVec2(vec2 a, vec2 b, vec2 c)
{
  vec2 p0 = gl_TessCoord.x * a;
  vec2 p1 = gl_TessCoord.y * b;
  vec2 p2 = gl_TessCoord.z * c;

  return p0 + p1 + p2;
}

void main(){
	vec3 combinedPos = TriMixVec3 (gl_in[0].gl_Position.xyz ,gl_in[1].gl_Position.xyz,gl_in[2].gl_Position.xyz);
	OUT.texCoord = TriMixVec2(IN[0].texCoord, IN[1].texCoord, IN[2].texCoord);

	vec4 worldPos = modelMatrix*vec4(combinedPos,1);

	float height_x = texture(heightMap, OUT.texCoord).x * time;

	if (height_x > 5)
		height_x = 5;

	worldPos.x += height_x / 2;

	gl_Position = projMatrix * viewMatrix * worldPos;


}