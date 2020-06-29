#version 400 core

uniform mat4 modelMatrix 	= mat4(1.0f);
uniform mat4 viewMatrix 	= mat4(1.0f);
uniform mat4 projMatrix 	= mat4(1.0f);

uniform float time = 0.0f;

layout(location = 0) in vec3 position;
layout(location = 1) in vec4 colour;	
layout(location = 2) in vec2 texCoord;

out Vertex
{
	vec4 colour;
	vec2 texCoord;
} OUT;

void main(void)
{
	float f = 1 - (time/4);
	
	if(f < 0)
		f = 0;

	mat4 mvp 		= (projMatrix * viewMatrix * modelMatrix);

	gl_Position		= mvp * vec4(position, 1.0) * mat4(vec4(f,0,0,0),
													   vec4(0,f,0,0),
		                                               vec4(0,0,f,0),
													   vec4(0,0,0,1));

	OUT.texCoord	= texCoord;
	OUT.colour		= colour;
}