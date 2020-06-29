#version 400 core

uniform float time;
uniform mat4 modelMatrix;
uniform mat4 viewMatrix;
uniform mat4 projMatrix;

layout(triangles) in;
layout(triangle_strip, max_vertices = 100) out;

in Vertex{
	vec4 colour;
	vec2 texCoord;
} IN[];

out Vertex{
	vec4 colour;
	vec2 texCoord;
}OUT;

float random (vec2 st) {
    return fract(sin(dot(st.xy,vec2(12.9898,78.233)))*43758.5453123);
}

void main(void) {
	float j = 0.2;
	float jump = 0.5;
	float acc = 0;
	mat4 mvp = projMatrix * viewMatrix * modelMatrix;	
	vec4 a = gl_in[0].gl_Position;
	for(float x = 0; x < 1; x+=jump){
		acc++;
		for(float y = 0; y < 1; y+=jump){
			for(float z = 0; z < 1; z+= jump){
				vec4 pos = a + vec4(vec3(x,y,z),1);
				pos.y = pos.y - random(IN[0].texCoord) - time - (acc/2);
				OUT.colour = IN[0].colour;
				gl_Position = mvp * vec4(pos.xyz,1);
				EmitVertex();
				OUT.colour = IN[0].colour;
				gl_Position = mvp * vec4(pos.xyz + vec3(j,0,0) ,1);
				EmitVertex();
				OUT.colour = IN[0].colour;
				gl_Position = mvp * vec4(pos.xyz + vec3(0,-j,0) ,1);
				EmitVertex();
				OUT.colour = IN[0].colour;
				gl_Position = mvp * vec4(pos.xyz + vec3(j,-j,0) ,1);
				EmitVertex();
				EndPrimitive();

				OUT.colour = IN[0].colour;
				gl_Position = mvp * vec4(pos.xyz + vec3(0,-j,0) ,1);
				EmitVertex();
				OUT.colour = IN[0].colour;
				gl_Position = mvp * vec4(pos.xyz + vec3(0,-j,j) ,1);
				EmitVertex();
				OUT.colour = IN[0].colour;
				gl_Position = mvp * vec4(pos.xyz + vec3(j,-j,0) ,1);
				EmitVertex();
				OUT.colour = IN[0].colour;
				gl_Position = mvp * vec4(pos.xyz + vec3(j,-j,j) ,1);
				EmitVertex();
				EndPrimitive();

				OUT.colour = IN[0].colour;
				gl_Position = mvp * vec4(pos.xyz + vec3(j,0,0) ,1);
				EmitVertex();
				OUT.colour = IN[0].colour;
				gl_Position = mvp * vec4(pos.xyz + vec3(j,-j,0) ,1);
				EmitVertex();
				OUT.colour = IN[0].colour;
				gl_Position = mvp * vec4(pos.xyz + vec3(j,0,j) ,1);
				EmitVertex();
				OUT.colour = IN[0].colour;
				gl_Position = mvp * vec4(pos.xyz + vec3(j,-j,j) ,1);
				EmitVertex();
				EndPrimitive();

				OUT.colour = IN[0].colour;
				gl_Position = mvp * vec4(pos.xyz,1);
				EmitVertex();
				OUT.colour = IN[0].colour;
				gl_Position = mvp * vec4(pos.xyz + vec3(0,-j,0) ,1);
				EmitVertex();
				OUT.colour = IN[0].colour;
				gl_Position = mvp * vec4(pos.xyz + vec3(0,0,j) ,1);
				EmitVertex();
				OUT.colour = IN[0].colour;
				gl_Position = mvp * vec4(pos.xyz + vec3(0,-j,j) ,1);
				EmitVertex();
				EndPrimitive();

	
				OUT.colour = IN[0].colour;
				gl_Position = mvp * vec4(pos.xyz,1);
				EmitVertex();
				OUT.colour = IN[0].colour;
				gl_Position = mvp * vec4(pos.xyz + vec3(j,0,0) ,1);
				EmitVertex();
				OUT.colour = IN[0].colour;
				gl_Position = mvp * vec4(pos.xyz + vec3(0,0,j) ,1);
				EmitVertex();
				OUT.colour = IN[0].colour;
				gl_Position = mvp * vec4(pos.xyz + vec3(j,0,j) ,1);
				EmitVertex();
				EndPrimitive();
			}
		}
	}
}

