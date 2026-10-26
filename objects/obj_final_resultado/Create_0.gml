// ============================================================================
// OBJ_FINAL_RESULTADO
// EVENTO CREATE COMPLETO
// ============================================================================

// ============================================================================
// PROFUNDIDAD
// ============================================================================

depth = -100000;

// ============================================================================
// ANIMACION
// ============================================================================

alpha_panel = 0;

escala_panel = 0.92;

desplazamiento_y = 24;

// ============================================================================
// PULSO
// ============================================================================

pulso = 0;

// ============================================================================
// DATOS DEL FINAL
// ============================================================================

titulo_final = "";

subtitulo_final = "";

mensaje_final = "";

texto_estado = "";

color_final =
    make_color_rgb(
        90,
        140,
        220
    );

// ============================================================================
// FINAL 1
// ============================================================================

if (global.final_juego == 1)
{
    titulo_final =
        "ROGER ENCONTRO APOYO";

    subtitulo_final =
        "Tus decisiones ayudaron a mejorar la situacion.";

    mensaje_final =
        "Pedir ayuda, guardar pruebas y hablar con personas de confianza puede marcar una gran diferencia.";

    texto_estado =
        "BUEN CAMINO";

    color_final =
        make_color_rgb(
            92,
            200,
            145
        );
}

// ============================================================================
// FINAL 2
// ============================================================================

else if (global.final_juego == 2)
{
    titulo_final =
        "ROGER ESTA EN PROCESO";

    subtitulo_final =
        "Algunas decisiones ayudaron, pero todavia hay cosas por mejorar.";

    mensaje_final =
        "Frente al ciberacoso, buscar apoyo y actuar con seguridad es mejor que enfrentar el problema solo.";

    texto_estado =
        "EN PROCESO";

    color_final =
        make_color_rgb(
            235,
            185,
            75
        );
}

// ============================================================================
// FINAL 3
// ============================================================================

else
{
    titulo_final =
        "ROGER NECESITA MAS APOYO";

    subtitulo_final =
        "La situacion termino siendo mas dificil para Roger.";

    mensaje_final =
        "Cuando una situacion en internet te hace sentir mal, hablar con un adulto de confianza es una buena decision.";

    texto_estado =
        "NECESITA APOYO";

    color_final =
        make_color_rgb(
            220,
            105,
            115
        );
}
