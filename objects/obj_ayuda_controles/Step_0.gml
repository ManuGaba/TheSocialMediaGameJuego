// ============================================================================
// OBJ_AYUDA_CONTROLES
// EVENTO STEP COMPLETO
// ============================================================================

// ============================================================================
// NO MOSTRAR EN ROOM 1 NI ROOM 7
// ============================================================================

if (
    room == Room1 ||
    room == Room7
)
{
    ayuda_visible =
        false;

    mostrar_automaticamente =
        false;
}

// ============================================================================
// MOSTRAR AUTOMATICAMENTE UNA VEZ
// ============================================================================

if (
    room == Room2 &&
    !ayuda_mostrada_automaticamente
)
{
    var hay_dialogo =
        false;

    if (instance_exists(Obj_controlador_dialogo))
    {
        hay_dialogo =
            Obj_controlador_dialogo.dialogo_activo;
    }

    if (!hay_dialogo)
    {
        ayuda_visible =
            true;

        mostrar_automaticamente =
            true;

        ayuda_mostrada_automaticamente =
            true;

        tiempo_ayuda =
            0;

        alpha_ayuda =
            0;

        desplazamiento_y =
            25;
    }
}

// ============================================================================
// F1 ABRE / CIERRA LA AYUDA
// ============================================================================

if (
    room != Room1 &&
    room != Room7
)
{
    if (keyboard_check_pressed(vk_f1))
    {
        ayuda_visible =
            !ayuda_visible;

        mostrar_automaticamente =
            false;

        if (ayuda_visible)
        {
            tiempo_ayuda =
                0;

            alpha_ayuda =
                0;

            desplazamiento_y =
                25;
        }
    }
}

// ============================================================================
// CONTROL DE PRIORIDADES
// ============================================================================

var ocultar_temporalmente =
    false;

// ============================================================================
// PRIORIDAD 1
// DIALOGO ACTIVO
// ============================================================================

if (instance_exists(Obj_controlador_dialogo))
{
    if (Obj_controlador_dialogo.dialogo_activo)
    {
        ocultar_temporalmente =
            true;
    }
}

// ============================================================================
// PRIORIDAD 2
// CELULAR ABIERTO
// ============================================================================

if (instance_exists(obj_celu))
{
    if (obj_celu.celular_abierto)
    {
        ocultar_temporalmente =
            true;
    }
}

// ============================================================================
// PRIORIDAD 3
// FEEDBACK DE CONSECUENCIAS
// ============================================================================

if (instance_exists(obj_feedback_decisiones))
{
    if (obj_feedback_decisiones.feedback_activo)
    {
        ocultar_temporalmente =
            true;
    }
}

// ============================================================================
// TEMPORIZADOR AUTOMATICO
// ============================================================================

if (
    ayuda_visible &&
    mostrar_automaticamente &&
    !ocultar_temporalmente
)
{
    tiempo_ayuda += 1;

    if (tiempo_ayuda >= duracion_ayuda)
    {
        ayuda_visible =
            false;

        mostrar_automaticamente =
            false;
    }
}

// ============================================================================
// ANIMACION DE ENTRADA
// ============================================================================

if (
    ayuda_visible &&
    !ocultar_temporalmente
)
{
    alpha_ayuda =
        lerp(
            alpha_ayuda,
            1,
            0.14
        );

    desplazamiento_y =
        lerp(
            desplazamiento_y,
            0,
            0.14
        );

    if (alpha_ayuda > 0.98)
    {
        alpha_ayuda =
            1;
    }

    if (abs(desplazamiento_y) < 0.5)
    {
        desplazamiento_y =
            0;
    }
}

// ============================================================================
// ANIMACION DE SALIDA
// ============================================================================

else
{
    alpha_ayuda =
        lerp(
            alpha_ayuda,
            0,
            0.18
        );

    desplazamiento_y =
        lerp(
            desplazamiento_y,
            20,
            0.18
        );

    if (alpha_ayuda < 0.02)
    {
        alpha_ayuda =
            0;
    }
}