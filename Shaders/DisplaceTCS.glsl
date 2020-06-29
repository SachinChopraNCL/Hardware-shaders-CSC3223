#version 400 core
layout(vertices = 3) out;

in Vertex{
	vec2 texCoord;
} IN[];

out Vertex{
	vec2 texCoord;
} OUT[];


void main(){
  gl_TessLevelInner[0] = 128;
  gl_TessLevelOuter[0] = 8;
  gl_TessLevelOuter[1] = 16;
  gl_TessLevelOuter[2] = 128;

	OUT[gl_InvocationID].texCoord = IN[gl_InvocationID].texCoord;
	 gl_out [gl_InvocationID]. gl_Position = gl_in [gl_InvocationID].gl_Position ;

}