#version 400 core

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
	vec4 texval = texture(secondTex, IN.texCoord);

	if (texval.b > 1 - (time / 4)) {
		fragColor.a = 0;
	}
	else {
		fragColor = texval;
	}
}