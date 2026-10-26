// ============================================================================
// OBJ_CELU
// EVENTO DRAW GUI COMPLETO
// ============================================================================

if (!puede_mostrarse)
{
    exit;
}

// ============================================================================
// DATOS GENERALES
// ============================================================================

var gui_w =
    display_get_gui_width();

var gui_h =
    display_get_gui_height();

var spr_w =
    sprite_get_width(spr_telefono);

var spr_h =
    sprite_get_height(spr_telefono);

// ============================================================================
// MOUSE GUI
// ============================================================================

var mx =
    device_mouse_x_to_gui(0);

var my =
    device_mouse_y_to_gui(0);

// ============================================================================
// BUSCAR SPRITES DE LAS APPS
// ============================================================================

var spr_ui_chatamix =
    spr_chatamix_ui;

var spr_ui_instapix =
    spr_instapix_ui;

var spr_ui_faceamigos =
    spr_faceamigos_ui;

var spr_ui_televuelo =
    spr_televuelo_ui;

// ============================================================================
// ANIMACION DE AVISOS
// ============================================================================

var alpha_aviso =
    0.75
    + 0.25
    * sin(current_time / 180);

alpha_aviso =
    clamp(
        alpha_aviso,
        0.55,
        1
    );

// ============================================================================
// RAMA TELEVUELO
// ============================================================================

var puede_responder_televuelo =
    false;

if (variable_global_exists("respondio"))
{
    puede_responder_televuelo =
        global.respondio;
}

// ============================================================================
// RAMA INSTAPIX
// ============================================================================

var puede_actuar_instapix =
    false;

if (
    variable_global_exists("guardo_pruebas") &&
    variable_global_exists("bloqueo_agresores")
)
{
    if (
        global.guardo_pruebas &&
        global.bloqueo_agresores
    )
    {
        puede_actuar_instapix =
            true;
    }
}

// ============================================================================
// RAMA CHATAMIX
// ============================================================================

var puede_escribir_amigo =
    false;

if (variable_global_exists("conto_amigo"))
{
    puede_escribir_amigo =
        global.conto_amigo;
}

// ============================================================================
// NOTIFICACIONES
// ============================================================================

var aviso_televuelo =
    false;

var aviso_instapix =
    false;

var aviso_chatamix =
    false;

if (
    puede_responder_televuelo &&
    !mensaje_televuelo_enviado
)
{
    aviso_televuelo = true;
}

if (
    puede_actuar_instapix &&
    (
        !captura_instapix_guardada ||
        !cuenta_instapix_bloqueada
    )
)
{
    aviso_instapix = true;
}

if (
    puede_escribir_amigo &&
    !mensaje_chatamix_enviado
)
{
    aviso_chatamix = true;
}

// ============================================================================
// CELULAR CERRADO
// ============================================================================

if (!celular_abierto)
{
    var escala_pequena =
        altura_cerrado / spr_h;

    var ancho_pequeno =
        spr_w * escala_pequena;

    var alto_pequeno =
        spr_h * escala_pequena;

    var margen =
        25;

    var boton_x =
        gui_w - ancho_pequeno - margen;

    var boton_y =
        gui_h - alto_pequeno - margen;

    draw_sprite_ext(
        spr_telefono,
        0,
        boton_x,
        boton_y,
        escala_pequena,
        escala_pequena,
        0,
        c_white,
        1
    );

    // Tecla de acceso compacta y mas clara
    draw_set_alpha(0.92);
    draw_set_color(make_color_rgb(22, 27, 38));
    draw_roundrect(
        boton_x - 9,
        boton_y - 34,
        boton_x + ancho_pequeno + 9,
        boton_y - 8,
        false
    );

    draw_set_alpha(1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(125, 180, 245));
    draw_text(
        boton_x + ancho_pequeno / 2,
        boton_y - 21,
        "E  ·  ABRIR"
    );

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    // ========================================================================
    // AVISO GENERAL DEL CELULAR
    // ========================================================================

    var hay_aviso_celu =
        global.decision_pendiente ||
        aviso_televuelo ||
        aviso_instapix ||
        aviso_chatamix;

    if (hay_aviso_celu)
    {
        var aviso_x =
            boton_x + ancho_pequeno - 3;

        var aviso_y =
            boton_y + 3;

        draw_set_alpha(alpha_aviso);

        draw_set_color(c_yellow);

        draw_circle(
            aviso_x,
            aviso_y,
            13,
            false
        );

        draw_set_alpha(1);

        draw_set_color(c_black);

        draw_set_halign(fa_center);

        draw_set_valign(fa_middle);

        draw_text(
            aviso_x,
            aviso_y,
            "!"
        );

        draw_set_halign(fa_left);

        draw_set_valign(fa_top);
    }
}

// ============================================================================
// CELULAR ABIERTO
// ============================================================================

if (celular_abierto)
{
    var altura_objetivo =
        gui_h * porcentaje_altura_abierto;

    escala_celu =
        altura_objetivo / spr_h;

    var ancho_celu =
        spr_w * escala_celu;

    var alto_celu =
        spr_h * escala_celu;

    celu_x =
        (gui_w - ancho_celu) / 2;

    celu_y =
        (gui_h - alto_celu) / 2;

    // ========================================================================
    // OSCURECER FONDO DEL JUEGO
    // ========================================================================

    draw_set_alpha(0.50);

    draw_set_color(c_black);

    draw_rectangle(
        0,
        0,
        gui_w,
        gui_h,
        false
    );

    draw_set_alpha(1);

    // ========================================================================
    // MENU PRINCIPAL DEL CELULAR
    // ========================================================================

    if (app_actual == "inicio")
    {
        draw_sprite_ext(
            spr_telefono,
            0,
            celu_x,
            celu_y,
            escala_celu,
            escala_celu,
            0,
            c_white,
            1
        );

        // ====================================================================
        // NOTIFICACION CHATAMIX
        // ====================================================================

        if (aviso_chatamix)
        {
            var notif_x =
                celu_x + ancho_celu * 0.75;

            var notif_y =
                celu_y + alto_celu * 0.18;

            draw_set_alpha(alpha_aviso);

            draw_set_color(c_red);

            draw_circle(
                notif_x,
                notif_y,
                11,
                false
            );

            draw_set_alpha(1);

            draw_set_color(c_white);

            draw_set_halign(fa_center);

            draw_set_valign(fa_middle);

            draw_text(
                notif_x,
                notif_y,
                "!"
            );
        }

        // ====================================================================
        // NOTIFICACION INSTAPIX
        // ====================================================================

        if (aviso_instapix)
        {
            var notif_x =
                celu_x + ancho_celu * 0.45;

            var notif_y =
                celu_y + alto_celu * 0.365;

            draw_set_alpha(alpha_aviso);

            draw_set_color(c_red);

            draw_circle(
                notif_x,
                notif_y,
                11,
                false
            );

            draw_set_alpha(1);

            draw_set_color(c_white);

            draw_set_halign(fa_center);

            draw_set_valign(fa_middle);

            draw_text(
                notif_x,
                notif_y,
                "!"
            );
        }

        // ====================================================================
        // NOTIFICACION TELEVUELO
        // ====================================================================

        if (aviso_televuelo)
        {
            var notif_x =
                celu_x + ancho_celu * 0.75;

            var notif_y =
                celu_y + alto_celu * 0.365;

            draw_set_alpha(alpha_aviso);

            draw_set_color(c_red);

            draw_circle(
                notif_x,
                notif_y,
                11,
                false
            );

            draw_set_alpha(1);

            draw_set_color(c_white);

            draw_set_halign(fa_center);

            draw_set_valign(fa_middle);

            draw_text(
                notif_x,
                notif_y,
                "!"
            );
        }

        // ====================================================================
        // BOTON DECISIONES
        // ====================================================================

        var decisiones_centro_x =
            celu_x + ancho_celu * 0.50;

        var decisiones_y =
            celu_y + alto_celu * 0.65;

        draw_set_color(
            make_color_rgb(
                30,
                48,
                82
            )
        );

        draw_roundrect(
            celu_x + ancho_celu * 0.20,
            celu_y + alto_celu * 0.56,
            celu_x + ancho_celu * 0.80,
            celu_y + alto_celu * 0.75,
            false
        );

        draw_set_color(make_color_rgb(80, 145, 225));
        draw_roundrect(
            celu_x + ancho_celu * 0.20,
            celu_y + alto_celu * 0.56,
            celu_x + ancho_celu * 0.80,
            celu_y + alto_celu * 0.75,
            true
        );

        if (global.decision_pendiente)
        {
            draw_set_alpha(alpha_aviso);

            draw_set_color(c_yellow);

            draw_roundrect(
                celu_x + ancho_celu * 0.20,
                celu_y + alto_celu * 0.56,
                celu_x + ancho_celu * 0.80,
                celu_y + alto_celu * 0.75,
                true
            );

            draw_set_alpha(1);
        }

        draw_set_halign(fa_center);

        draw_set_valign(fa_middle);

        if (global.decision_pendiente)
        {
            draw_set_color(c_yellow);
        }
        else
        {
            draw_set_color(c_white);
        }

        draw_text(
            decisiones_centro_x,
            decisiones_y,
            "Decisiones"
        );

        if (global.decision_pendiente)
        {
            draw_set_color(c_yellow);

            draw_text(
                decisiones_centro_x,
                celu_y + alto_celu * 0.735,
                "NUEVA"
            );
        }

        draw_set_halign(fa_left);

        draw_set_valign(fa_top);
    }

    // ========================================================================
    // PANTALLAS DE LAS APPS
    // Cada estado de la app tiene su propio sprite (con botones incluidos).
    // Las zonas de clic estan en el Step y coinciden con esos botones.
    // ========================================================================

    // ========================================================================
    // CHATAMIX
    // ========================================================================

    if (app_actual == "chatamix")
    {
        var spr_pantalla_chatamix = spr_ui_chatamix;

        if (puede_escribir_amigo)
        {
            if (mensaje_chatamix_preparado)
            {
                spr_pantalla_chatamix = spr_chatamix_escrito;
            }
            else if (!mensaje_chatamix_enviado)
            {
                spr_pantalla_chatamix = spr_chatamix_inicial;
            }
            else if (tiempo_enviado_chatamix < duracion_enviado)
            {
                spr_pantalla_chatamix = spr_chatamix_enviado;
            }
            else if (global.decision_pendiente)
            {
                spr_pantalla_chatamix = spr_chatamix_aviso;
            }
            else
            {
                spr_pantalla_chatamix = spr_chatamix_respuesta;
            }
        }

        draw_sprite_stretched(spr_pantalla_chatamix, 0, celu_x, celu_y, ancho_celu, alto_celu);
    }

    // ========================================================================
    // INSTAPIX
    // ========================================================================

    if (app_actual == "instapix")
    {
        var spr_pantalla_instapix = spr_ui_instapix;

        if (puede_actuar_instapix)
        {
            if (!captura_instapix_guardada)
            {
                spr_pantalla_instapix = spr_instapix_captura;
            }
            else if (!cuenta_instapix_bloqueada)
            {
                spr_pantalla_instapix = spr_instapix_guardada;
            }
            else
            {
                spr_pantalla_instapix = spr_instapix_bloqueada;
            }
        }
        else if (global.publicacion_aparecio && global.decision2 == 0)
        {
            spr_pantalla_instapix = spr_instapix_publicacion;
        }

        draw_sprite_stretched(spr_pantalla_instapix, 0, celu_x, celu_y, ancho_celu, alto_celu);
    }

    // ========================================================================
    // FACEAMIGOS
    // ========================================================================

    if (app_actual == "faceamigos")
    {
        var spr_pantalla_faceamigos = spr_ui_faceamigos;

        if (global.publicacion_aparecio)
        {
            spr_pantalla_faceamigos = spr_faceamigos_publicacion;
        }

        draw_sprite_stretched(spr_pantalla_faceamigos, 0, celu_x, celu_y, ancho_celu, alto_celu);
    }

    // ========================================================================
    // TELEVUELO
    // ========================================================================

    if (app_actual == "televuelo")
    {
        var spr_pantalla_televuelo = spr_ui_televuelo;

        if (puede_responder_televuelo)
        {
            if (mensaje_televuelo_preparado)
            {
                spr_pantalla_televuelo = spr_televuelo_escrito;
            }
            else if (!mensaje_televuelo_enviado)
            {
                spr_pantalla_televuelo = spr_televuelo_inicial;
            }
            else if (tiempo_enviado_televuelo < duracion_enviado)
            {
                spr_pantalla_televuelo = spr_televuelo_enviado;
            }
            else if (global.decision_pendiente)
            {
                spr_pantalla_televuelo = spr_televuelo_aviso;
            }
            else
            {
                spr_pantalla_televuelo = spr_televuelo_notificaciones;
            }
        }

        draw_sprite_stretched(spr_pantalla_televuelo, 0, celu_x, celu_y, ancho_celu, alto_celu);
    }

    // ========================================================================
    // AYUDA PARA VOLVER (dentro de cualquier app)
    // ========================================================================

    if (app_actual == "chatamix" || app_actual == "instapix" || app_actual == "faceamigos" || app_actual == "televuelo")
    {
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(make_color_rgb(125, 180, 245));
        draw_text(celu_x + ancho_celu / 2, celu_y + alto_celu + 24, "ESC  ·  VOLVER AL MENU");
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    }

    // ========================================================================
    // ========================================================================
    // DECISIONES - NUEVA INTERFAZ
    // ========================================================================
    // ========================================================================

    if (app_actual == "decisiones")
    {
        // ====================================================================
        // FONDO
        // ====================================================================

        draw_set_color(
            make_color_rgb(
                16,
                18,
                24
            )
        );

        draw_rectangle(
            celu_x,
            celu_y,
            celu_x + ancho_celu,
            celu_y + alto_celu,
            false
        );

        // ====================================================================
        // CABECERA
        // ====================================================================

        draw_set_color(
            make_color_rgb(
                35,
                38,
                50
            )
        );

        draw_rectangle(
            celu_x,
            celu_y,
            celu_x + ancho_celu,
            celu_y + alto_celu * 0.12,
            false
        );

        draw_set_halign(fa_center);

        draw_set_valign(fa_middle);

        draw_set_color(c_white);

        draw_text(
            celu_x + ancho_celu / 2,
            celu_y + alto_celu * 0.055,
            "DECISIONES"
        );

        // ====================================================================
        // ESTADO
        // ====================================================================

        if (global.decision_pendiente)
        {
            draw_set_alpha(alpha_aviso);

            draw_set_color(c_yellow);

            draw_circle(
                celu_x + ancho_celu * 0.86,
                celu_y + alto_celu * 0.055,
                9,
                false
            );

            draw_set_alpha(1);

            draw_set_color(c_black);

            draw_text(
                celu_x + ancho_celu * 0.86,
                celu_y + alto_celu * 0.055,
                "!"
            );
        }

        // ====================================================================
        // DATOS DE LA DECISION
        // ====================================================================

        var pregunta_decision =
            "";

        var texto_opcion1 =
            "";

        var texto_opcion2 =
            "";

        var texto_opcion3 =
            "";

        if (
            global.decision_pendiente &&
            global.decision_actual == 1
        )
        {
            pregunta_decision =
                "¿Que deberia hacer Roger?";

            texto_opcion1 =
                "Entrar a clases";

            texto_opcion2 =
                "Usar el celular";

            texto_opcion3 =
                "No entrar a clases";
        }

        else if (
            global.decision_pendiente &&
            global.decision_actual == 2
        )
        {
            pregunta_decision =
                "¿Que hacer con la publicacion?";

            texto_opcion1 =
                "Responder";

            texto_opcion2 =
                "Guardar pruebas y bloquear";

            texto_opcion3 =
                "Ignorar";
        }

        else if (
            global.decision_pendiente &&
            global.decision_actual == 3
        )
        {
            pregunta_decision =
                "¿A quien deberia pedir ayuda Roger?";

            texto_opcion1 =
                "Contarselo a un amigo";

            texto_opcion2 =
                "Hablar con el profesor";

            texto_opcion3 =
                "No contarselo a nadie";
        }

        else if (
            global.decision_pendiente &&
            global.decision_actual == 4
        )
        {
            pregunta_decision =
                "¿Que deberia hacer ahora Roger?";

            texto_opcion1 =
                "Hablar con su familia";

            texto_opcion2 =
                "Hablar con la psicologa";

            texto_opcion3 =
                "Seguir solo";
        }

        // ====================================================================
        // SI HAY DECISION
        // ====================================================================

        if (global.decision_pendiente)
        {
            // ================================================================
            // INDICADOR DE ETAPA
            // ================================================================

            draw_set_halign(fa_left);

            draw_set_valign(fa_middle);

            draw_set_color(
                make_color_rgb(
                    145,
                    145,
                    155
                )
            );

            draw_text(
                celu_x + ancho_celu * 0.10,
                celu_y + alto_celu * 0.155,
                "DECISION "
                + string(global.decision_actual)
                + " DE 4"
            );

            // ================================================================
            // TARJETA DE PREGUNTA
            // ================================================================

            draw_set_color(
                make_color_rgb(
                    30,
                    33,
                    44
                )
            );

            draw_roundrect(
                celu_x + ancho_celu * 0.07,
                celu_y + alto_celu * 0.20,
                celu_x + ancho_celu * 0.93,
                celu_y + alto_celu * 0.34,
                false
            );

            draw_set_halign(fa_center);

            draw_set_valign(fa_middle);

            draw_set_color(c_white);

            draw_text(
                celu_x + ancho_celu * 0.50,
                celu_y + alto_celu * 0.27,
                pregunta_decision
            );

            // ================================================================
            // POSICIONES BOTONES
            // ================================================================

            var bx1 =
                celu_x + ancho_celu * 0.10;

            var bx2 =
                celu_x + ancho_celu * 0.90;

            var by1_arriba =
                celu_y + alto_celu * 0.40;

            var by1_abajo =
                celu_y + alto_celu * 0.51;

            var by2_arriba =
                celu_y + alto_celu * 0.54;

            var by2_abajo =
                celu_y + alto_celu * 0.65;

            var by3_arriba =
                celu_y + alto_celu * 0.68;

            var by3_abajo =
                celu_y + alto_celu * 0.79;

            // ================================================================
            // HOVER OPCION 1
            // ================================================================

            var hover1 =
                mx >= bx1 &&
                mx <= bx2 &&
                my >= by1_arriba &&
                my <= by1_abajo;

            // ================================================================
            // HOVER OPCION 2
            // ================================================================

            var hover2 =
                mx >= bx1 &&
                mx <= bx2 &&
                my >= by2_arriba &&
                my <= by2_abajo;

            // ================================================================
            // HOVER OPCION 3
            // ================================================================

            var hover3 =
                mx >= bx1 &&
                mx <= bx2 &&
                my >= by3_arriba &&
                my <= by3_abajo;

            // ================================================================
            // OPCION 1
            // ================================================================

            if (hover1)
            {
                draw_set_color(
                    make_color_rgb(
                        75,
                        82,
                        110
                    )
                );
            }
            else
            {
                draw_set_color(
                    make_color_rgb(
                        45,
                        49,
                        65
                    )
                );
            }

            draw_roundrect(
                bx1,
                by1_arriba,
                bx2,
                by1_abajo,
                false
            );

            draw_set_color(
                make_color_rgb(
                    100,
                    110,
                    150
                )
            );

            draw_circle(
                celu_x + ancho_celu * 0.18,
                (by1_arriba + by1_abajo) / 2,
                15,
                false
            );

            draw_set_color(c_white);

            draw_set_halign(fa_center);

            draw_set_valign(fa_middle);

            draw_text(
                celu_x + ancho_celu * 0.18,
                (by1_arriba + by1_abajo) / 2,
                "1"
            );

            draw_set_halign(fa_left);

            draw_text(
                celu_x + ancho_celu * 0.27,
                (by1_arriba + by1_abajo) / 2,
                texto_opcion1
            );

            // ================================================================
            // OPCION 2
            // ================================================================

            if (hover2)
            {
                draw_set_color(
                    make_color_rgb(
                        75,
                        82,
                        110
                    )
                );
            }
            else
            {
                draw_set_color(
                    make_color_rgb(
                        45,
                        49,
                        65
                    )
                );
            }

            draw_roundrect(
                bx1,
                by2_arriba,
                bx2,
                by2_abajo,
                false
            );

            draw_set_color(
                make_color_rgb(
                    100,
                    110,
                    150
                )
            );

            draw_circle(
                celu_x + ancho_celu * 0.18,
                (by2_arriba + by2_abajo) / 2,
                15,
                false
            );

            draw_set_color(c_white);

            draw_set_halign(fa_center);

            draw_text(
                celu_x + ancho_celu * 0.18,
                (by2_arriba + by2_abajo) / 2,
                "2"
            );

            draw_set_halign(fa_left);

            draw_text(
                celu_x + ancho_celu * 0.27,
                (by2_arriba + by2_abajo) / 2,
                texto_opcion2
            );

            // ================================================================
            // OPCION 3
            // ================================================================

            if (hover3)
            {
                draw_set_color(
                    make_color_rgb(
                        75,
                        82,
                        110
                    )
                );
            }
            else
            {
                draw_set_color(
                    make_color_rgb(
                        45,
                        49,
                        65
                    )
                );
            }

            draw_roundrect(
                bx1,
                by3_arriba,
                bx2,
                by3_abajo,
                false
            );

            draw_set_color(
                make_color_rgb(
                    100,
                    110,
                    150
                )
            );

            draw_circle(
                celu_x + ancho_celu * 0.18,
                (by3_arriba + by3_abajo) / 2,
                15,
                false
            );

            draw_set_color(c_white);

            draw_set_halign(fa_center);

            draw_text(
                celu_x + ancho_celu * 0.18,
                (by3_arriba + by3_abajo) / 2,
                "3"
            );

            draw_set_halign(fa_left);

            draw_text(
                celu_x + ancho_celu * 0.27,
                (by3_arriba + by3_abajo) / 2,
                texto_opcion3
            );

            // ================================================================
            // TEXTO INFERIOR
            // ================================================================

            draw_set_halign(fa_center);

            draw_set_color(
                make_color_rgb(
                    150,
                    150,
                    160
                )
            );

            draw_text(
                celu_x + ancho_celu / 2,
                celu_y + alto_celu * 0.835,
                "Elegi la opcion que consideres mejor."
            );
        }

        // ====================================================================
        // SIN DECISION PENDIENTE
        // ====================================================================

        else
        {
            draw_set_color(
                make_color_rgb(
                    30,
                    33,
                    44
                )
            );

            draw_roundrect(
                celu_x + ancho_celu * 0.10,
                celu_y + alto_celu * 0.32,
                celu_x + ancho_celu * 0.90,
                celu_y + alto_celu * 0.62,
                false
            );

            draw_set_halign(fa_center);

            draw_set_valign(fa_middle);

            draw_set_color(c_lime);

            draw_circle(
                celu_x + ancho_celu / 2,
                celu_y + alto_celu * 0.405,
                19,
                true
            );

            draw_set_color(c_white);

            draw_text(
                celu_x + ancho_celu / 2,
                celu_y + alto_celu * 0.50,
                "No hay decisiones pendientes."
            );

            draw_set_color(
                make_color_rgb(
                    150,
                    150,
                    160
                )
            );

            draw_text(
                celu_x + ancho_celu / 2,
                celu_y + alto_celu * 0.56,
                "Podes seguir con la historia."
            );
        }

        // ====================================================================
        // VOLVER
        // ====================================================================

        var volver_hover =
            mx >= celu_x + ancho_celu * 0.36 &&
            mx <= celu_x + ancho_celu * 0.64 &&
            my >= celu_y + alto_celu * 0.875 &&
            my <= celu_y + alto_celu * 0.935;

        if (volver_hover)
        {
            draw_set_color(
                make_color_rgb(
                    65,
                    68,
                    80
                )
            );
        }
        else
        {
            draw_set_color(
                make_color_rgb(
                    35,
                    38,
                    48
                )
            );
        }

        draw_roundrect(
            celu_x + ancho_celu * 0.36,
            celu_y + alto_celu * 0.875,
            celu_x + ancho_celu * 0.64,
            celu_y + alto_celu * 0.935,
            false
        );

        draw_set_halign(fa_center);

        draw_set_valign(fa_middle);

        draw_set_color(c_white);

        draw_text(
            celu_x + ancho_celu / 2,
            celu_y + alto_celu * 0.905,
            "‹ Volver"
        );

        draw_set_halign(fa_left);

        draw_set_valign(fa_top);
    }

    // ========================================================================
    // AYUDA RAPIDA PARA CERRAR EL CELULAR
    // ========================================================================

    var ayuda_cerrar_x1 = celu_x + ancho_celu + 18;
    var ayuda_cerrar_y1 = celu_y + alto_celu * 0.84;
    var ayuda_cerrar_x2 = ayuda_cerrar_x1 + 118;
    var ayuda_cerrar_y2 = ayuda_cerrar_y1 + 34;

    if (ayuda_cerrar_x2 > gui_w - 12)
    {
        ayuda_cerrar_x2 = celu_x - 18;
        ayuda_cerrar_x1 = ayuda_cerrar_x2 - 118;
    }

    draw_set_alpha(0.88);
    draw_set_color(make_color_rgb(22, 27, 38));
    draw_roundrect(ayuda_cerrar_x1, ayuda_cerrar_y1, ayuda_cerrar_x2, ayuda_cerrar_y2, false);

    draw_set_alpha(1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(125, 180, 245));
    draw_text((ayuda_cerrar_x1 + ayuda_cerrar_x2) / 2, (ayuda_cerrar_y1 + ayuda_cerrar_y2) / 2, "E  ·  CERRAR");

    // ========================================================================
    // RESTAURAR DRAW
    // ========================================================================

    draw_set_alpha(1);

    draw_set_color(c_white);

    draw_set_halign(fa_left);

    draw_set_valign(fa_top);
}
