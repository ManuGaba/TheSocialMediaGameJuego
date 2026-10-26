// ============================================================================
// OBJ_ESTILO_DIALOGO
// EVENTO STEP COMPLETO
// ============================================================================

// ============================================================================
// COMPROBAR SI HAY DIALOGO
// ============================================================================

var hay_dialogo = false;

if (instance_exists(Obj_controlador_dialogo))
{
    if (Obj_controlador_dialogo.dialogo_activo)
    {
        hay_dialogo = true;
    }
}

// ============================================================================
// NO USAR EN ROOM 7
// ============================================================================

if (room == Room7)
{
    hay_dialogo = false;
}

// ============================================================================
// ANIMACION DE ENTRADA
// ============================================================================

if (hay_dialogo)
{
    alpha_panel =
        lerp(
            alpha_panel,
            1,
            0.14
        );

    desplazamiento_y =
        lerp(
            desplazamiento_y,
            0,
            0.14
        );

    escala_panel =
        lerp(
            escala_panel,
            1,
            0.12
        );

    if (alpha_panel > 0.98)
    {
        alpha_panel = 1;
    }

    if (abs(desplazamiento_y) < 0.5)
    {
        desplazamiento_y = 0;
    }

    if (abs(escala_panel - 1) < 0.005)
    {
        escala_panel = 1;
    }
}

// ============================================================================
// ANIMACION DE SALIDA
// ============================================================================

else
{
    alpha_panel =
        lerp(
            alpha_panel,
            0,
            0.18
        );

    desplazamiento_y =
        lerp(
            desplazamiento_y,
            15,
            0.18
        );

    escala_panel =
        lerp(
            escala_panel,
            0.98,
            0.18
        );

    if (alpha_panel < 0.02)
    {
        alpha_panel = 0;
    }
}

// ============================================================================
// PULSO DECORATIVO
// ============================================================================

pulso =
    0.5
    +
    0.5
    *
    sin(
        current_time / 250
    );