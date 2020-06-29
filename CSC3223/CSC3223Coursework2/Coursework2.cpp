#include "../../Common/Window.h"
#include "../../Common/TextureLoader.h"
#include "../../Common/Vector3.h"
#include "../../Common/Vector4.h"
#include "../../Common/MeshGeometry.h"
#include "../../Common/Maths.h"

#include "../../Plugins/OpenGLRendering/OGLRenderer.h"
#include "../../Plugins/OpenGLRendering/OGLMesh.h"
#include "../../Plugins/OpenGLRendering/OGLShader.h"
#include "../../Plugins/OpenGLRendering/OGLTexture.h"

#include "Renderer.h"
#define NUM_SHADER 7
#define CUBE_SIZE 36
using namespace NCL;
using namespace CSC3223;

OGLShader* shaders[NUM_SHADER];

RenderObject* Coursework2(Renderer& renderer, int type) {
	OGLMesh* m = new OGLMesh("cube.msh"); 
	if(type == 1)
		m->SetPrimitiveType(GeometryPrimitive::Patches);

	std::vector<Vector4> colours;
	for (int i = 0; i < CUBE_SIZE; i++) {
		colours.push_back(Vector4(1, 1, 1, 1));
	}

	m->SetVertexColours(colours);
	m->UploadToGPU();
	RenderObject* object = new RenderObject(m);

	object->SetBaseTexture(OGLTexture::RGBATextureFromFilename("brick.png"));

	object->setSecondTexture(OGLTexture::RGBATextureFromFilename("perlin_noise.png"));

	renderer.AddRenderObject(object);

	return object;
}
void load_shader() {

	for (int i = 0; i < NUM_SHADER; i++)
		shaders[i] = NULL;
	shaders[0] = new OGLShader("RasterisationVert.glsl", "RasterisationFrag.glsl");
	shaders[1] = new OGLShader("ShrinkVertex.glsl", "RasterisationFrag.glsl");
	shaders[2] = new OGLShader("RasterisationVert.glsl", "TexFade.glsl");
	shaders[3] = new OGLShader("RasterisationVert.glsl", "Fade.glsl");
	shaders[4] = new OGLShader("BaseVert.glsl", "RasterisationFrag.glsl","CubeDisplace.glsl");
	shaders[5] = new OGLShader("TessVert.glsl", "DisplaceFrag.glsl", "", "DisplaceTCS.glsl", "DisplaceTES.glsl");
	shaders[6] = new OGLShader("RasterisationVert.glsl", "DissolveFrag.glsl");
}

int main() {

	Window* w = Window::CreateGameWindow("CSC3223 Coursework 2!");

	if (!w->HasInitialised()) {
		return -1;
	}

	Renderer* renderer = new Renderer(*w);


	load_shader();


	RenderObject* cube = Coursework2(*renderer,0);

	renderer->EnableBuffers(true);


	renderer->SetProjectionMatrix(Matrix4::Perspective(1, 1000, w->GetScreenAspect(), 45.0f));

	float rotation = 0.0f;
	bool rotate = true; 
	while (w->UpdateWindow() && !Window::GetKeyboard()->KeyDown(KEYBOARD_ESCAPE)) {

		float time = w->GetTimer()->GetTimeDelta();
		renderer->Update(time);


		Matrix4 modelMat = Matrix4::Translation(Vector3(0, 0, -10));

		
		if (Window::GetKeyboard()->KeyPressed(KEYBOARD_A)) {
		
			rotate = true;
		
		}

		if (Window::GetKeyboard()->KeyPressed(KEYBOARD_S)) {

			rotate = false;

		}

		if (rotate == true) {
			rotation += time * 30;
		}

		modelMat = modelMat * Matrix4::Rotation(rotation, Vector3(1, 1, 1));

		renderer->Render();

		cube->SetTransform(modelMat);

		renderer->DrawString("OpenGL Rendering!", Vector2(10, 10));

		if (Window::GetKeyboard()->KeyPressed(KEYBOARD_1)) {
			renderer->ResetTimer();
			std::cout << "LOADED DEFAULT STATE" << std::endl;
			cube->SetShader(shaders[0]);
		}

		if (Window::GetKeyboard()->KeyPressed(KEYBOARD_2)) {
			renderer->ResetTimer();
			std::cout << "LOADED SHRINK STATE" << std::endl;
			cube->SetShader(shaders[1]);
		}

		if (Window::GetKeyboard()->KeyPressed(KEYBOARD_3)) {
			renderer->ResetTimer();
			std::cout << "LOADED TEX FADE STATE" << std::endl;
			cube->SetShader(shaders[2]);
		}

		if (Window::GetKeyboard()->KeyPressed(KEYBOARD_4)) {
			renderer->ResetTimer();
			std::cout << "LOADED FADE STATE" << std::endl;
			cube->SetShader(shaders[3]);
		}

		if (Window::GetKeyboard()->KeyPressed(KEYBOARD_5)) {
			rotate = false;
			std::cout << "LOADED GEO STATE" << std::endl;
			cube->SetShader(shaders[4]);
		}

		if (Window::GetKeyboard()->KeyPressed(KEYBOARD_6)) {
			renderer->DeleteAllRenderObjects();
			cube = Coursework2(*renderer, 1);
			std::cout << "LOADED TESS STATE" << std::endl;
			cube->SetShader(shaders[5]);
		}


		if (Window::GetKeyboard()->KeyPressed(KEYBOARD_7)) {
			renderer->ResetTimer();
			std::cout << "LOADED DISSOLVE STATE" << std::endl;
			cube->SetShader(shaders[6]);
		}


		if (Window::GetKeyboard()->KeyPressed(KEYBOARD_PRIOR)) {
			w->ShowConsole(true);
		}
		if (Window::GetKeyboard()->KeyPressed(KEYBOARD_NEXT)) {
			w->ShowConsole(false);
		}

		if (Window::GetKeyboard()->KeyPressed(KEYBOARD_HOME)) {
			w->SetFullScreen(true);
		}
		if (Window::GetKeyboard()->KeyPressed(KEYBOARD_END)) {
			w->SetFullScreen(false);
		}

		w->SetTitle(std::to_string(time));
	}

	delete renderer;

	Window::DestroyGameWindow();
}

