// ============================================================
// OBJ_AUTOESTIMA
// EVENTO CREATE COMPLETO
// ============================================================

persistent = true;

// ============================================================
// TAMAÑO DEL MEDIDOR
// ============================================================

escala_medidor = 0.65;

// ============================================================
// POSICION DEL MEDIDOR
// ============================================================

margen_x = 25;

margen_y = 25;

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
// GUARDAR VALORES ANTERIORES
// ============================================================

bienestar_anterior =
    global.bienestar;

apoyo_anterior =
    global.apoyo;

acoso_anterior =
    global.acoso;

// ============================================================
// CAMBIOS
// ============================================================

cambio_bienestar = 0;

cambio_apoyo = 0;

cambio_acoso = 0;

// ============================================================
// AVISO DE CONSECUENCIA
// ============================================================

mostrar_cambio = false;

// ============================================================
// VELOCIDAD ACTUAL DEL JUEGO
// ============================================================

fps_juego =
    game_get_speed(gamespeed_fps);

// Duracion del aviso:
// 2 segundos
tiempo_cambio =
    fps_juego * 2;

contador_cambio = 0;

// ============================================================
// ANIMACION DEL AVISO
// ============================================================

alpha_cambio = 0;

escala_cambio = 0.90;