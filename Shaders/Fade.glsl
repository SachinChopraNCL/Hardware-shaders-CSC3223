#version 400 core

uniform sampler2D 	mainTex;

uniform float time;

in Vertex
{
	vec4 colour;
	vec2 texCoord;
} IN;

out vec4 fragColor;

void main(void)
{	
		vec4 startingTex = texture(mainTex, IN.texCoord);
		startingTex.a = 1 - (time / 2);
		fragColor = startingTex;
}