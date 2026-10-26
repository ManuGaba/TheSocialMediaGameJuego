// ============================================================================
// OBJ_OBJETIVO_HISTORIA
// EVENTO STEP COMPLETO
// ============================================================================

// ============================================================================
// VALORES POR DEFECTO
// ============================================================================

mostrar_objetivo =
    true;

texto_objetivo =
    "";

// ============================================================================
// OCULTAR EN INTRO Y FINAL
// ============================================================================

if (
    room == Room1 ||
    room == Room7
)
{
    mostrar_objetivo =
        false;
}

// ============================================================================
// PRIORIDAD 1
// OCULTAR DURANTE DIALOGOS
// ============================================================================

if (instance_exists(Obj_controlador_dialogo))
{
    if (Obj_controlador_dialogo.dialogo_activo)
    {
        mostrar_objetivo =
            false;
    }
}

// ============================================================================
// PRIORIDAD 2
// OCULTAR SI EL CELULAR ESTA ABIERTO
// ============================================================================

if (instance_exists(obj_celu))
{
    if (obj_celu.celular_abierto)
    {
        mostrar_objetivo =
            false;
    }
}

// ============================================================================
// PRIORIDAD 3
// OCULTAR SI HAY FEEDBACK DE CONSECUENCIAS
// ============================================================================

if (instance_exists(obj_feedback_decisiones))
{
    if (obj_feedback_decisiones.feedback_activo)
    {
        mostrar_objetivo =
            false;
    }
}

// ============================================================================
// PRIORIDAD 4
// OCULTAR SI LA AYUDA DE CONTROLES ESTA VISIBLE
// ============================================================================

if (instance_exists(obj_ayuda_controles))
{
    if (
        obj_ayuda_controles.ayuda_visible &&
        obj_ayuda_controles.alpha_ayuda > 0.05
    )
    {
        mostrar_objetivo =
            false;
    }
}

// ============================================================================
// COMPROBAR VARIABLES DE HISTORIA
// ============================================================================

if (
    !variable_global_exists("etapa_historia") ||
    !variable_global_exists("decision_pendiente") ||
    !variable_global_exists("decision_actual")
)
{
    mostrar_objetivo =
        false;
}

// ============================================================================
// ELEGIR OBJETIVO
// ============================================================================

if (mostrar_objetivo)
{
    // ========================================================================
    // HAY UNA DECISION PENDIENTE
    // ========================================================================

    if (global.decision_pendiente)
    {
        if (global.decision_actual == 1)
        {
            texto_objetivo =
                "Abri el celular y revisa DECISIONES.";
        }

        else if (global.decision_actual == 2)
        {
            texto_objetivo =
                "Decidi que hacer con la publicacion.";
        }

        else if (global.decision_actual == 3)
        {
            texto_objetivo =
                "Decidi con quien puede hablar Roger.";
        }

        else if (global.decision_actual == 4)
        {
            texto_objetivo =
                "Decidi que deberia hacer Roger ahora.";
        }

        else
        {
            texto_objetivo =
                "Revisa la app DECISIONES.";
        }
    }

    // ========================================================================
    // NO HAY DECISION PENDIENTE
    // ========================================================================

    else
    {
        if (global.etapa_historia <= 2)
        {
            texto_objetivo =
                "Continua con la historia.";
        }

        else if (global.etapa_historia == 3)
        {
            texto_objetivo =
                "Presta atencion a lo que sucede.";
        }

        else if (global.etapa_historia == 4)
        {
            texto_objetivo =
                "Revisa la nueva decision del celular.";
        }

        else if (global.etapa_historia == 5)
        {
            if (
                variable_global_exists("respondio") &&
                global.respondio
            )
            {
                texto_objetivo =
                    "Revisa TeleVuelo para continuar.";
            }

            else if (
                variable_global_exists("guardo_pruebas") &&
                global.guardo_pruebas
            )
            {
                texto_objetivo =
                    "Revisa InstaPix para continuar.";
            }

            else
            {
                texto_objetivo =
                    "Observa que sucede despues.";
            }
        }

        else if (global.etapa_historia == 6)
        {
            texto_objetivo =
                "Roger necesita decidir si pide ayuda.";
        }

        else if (global.etapa_historia == 7)
        {
            if (
                variable_global_exists("conto_amigo") &&
                global.conto_amigo
            )
            {
                texto_objetivo =
                    "Revisa ChatAmix y continua la historia.";
            }

            else
            {
                texto_objetivo =
                    "Continua con la historia.";
            }
        }

        else if (global.etapa_historia == 8)
        {
            texto_objetivo =
                "Queda una decision importante.";
        }

        else if (global.etapa_historia == 9)
        {
            texto_objetivo =
                "Observa las consecuencias de la decision.";
        }

        else
        {
            texto_objetivo =
                "Continua con la historia.";
        }
    }
}

// ============================================================================
// DETECTAR CAMBIO DE TEXTO
// ============================================================================

if (
    mostrar_objetivo &&
    texto_objetivo != texto_anterior
)
{
    texto_anterior =
        texto_objetivo;

    animando_cambio =
        true;

    tiempo_cambio =
        0;

    alpha_objetivo =
        0;

    desplazamiento_x =
        30;
}

// ============================================================================
// ANIMACION DE ENTRADA
// ============================================================================

if (mostrar_objetivo)
{
    alpha_objetivo =
        lerp(
            alpha_objetivo,
            1,
            0.12
        );

    desplazamiento_x =
        lerp(
            desplazamiento_x,
            0,
            0.12
        );

    if (alpha_objetivo > 0.98)
    {
        alpha_objetivo =
            1;
    }

    if (abs(desplazamiento_x) < 0.5)
    {
        desplazamiento_x =
            0;
    }
}

// ============================================================================
// OCULTAR SUAVEMENTE
// ============================================================================

else
{
    alpha_objetivo =
        lerp(
            alpha_objetivo,
            0,
            0.15
        );

    if (alpha_objetivo < 0.02)
    {
        alpha_objetivo =
            0;
    }
}

// ============================================================================
// CONTROL ANIMACION CAMBIO
// ============================================================================

if (animando_cambio)
{
    tiempo_cambio += 1;

    if (
        tiempo_cambio >=
        game_get_speed(gamespeed_fps) * 0.5
    )
    {
        animando_cambio =
            false;
    }
}
