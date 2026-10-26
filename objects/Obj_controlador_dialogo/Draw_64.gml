// ============================================================
// OBJ_CONTROLADOR_DIALOGO
// EVENTO DRAW GUI COMPLETO
// ============================================================

var gui_w =
    display_get_gui_width();

var gui_h =
    display_get_gui_height();

// ============================================================
// CARGA
// ============================================================

if (estado == "cargando")
{
    draw_set_color(c_black);

    draw_rectangle(
        0,
        0,
        gui_w,
        gui_h,
        false
    );

    draw_set_color(c_white);

    draw_set_halign(fa_center);

    draw_set_valign(fa_middle);

    draw_text(
        gui_w / 2,
        gui_h / 2,
        "Cargando..."
    );

    draw_set_halign(fa_left);

    draw_set_valign(fa_top);
}

// ============================================================
// DIALOGOS - INTERFAZ MODERNA + TEXTO PROGRESIVO
// ============================================================

if (dialogo_activo)
{
    var caja_x1 = 58;
    var caja_y1 = gui_h - 205;
    var caja_x2 = gui_w - 58;
    var caja_y2 = gui_h - 34;

    // Sombra
    draw_set_alpha(0.34);
    draw_set_color(c_black);
    draw_roundrect(caja_x1 + 8, caja_y1 + 9, caja_x2 + 8, caja_y2 + 9, false);

    // Panel principal
    draw_set_alpha(0.94);
    draw_set_color(make_color_rgb(18, 23, 34));
    draw_roundrect(caja_x1, caja_y1, caja_x2, caja_y2, false);

    // Borde y acento
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(82, 128, 205));
    draw_roundrect(caja_x1 - 1, caja_y1 - 1, caja_x2 + 1, caja_y2 + 1, true);
    draw_set_color(make_color_rgb(95, 155, 235));
    draw_roundrect(caja_x1, caja_y1, caja_x2, caja_y1 + 7, false);

    // Obtener hablante y mensaje
    var nombre_hablante = "CONVERSACION";
    var mensaje_completo = texto_actual_dialogo;
    var separador = string_pos(": ", mensaje_completo);
    var longitud_prefijo = 0;

    if (separador > 0)
    {
        nombre_hablante = string_copy(mensaje_completo, 1, separador - 1);
        longitud_prefijo = separador + 1;
        mensaje_completo = string_delete(mensaje_completo, 1, longitud_prefijo);
    }

    var visibles_mensaje = max(0, caracteres_visibles - longitud_prefijo);
    visibles_mensaje = min(visibles_mensaje, string_length(mensaje_completo));
    var mensaje_visible = string_copy(mensaje_completo, 1, visibles_mensaje);

    // Insignia del hablante
    var tag_x1 = caja_x1 + 22;
    var tag_y1 = caja_y1 - 18;
    var tag_x2 = tag_x1 + 190;
    var tag_y2 = tag_y1 + 36;

    draw_set_color(make_color_rgb(35, 45, 64));
    draw_roundrect(tag_x1, tag_y1, tag_x2, tag_y2, false);
    draw_set_color(make_color_rgb(105, 170, 245));
    draw_circle(tag_x1 + 19, (tag_y1 + tag_y2) / 2, 8, false);

    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text(tag_x1 + 36, (tag_y1 + tag_y2) / 2, string_upper(nombre_hablante));

    // Mensaje
    draw_set_valign(fa_top);
    draw_set_color(make_color_rgb(235, 239, 247));
    draw_text_ext(
        caja_x1 + 28,
        caja_y1 + 44,
        mensaje_visible,
        28,
        (caja_x2 - caja_x1) - 56
    );

    // Indicador de escritura en curso
    if (!texto_dialogo_completo)
    {
        var puntos = 1 + (floor(current_time / 220) mod 3);
        var txt_puntos = "";
        repeat (puntos) txt_puntos += ".";

        draw_set_halign(fa_right);
        draw_set_valign(fa_bottom);
        draw_set_color(make_color_rgb(120, 165, 225));
        draw_text(caja_x2 - 24, caja_y2 - 16, txt_puntos);
    }

    // Linea inferior decorativa
    draw_set_alpha(0.55);
    draw_set_color(make_color_rgb(70, 92, 130));
    draw_rectangle(caja_x1 + 28, caja_y2 - 20, caja_x2 - 28, caja_y2 - 18, false);

    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

// ============================================================
// PANTALLA DE RESULTADOS
// ROOM 7
// ============================================================

if (
    room == Room7 &&
    (
        estado == "final_apoyo" ||
        estado == "final_proceso" ||
        estado == "final_mas_apoyo"
    )
)
{
    // ========================================================
    // OSCURECER EL FONDO
    // ========================================================

    draw_set_alpha(0.82);

    draw_set_color(c_black);

    draw_rectangle(
        0,
        0,
        gui_w,
        gui_h,
        false
    );

    draw_set_alpha(1);

    // ========================================================
    // PANEL CENTRAL
    // ========================================================

    var panel_x1 =
        gui_w * 0.15;

    var panel_y1 =
        35;

    var panel_x2 =
        gui_w * 0.85;

    var panel_y2 =
        gui_h - 35;

    draw_set_color(
        make_color_rgb(
            20,
            20,
            20
        )
    );

    draw_roundrect(
        panel_x1,
        panel_y1,
        panel_x2,
        panel_y2,
        false
    );

    draw_set_color(c_white);

    draw_roundrect(
        panel_x1,
        panel_y1,
        panel_x2,
        panel_y2,
        true
    );

    draw_set_halign(fa_center);

    draw_set_valign(fa_middle);

    // ========================================================
    // TITULO
    // ========================================================

    draw_set_color(c_white);

    draw_text(
        gui_w / 2,
        70,
        "THE SOCIAL MEDIA GAME"
    );

    draw_text(
        gui_w / 2,
        110,
        "RESULTADO DE LA HISTORIA"
    );

    // ========================================================
    // FINAL
    // ========================================================

    if (estado == "final_apoyo")
    {
        draw_set_color(c_lime);

        draw_text(
            gui_w / 2,
            155,
            "ROGER ENCUENTRA APOYO"
        );

        draw_set_color(c_white);

        draw_text(
            gui_w / 2,
            195,
            "Roger busco ayuda y aprendio formas de actuar ante el ciberbullying."
        );
    }

    else if (estado == "final_proceso")
    {
        draw_set_color(c_yellow);

        draw_text(
            gui_w / 2,
            155,
            "ROGER SIGUE EN PROCESO"
        );

        draw_set_color(c_white);

        draw_text(
            gui_w / 2,
            195,
            "Algunas decisiones ayudaron, pero todavia necesita apoyo."
        );
    }

    else if (estado == "final_mas_apoyo")
    {
        draw_set_color(c_orange);

        draw_text(
            gui_w / 2,
            155,
            "ROGER NECESITA MAS APOYO"
        );

        draw_set_color(c_white);

        draw_text(
            gui_w / 2,
            195,
            "La situacion continua y es importante buscar ayuda de confianza."
        );
    }

    // ========================================================
    // ESTADISTICAS
    // ========================================================

    draw_set_color(c_white);

    draw_text(
        gui_w / 2,
        250,
        "Bienestar: "
        + string(global.bienestar)
        + " / 100"
    );

    draw_text(
        gui_w / 2,
        280,
        "Apoyo: "
        + string(global.apoyo)
        + " / 100"
    );

    draw_text(
        gui_w / 2,
        310,
        "Acoso: "
        + string(global.acoso)
        + " / 100"
    );

    draw_text(
        gui_w / 2,
        340,
        "Puntaje final: "
        + string(puntaje_final)
    );

    // ========================================================
    // RESUMEN DE DECISIONES
    // ========================================================

    draw_text(
        gui_w / 2,
        390,
        "TUS DECISIONES"
    );

    // ========================================================
    // DECISION 1
    // ========================================================

    var texto_d1 = "";

    if (global.decision1 == 1)
    {
        texto_d1 =
            "Decision 1: Entrar a clases";
    }

    else if (global.decision1 == 2)
    {
        texto_d1 =
            "Decision 1: Usar el celular";
    }

    else if (global.decision1 == 3)
    {
        texto_d1 =
            "Decision 1: No entrar a clases";
    }

    draw_text(
        gui_w / 2,
        425,
        texto_d1
    );

    // ========================================================
    // DECISION 2
    // ========================================================

    var texto_d2 = "";

    if (global.decision2 == 1)
    {
        texto_d2 =
            "Decision 2: Responder";
    }

    else if (global.decision2 == 2)
    {
        texto_d2 =
            "Decision 2: Guardar pruebas y bloquear";
    }

    else if (global.decision2 == 3)
    {
        texto_d2 =
            "Decision 2: Ignorar";
    }

    draw_text(
        gui_w / 2,
        455,
        texto_d2
    );

    // ========================================================
    // DECISION 3
    // ========================================================

    var texto_d3 = "";

    if (global.decision3 == 1)
    {
        texto_d3 =
            "Decision 3: Contarselo a sus amigos";
    }

    else if (global.decision3 == 2)
    {
        texto_d3 =
            "Decision 3: Hablar con el profesor";
    }

    else if (global.decision3 == 3)
    {
        texto_d3 =
            "Decision 3: No contarselo a nadie";
    }

    draw_text(
        gui_w / 2,
        485,
        texto_d3
    );

    // ========================================================
    // DECISION 4
    // ========================================================

    var texto_d4 = "";

    if (global.decision4 == 1)
    {
        texto_d4 =
            "Decision 4: Hablar con su familia";
    }

    else if (global.decision4 == 2)
    {
        texto_d4 =
            "Decision 4: Hablar con la psicologa";
    }

    else if (global.decision4 == 3)
    {
        texto_d4 =
            "Decision 4: Seguir solo";
    }

    draw_text(
        gui_w / 2,
        515,
        texto_d4
    );

    // ========================================================
    // MENSAJE EDUCATIVO
    // ========================================================

    draw_set_color(c_white);

    draw_text(
        gui_w / 2,
        gui_h - 105,
        "Guardar pruebas, bloquear y pedir ayuda pueden ser pasos importantes."
    );

    draw_text(
        gui_w / 2,
        gui_h - 65,
        "PRESIONA R PARA VOLVER A JUGAR"
    );

    // ========================================================
    // RESTAURAR
    // ========================================================

    draw_set_halign(fa_left);

    draw_set_valign(fa_top);
}

// ============================================================
// RESTAURAR DRAW
// ============================================================

draw_set_color(c_white);

draw_set_alpha(1);

draw_set_halign(fa_left);

draw_set_valign(fa_top);
