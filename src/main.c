#include <raylib.h>

//#define PLATFORM_WEB

#if defined(PLATFORM_WEB)
    #include <emscripten/emscripten.h>
#endif
const int const screenWidth = 800;
const int const screenHeight = 450;
void Render(void);
void Update(void);
int main()
{
    SetTraceLogLevel(LOG_NONE);
    InitWindow(screenWidth, screenHeight, "Custom Raylib Template");

#if defined(PLATFORM_WEB)
    emscripten_set_main_loop(Update, 0, 1);
#else
    SetTargetFPS(60);
    while (!WindowShouldClose())    {
        Update();
    }
#endif

    CloseWindow();

    return 0;
}

void Update(void) {
    Render();
}

void Render(void)
{
    BeginDrawing();

        ClearBackground(RAYWHITE);
        DrawText("Congrats! You created your first window!", 190, 200, 20, LIGHTGRAY);

    EndDrawing();
}

