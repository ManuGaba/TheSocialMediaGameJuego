// ============================================================================
// OBJ_FEEDBACK_DECISIONES
// EVENTO STEP COMPLETO
// ============================================================================

// ============================================================================
// COMPROBAR QUE EXISTAN LAS VARIABLES
// ============================================================================

var existen_estadisticas =
    variable_global_exists("bienestar") &&
    variable_global_exists("apoyo") &&
    variable_global_exists("acoso");

if (!existen_estadisticas)
{
    exit;
}

// ============================================================================
// NO MOSTRAR FEEDBACK EN INTRO O FINAL
// ============================================================================

if (
    room == Room1 ||
    room == Room7
)
{
    bienestar_anterior =
        global.bienestar;

    apoyo_anterior =
        global.apoyo;

    acoso_anterior =
        global.acoso;

    feedback_listo = true;

    feedback_activo = false;

    tiempo_feedback = 0;

    alpha_feedback = 0;

    exit;
}

// ============================================================================
// PRIMERA LECTURA
// ============================================================================

if (!feedback_listo)
{
    bienestar_anterior =
        global.bienestar;

    apoyo_anterior =
        global.apoyo;

    acoso_anterior =
        global.acoso;

    feedback_listo = true;

    exit;
}

// ============================================================================
// DETECTAR CAMBIOS
// ============================================================================

cambio_bienestar =
    global.bienestar
    - bienestar_anterior;

cambio_apoyo =
    global.apoyo
    - apoyo_anterior;

cambio_acoso =
    global.acoso
    - acoso_anterior;

// ============================================================================
// SI ALGO CAMBIO
// ============================================================================

if (
    cambio_bienestar != 0 ||
    cambio_apoyo != 0 ||
    cambio_acoso != 0
)
{
    feedback_activo = true;

    tiempo_feedback = 0;

    alpha_feedback = 0;

    desplazamiento_y = -25;

    // ========================================================================
    // ACTUALIZAR VALORES ANTERIORES
    // ========================================================================

    bienestar_anterior =
        global.bienestar;

    apoyo_anterior =
        global.apoyo;

    acoso_anterior =
        global.acoso;
}

// ============================================================================
// ANIMACION DEL FEEDBACK
// ============================================================================

if (feedback_activo)
{
    tiempo_feedback += 1;

    // ========================================================================
    // ENTRADA
    // ========================================================================

    if (
        tiempo_feedback <
        game_get_speed(gamespeed_fps) * 0.25
    )
    {
        alpha_feedback =
            lerp(
                alpha_feedback,
                1,
                0.18
            );

        desplazamiento_y =
            lerp(
                desplazamiento_y,
                0,
                0.18
            );
    }

    // ========================================================================
    // MANTENER
    // ========================================================================

    else if (
        tiempo_feedback <
        duracion_feedback
        - game_get_speed(gamespeed_fps) * 0.35
    )
    {
        alpha_feedback =
            lerp(
                alpha_feedback,
                1,
                0.15
            );

        desplazamiento_y =
            lerp(
                desplazamiento_y,
                0,
                0.15
            );
    }

    // ========================================================================
    // SALIDA
    // ========================================================================

    else
    {
        alpha_feedback =
            lerp(
                alpha_feedback,
                0,
                0.12
            );

        desplazamiento_y =
            lerp(
                desplazamiento_y,
                -15,
                0.12
            );
    }

    // ========================================================================
    // TERMINAR
    // ========================================================================

    if (tiempo_feedback >= duracion_feedback)
    {
        feedback_activo = false;

        tiempo_feedback = 0;

        alpha_feedback = 0;

        desplazamiento_y = -25;

        cambio_bienestar = 0;

        cambio_apoyo = 0;

        cambio_acoso = 0;
    }
}