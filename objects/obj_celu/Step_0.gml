// ============================================================================
// OBJ_CELU
// EVENTO STEP COMPLETO
// ============================================================================

// ============================================================================
// VARIABLES DE TELEVUELO
// ============================================================================

if (!variable_instance_exists(id, "mensaje_televuelo_preparado"))
{
    mensaje_televuelo_preparado = false;
}

if (!variable_instance_exists(id, "mensaje_televuelo_enviado"))
{
    mensaje_televuelo_enviado = false;
}

if (!variable_instance_exists(id, "texto_mensaje_televuelo"))
{
    texto_mensaje_televuelo =
        "No me parece bien que compartan esa foto sin mi permiso.";
}

// ============================================================================
// VARIABLES DE INSTAPIX
// ============================================================================

if (!variable_instance_exists(id, "captura_instapix_guardada"))
{
    captura_instapix_guardada = false;
}

if (!variable_instance_exists(id, "cuenta_instapix_bloqueada"))
{
    cuenta_instapix_bloqueada = false;
}

// ============================================================================
// VARIABLES DE CHATAMIX
// ============================================================================

if (!variable_instance_exists(id, "mensaje_chatamix_preparado"))
{
    mensaje_chatamix_preparado = false;
}

if (!variable_instance_exists(id, "mensaje_chatamix_enviado"))
{
    mensaje_chatamix_enviado = false;
}

if (!variable_instance_exists(id, "respuesta_amigo_visible"))
{
    respuesta_amigo_visible = false;
}

// ============================================================================
// TIEMPO DE "MENSAJE ENVIADO" (ChatAmix y TeleVuelo)
// ============================================================================

if (!variable_instance_exists(id, "duracion_enviado"))
{
    duracion_enviado = 90;
}

if (!variable_instance_exists(id, "tiempo_enviado_chatamix"))
{
    tiempo_enviado_chatamix = 0;
}

if (!variable_instance_exists(id, "tiempo_enviado_televuelo"))
{
    tiempo_enviado_televuelo = 0;
}

// Cuenta solo mientras la app esta abierta, asi se alcanza a ver el estado.
if (app_actual == "chatamix" && mensaje_chatamix_enviado)
{
    tiempo_enviado_chatamix += 1;
}

if (app_actual == "televuelo" && mensaje_televuelo_enviado)
{
    tiempo_enviado_televuelo += 1;
}

// ============================================================================
// ESTADO DE AUDIO / NOTIFICACIONES
// ============================================================================

if (!variable_instance_exists(id, "aviso_sonoro_anterior"))
{
    aviso_sonoro_anterior = false;
}

// ============================================================================
// ¿SE PUEDE MOSTRAR?
// ============================================================================

puede_mostrarse = true;

if (room == Room1)
{
    puede_mostrarse = false;
}

if (room == Room7)
{
    puede_mostrarse = false;
}

// ============================================================================
// OCULTAR DURANTE DIALOGOS
// ============================================================================

if (instance_exists(Obj_controlador_dialogo))
{
    if (Obj_controlador_dialogo.dialogo_activo)
    {
        puede_mostrarse = false;

        celular_abierto = false;

        app_actual = "inicio";
    }
}

// ============================================================================
// SI NO SE PUEDE MOSTRAR
// ============================================================================

if (!puede_mostrarse)
{
    celular_abierto = false;

    app_actual = "inicio";
}

// ============================================================================
// DATOS GUI
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
// ESCALA
// ============================================================================

var altura_objetivo =
    gui_h * porcentaje_altura_abierto;

escala_celu =
    altura_objetivo / spr_h;

// ============================================================================
// POSICION
// ============================================================================

celu_x =
    (gui_w - spr_w * escala_celu) / 2;

celu_y =
    (gui_h - spr_h * escala_celu) / 2;

// ============================================================================
// TAMAÑO
// ============================================================================

var ancho_celu =
    spr_w * escala_celu;

var alto_celu =
    spr_h * escala_celu;

// ============================================================================
// MOUSE
// ============================================================================

var mx =
    device_mouse_x_to_gui(0);

var my =
    device_mouse_y_to_gui(0);

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
// NOTIFICACIONES DE APPS
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

var hay_aviso_sonoro =
    global.decision_pendiente ||
    aviso_televuelo ||
    aviso_instapix ||
    aviso_chatamix;

if (hay_aviso_sonoro && !aviso_sonoro_anterior)
{
    if (asset_get_index("snd_notificacion") != -1)
    {
        audio_play_sound(snd_notificacion, 10, false);
    }
}

aviso_sonoro_anterior = hay_aviso_sonoro;

// ============================================================================
// ABRIR / CERRAR CON E
// ============================================================================

if (puede_mostrarse)
{
    if (keyboard_check_pressed(ord("E")))
    {
        celular_abierto =
            !celular_abierto;

        if (asset_get_index("snd_click") != -1)
        {
            audio_play_sound(snd_click, 8, false);
        }

        if (!celular_abierto)
        {
            app_actual =
                "inicio";
        }
    }
}

// Escape vuelve a la pantalla principal de la app o cierra el celular.
if (puede_mostrarse && celular_abierto && keyboard_check_pressed(vk_escape))
{
    if (app_actual != "inicio")
    {
        app_actual = "inicio";
    }
    else
    {
        celular_abierto = false;
    }

    if (asset_get_index("snd_click") != -1)
    {
        audio_play_sound(snd_click, 8, false);
    }
}

// ============================================================================
// CELULAR CERRADO
// ============================================================================

if (
    puede_mostrarse &&
    !celular_abierto
)
{
    var escala_pequena =
        altura_cerrado / spr_h;

    var ancho_pequeno =
        spr_w * escala_pequena;

    var alto_pequeno =
        spr_h * escala_pequena;

    var boton_x =
        gui_w - ancho_pequeno - 25;

    var boton_y =
        gui_h - alto_pequeno - 25;

    if (mouse_check_button_pressed(mb_left))
    {
        if (
            mx >= boton_x &&
            mx <= boton_x + ancho_pequeno &&
            my >= boton_y &&
            my <= boton_y + alto_pequeno
        )
        {
            celular_abierto = true;

            app_actual = "inicio";

            if (asset_get_index("snd_click") != -1)
            {
                audio_play_sound(snd_click, 8, false);
            }
        }
    }
}

// ============================================================================
// CELULAR ABIERTO
// ============================================================================

if (
    puede_mostrarse &&
    celular_abierto
)
{
    decision_x =
        celu_x
        + spr_w
        * 0.50
        * escala_celu;

    decision_y =
        celu_y
        + spr_h
        * 0.65
        * escala_celu;

    if (mouse_check_button_pressed(mb_left))
    {
        // ====================================================================
        // MENU PRINCIPAL
        // ====================================================================

        if (app_actual == "inicio")
        {
            // ================================================================
            // FACEAMIGOS
            // ================================================================

            if (
                mx >= celu_x + spr_w * 0.22 * escala_celu &&
                mx <= celu_x + spr_w * 0.49 * escala_celu &&
                my >= celu_y + spr_h * 0.16 * escala_celu &&
                my <= celu_y + spr_h * 0.34 * escala_celu
            )
            {
                app_actual =
                    "faceamigos";

                if (asset_get_index("snd_click") != -1)
                {
                    audio_play_sound(snd_click, 8, false);
                }
            }

            // ================================================================
            // CHATAMIX
            // ================================================================

            else if (
                mx >= celu_x + spr_w * 0.51 * escala_celu &&
                mx <= celu_x + spr_w * 0.79 * escala_celu &&
                my >= celu_y + spr_h * 0.16 * escala_celu &&
                my <= celu_y + spr_h * 0.34 * escala_celu
            )
            {
                app_actual =
                    "chatamix";

                if (asset_get_index("snd_click") != -1)
                {
                    audio_play_sound(snd_click, 8, false);
                }
            }

            // ================================================================
            // INSTAPIX
            // ================================================================

            else if (
                mx >= celu_x + spr_w * 0.22 * escala_celu &&
                mx <= celu_x + spr_w * 0.49 * escala_celu &&
                my >= celu_y + spr_h * 0.35 * escala_celu &&
                my <= celu_y + spr_h * 0.52 * escala_celu
            )
            {
                app_actual =
                    "instapix";

                if (asset_get_index("snd_click") != -1)
                {
                    audio_play_sound(snd_click, 8, false);
                }
            }

            // ================================================================
            // TELEVUELO
            // ================================================================

            else if (
                mx >= celu_x + spr_w * 0.51 * escala_celu &&
                mx <= celu_x + spr_w * 0.79 * escala_celu &&
                my >= celu_y + spr_h * 0.35 * escala_celu &&
                my <= celu_y + spr_h * 0.52 * escala_celu
            )
            {
                app_actual =
                    "televuelo";

                if (asset_get_index("snd_click") != -1)
                {
                    audio_play_sound(snd_click, 8, false);
                }
            }

            // ================================================================
            // DECISIONES
            // ================================================================

            else if (
                mx >= celu_x + spr_w * 0.20 * escala_celu &&
                mx <= celu_x + spr_w * 0.80 * escala_celu &&
                my >= celu_y + spr_h * 0.56 * escala_celu &&
                my <= celu_y + spr_h * 0.75 * escala_celu
            )
            {
                app_actual =
                    "decisiones";

                if (asset_get_index("snd_click") != -1)
                {
                    audio_play_sound(snd_click, 8, false);
                }

                opcion_seleccionada =
                    false;
            }
        }

        // ====================================================================
        // DECISIONES
        // ====================================================================

        else if (app_actual == "decisiones")
        {
            // Las zonas de clic usan exactamente las mismas proporciones
            // que los botones dibujados en Draw GUI.
            var bx1 = celu_x + ancho_celu * 0.10;
            var bx2 = celu_x + ancho_celu * 0.90;

            var by1_arriba = celu_y + alto_celu * 0.40;
            var by1_abajo  = celu_y + alto_celu * 0.51;

            var by2_arriba = celu_y + alto_celu * 0.54;
            var by2_abajo  = celu_y + alto_celu * 0.65;

            var by3_arriba = celu_y + alto_celu * 0.68;
            var by3_abajo  = celu_y + alto_celu * 0.79;

            var decision_elegida = 0;

            if (
                global.decision_pendiente &&
                !opcion_seleccionada
            )
            {
                if (
                    mx >= bx1 && mx <= bx2 &&
                    my >= by1_arriba && my <= by1_abajo
                )
                {
                    decision_elegida = 1;
                }
                else if (
                    mx >= bx1 && mx <= bx2 &&
                    my >= by2_arriba && my <= by2_abajo
                )
                {
                    decision_elegida = 2;
                }
                else if (
                    mx >= bx1 && mx <= bx2 &&
                    my >= by3_arriba && my <= by3_abajo
                )
                {
                    decision_elegida = 3;
                }
            }

            if (decision_elegida > 0)
            {
                if (global.decision_actual == 1) global.decision1 = decision_elegida;
                else if (global.decision_actual == 2) global.decision2 = decision_elegida;
                else if (global.decision_actual == 3) global.decision3 = decision_elegida;
                else if (global.decision_actual == 4) global.decision4 = decision_elegida;

                opcion_seleccionada = true;
                celular_abierto = false;
                app_actual = "inicio";

                if (asset_get_index("snd_decision") != -1)
                {
                    audio_play_sound(snd_decision, 12, false);
                }
            }

            // VOLVER
            if (
                mx >= celu_x + ancho_celu * 0.36 &&
                mx <= celu_x + ancho_celu * 0.64 &&
                my >= celu_y + alto_celu * 0.875 &&
                my <= celu_y + alto_celu * 0.935
            )
            {
                app_actual = "inicio";

                if (asset_get_index("snd_click") != -1)
                {
                    audio_play_sound(snd_click, 8, false);
                }
            }
        }

        // ====================================================================
        // CHATAMIX
        // ====================================================================

        else if (app_actual == "chatamix")
        {
            if (
                puede_escribir_amigo &&
                !mensaje_chatamix_preparado &&
                !mensaje_chatamix_enviado
            )
            {
                if (
                    mx >= celu_x + ancho_celu * 0.05 &&
                    mx <= celu_x + ancho_celu * 0.95 &&
                    my >= celu_y + alto_celu * 0.89 &&
                    my <= celu_y + alto_celu * 0.97
                )
                {
                    mensaje_chatamix_preparado =
                        true;

                    if (asset_get_index("snd_click") != -1)
                    {
                        audio_play_sound(snd_click, 8, false);
                    }
                }
            }

            else if (
                puede_escribir_amigo &&
                mensaje_chatamix_preparado &&
                !mensaje_chatamix_enviado
            )
            {
                if (
                    mx >= celu_x + ancho_celu * 0.05 &&
                    mx <= celu_x + ancho_celu * 0.95 &&
                    my >= celu_y + alto_celu * 0.89 &&
                    my <= celu_y + alto_celu * 0.97
                )
                {
                    mensaje_chatamix_enviado =
                        true;

                    if (asset_get_index("snd_decision") != -1)
                    {
                        audio_play_sound(snd_decision, 12, false);
                    }

                    mensaje_chatamix_preparado =
                        false;

                    respuesta_amigo_visible =
                        true;
                }
            }

            if (
                mx >= celu_x + ancho_celu * 0.00 &&
                mx <= celu_x + ancho_celu * 0.16 &&
                my >= celu_y + alto_celu * 0.04 &&
                my <= celu_y + alto_celu * 0.14
            )
            {
                app_actual =
                    "inicio";

                if (asset_get_index("snd_click") != -1)
                {
                    audio_play_sound(snd_click, 8, false);
                }
            }
        }

        // ====================================================================
        // INSTAPIX
        // ====================================================================

        else if (app_actual == "instapix")
        {
            if (
                puede_actuar_instapix &&
                !captura_instapix_guardada
            )
            {
                if (
                    mx >= celu_x + ancho_celu * 0.05 &&
                    mx <= celu_x + ancho_celu * 0.95 &&
                    my >= celu_y + alto_celu * 0.78 &&
                    my <= celu_y + alto_celu * 0.86
                )
                {
                    captura_instapix_guardada =
                        true;

                    if (asset_get_index("snd_click") != -1)
                    {
                        audio_play_sound(snd_click, 8, false);
                    }
                }
            }

            else if (
                puede_actuar_instapix &&
                captura_instapix_guardada &&
                !cuenta_instapix_bloqueada
            )
            {
                if (
                    mx >= celu_x + ancho_celu * 0.05 &&
                    mx <= celu_x + ancho_celu * 0.95 &&
                    my >= celu_y + alto_celu * 0.78 &&
                    my <= celu_y + alto_celu * 0.86
                )
                {
                    cuenta_instapix_bloqueada =
                        true;

                    if (asset_get_index("snd_decision") != -1)
                    {
                        audio_play_sound(snd_decision, 12, false);
                    }
                }
            }

            // El icono de inicio de la barra inferior vuelve al menu del celular.
            if (
                mx >= celu_x + ancho_celu * 0.06 &&
                mx <= celu_x + ancho_celu * 0.18 &&
                my >= celu_y + alto_celu * 0.92 &&
                my <= celu_y + alto_celu * 0.98
            )
            {
                app_actual =
                    "inicio";

                if (asset_get_index("snd_click") != -1)
                {
                    audio_play_sound(snd_click, 8, false);
                }
            }
        }

        // ====================================================================
        // FACEAMIGOS
        // ====================================================================

        else if (app_actual == "faceamigos")
        {
            // El icono "Inicio" de la barra inferior vuelve al menu del celular.
            if (
                mx >= celu_x + ancho_celu * 0.04 &&
                mx <= celu_x + ancho_celu * 0.16 &&
                my >= celu_y + alto_celu * 0.92 &&
                my <= celu_y + alto_celu * 0.99
            )
            {
                app_actual = "inicio";

                if (asset_get_index("snd_click") != -1)
                {
                    audio_play_sound(snd_click, 8, false);
                }
            }
        }

        // ====================================================================
        // TELEVUELO
        // ====================================================================

        else if (app_actual == "televuelo")
        {
            if (
                puede_responder_televuelo &&
                !mensaje_televuelo_preparado &&
                !mensaje_televuelo_enviado
            )
            {
                if (
                    mx >= celu_x + ancho_celu * 0.05 &&
                    mx <= celu_x + ancho_celu * 0.95 &&
                    my >= celu_y + alto_celu * 0.89 &&
                    my <= celu_y + alto_celu * 0.97
                )
                {
                    mensaje_televuelo_preparado =
                        true;

                    if (asset_get_index("snd_click") != -1)
                    {
                        audio_play_sound(snd_click, 8, false);
                    }
                }
            }

            else if (
                puede_responder_televuelo &&
                mensaje_televuelo_preparado &&
                !mensaje_televuelo_enviado
            )
            {
                if (
                    mx >= celu_x + ancho_celu * 0.05 &&
                    mx <= celu_x + ancho_celu * 0.95 &&
                    my >= celu_y + alto_celu * 0.89 &&
                    my <= celu_y + alto_celu * 0.97
                )
                {
                    mensaje_televuelo_enviado =
                        true;

                    if (asset_get_index("snd_decision") != -1)
                    {
                        audio_play_sound(snd_decision, 12, false);
                    }

                    mensaje_televuelo_preparado =
                        false;
                }
            }

            if (
                mx >= celu_x + ancho_celu * 0.00 &&
                mx <= celu_x + ancho_celu * 0.16 &&
                my >= celu_y + alto_celu * 0.04 &&
                my <= celu_y + alto_celu * 0.14
            )
            {
                app_actual =
                    "inicio";

                if (asset_get_index("snd_click") != -1)
                {
                    audio_play_sound(snd_click, 8, false);
                }
            }
        }

        // ====================================================================
        // OTRAS APPS
        // ====================================================================

        else
        {
            if (
                mx >= celu_x + spr_w * 0.30 * escala_celu &&
                mx <= celu_x + spr_w * 0.70 * escala_celu &&
                my >= celu_y + spr_h * 0.88 * escala_celu &&
                my <= celu_y + spr_h * escala_celu
            )
            {
                app_actual =
                    "inicio";

                if (asset_get_index("snd_click") != -1)
                {
                    audio_play_sound(snd_click, 8, false);
                }
            }
        }
    }
}

// ============================================================================
// REINICIAR SELECCION
// ============================================================================

if (!global.decision_pendiente)
{
    opcion_seleccionada =
        false;
}
