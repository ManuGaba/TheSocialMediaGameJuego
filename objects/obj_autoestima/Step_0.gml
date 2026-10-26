// ============================================================
// OBJ_AUTOESTIMA
// EVENTO STEP COMPLETO
// ============================================================

// ============================================================
// SEGURIDAD
// ============================================================

if (!variable_global_exists("bienestar"))
{
    global.bienestar = 100;
}

if (!variable_global_exists("apoyo"))
{
    global.apoyo = 20;
}

if (!variable_global_exists("acoso"))
{
    global.acoso = 0;
}

// ============================================================
// VELOCIDAD ACTUAL DEL JUEGO
// ============================================================

fps_juego =
    game_get_speed(gamespeed_fps);

// ============================================================
// LIMITAR VALORES
// ============================================================

global.bienestar =
    clamp(
        global.bienestar,
        0,
        100
    );

global.apoyo =
    clamp(
        global.apoyo,
        0,
        100
    );

global.acoso =
    clamp(
        global.acoso,
        0,
        100
    );

// ============================================================
// DETECTAR CAMBIO EN BIENESTAR
// ============================================================

var nuevo_cambio_bienestar =
    global.bienestar
    - bienestar_anterior;

// ============================================================
// DETECTAR CAMBIO EN APOYO
// ============================================================

var nuevo_cambio_apoyo =
    global.apoyo
    - apoyo_anterior;

// ============================================================
// DETECTAR CAMBIO EN ACOSO
// ============================================================

var nuevo_cambio_acoso =
    global.acoso
    - acoso_anterior;

// ============================================================
// SI CAMBIO ALGUNA VARIABLE
// ============================================================

if (
    nuevo_cambio_bienestar != 0 ||
    nuevo_cambio_apoyo != 0 ||
    nuevo_cambio_acoso != 0
)
{
    cambio_bienestar =
        nuevo_cambio_bienestar;

    cambio_apoyo =
        nuevo_cambio_apoyo;

    cambio_acoso =
        nuevo_cambio_acoso;

    mostrar_cambio = true;

    contador_cambio =
        tiempo_cambio;

    alpha_cambio = 1;

    escala_cambio = 0.90;
}

// ============================================================
// ACTUALIZAR VALORES ANTERIORES
// ============================================================

bienestar_anterior =
    global.bienestar;

apoyo_anterior =
    global.apoyo;

acoso_anterior =
    global.acoso;

// ============================================================
// ANIMACION DEL AVISO
// ============================================================

if (mostrar_cambio)
{
    if (contador_cambio > 0)
    {
        contador_cambio -= 1;

        // Aumenta suavemente de tamaño
        escala_cambio =
            lerp(
                escala_cambio,
                1,
                0.15
            );

        // ====================================================
        // EMPEZAR A DESAPARECER DURANTE LOS ULTIMOS 0.5 SEG
        // ====================================================

        if (
            contador_cambio <
            fps_juego * 0.5
        )
        {
            alpha_cambio =
                lerp(
                    alpha_cambio,
                    0,
                    0.12
                );
        }
    }

    else
    {
        mostrar_cambio = false;

        cambio_bienestar = 0;

        cambio_apoyo = 0;

        cambio_acoso = 0;

        alpha_cambio = 0;
    }
}