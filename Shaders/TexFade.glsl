#version 400 core

uniform sampler2D 	mainTex;
uniform sampler2D   secondTex;

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
	vec4 finishingTex = texture(secondTex, IN.texCoord);
	float f = 1 - time;
	fragColor = (startingTex * f + finishingTex * time);
}