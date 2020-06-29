#version 400 core
uniform mat4 modelMatrix;
uniform mat4 viewMatrix;
uniform mat4 projMatrix;

layout(location = 0) in vec3 position;
layout(location = 2) in vec2 texCoord;

out Vertex
{
	vec2 texCoord;
} OUT;

void main(void)
{
	
	gl_Position		=  vec4(position, 1.0);

	OUT.texCoord	= texCoord;
}