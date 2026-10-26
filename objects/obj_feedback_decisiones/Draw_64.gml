// ============================================================================
// OBJ_FEEDBACK_DECISIONES
// EVENTO DRAW GUI COMPLETO
// ============================================================================

// ============================================================================
// NO DIBUJAR SI NO HAY FEEDBACK
// ============================================================================

if (!feedback_activo)
{
    exit;
}

if (
    room == Room1 ||
    room == Room7
)
{
    exit;
}

// ============================================================================
// DATOS GUI
// ============================================================================

var gui_w =
    display_get_gui_width();

var centro_x =
    gui_w / 2;

// ============================================================================
// CONTAR CAMBIOS
// ============================================================================

var cantidad_cambios =
    0;

if (cambio_bienestar != 0)
{
    cantidad_cambios += 1;
}

if (cambio_apoyo != 0)
{
    cantidad_cambios += 1;
}

if (cambio_acoso != 0)
{
    cantidad_cambios += 1;
}

// ============================================================================
// PANEL
// ============================================================================

var panel_w =
    470;

var panel_h =
    72
    +
    cantidad_cambios
    *
    37;

var panel_x1 =
    centro_x
    -
    panel_w / 2;

var panel_x2 =
    centro_x
    +
    panel_w / 2;

var panel_y1 =
    28
    +
    desplazamiento_y;

var panel_y2 =
    panel_y1
    +
    panel_h;

// ============================================================================
// SOMBRA
// ============================================================================

draw_set_alpha(
    0.34
    *
    alpha_feedback
);

draw_set_color(c_black);

draw_roundrect(
    panel_x1 + 7,
    panel_y1 + 8,
    panel_x2 + 7,
    panel_y2 + 8,
    false
);

// ============================================================================
// FONDO
// ============================================================================

draw_set_alpha(
    0.96
    *
    alpha_feedback
);

draw_set_color(
    make_color_rgb(
        22,
        27,
        38
    )
);

draw_roundrect(
    panel_x1,
    panel_y1,
    panel_x2,
    panel_y2,
    false
);

// ============================================================================
// BORDE
// ============================================================================

draw_set_alpha(
    0.85
    *
    alpha_feedback
);

draw_set_color(
    make_color_rgb(
        80,
        125,
        200
    )
);

draw_roundrect(
    panel_x1 - 1,
    panel_y1 - 1,
    panel_x2 + 1,
    panel_y2 + 1,
    true
);

// ============================================================================
// BARRA SUPERIOR
// ============================================================================

draw_set_color(
    make_color_rgb(
        90,
        140,
        220
    )
);

draw_roundrect(
    panel_x1,
    panel_y1,
    panel_x2,
    panel_y1 + 6,
    false
);

// ============================================================================
// TITULO
// ============================================================================

draw_set_alpha(
    alpha_feedback
);

draw_set_halign(fa_center);

draw_set_valign(fa_middle);

draw_set_color(c_white);

draw_text(
    centro_x,
    panel_y1 + 31,
    "CONSECUENCIA DE TU DECISION"
);

// ============================================================================
// SUBTITULO
// ============================================================================

draw_set_color(
    make_color_rgb(
        145,
        155,
        175
    )
);

draw_text(
    centro_x,
    panel_y1 + 53,
    "Tus decisiones cambian la historia"
);

// ============================================================================
// LINEAS
// ============================================================================

var linea_y =
    panel_y1 + 88;

// ============================================================================
// BIENESTAR
// ============================================================================

if (cambio_bienestar != 0)
{
    var color_bienestar;

    if (cambio_bienestar > 0)
    {
        color_bienestar =
            make_color_rgb(
                100,
                190,
                235
            );
    }
    else
    {
        color_bienestar =
            make_color_rgb(
                225,
                110,
                115
            );
    }

    draw_set_color(
        make_color_rgb(
            31,
            36,
            49
        )
    );

    draw_roundrect(
        panel_x1 + 22,
        linea_y - 14,
        panel_x2 - 22,
        linea_y + 16,
        false
    );

    draw_set_halign(fa_left);

    draw_set_valign(fa_middle);

    draw_set_color(
        color_bienestar
    );

    if (cambio_bienestar > 0)
    {
        draw_text(
            panel_x1 + 38,
            linea_y,
            "Bienestar mejoro"
        );
    }
    else
    {
        draw_text(
            panel_x1 + 38,
            linea_y,
            "Bienestar disminuyo"
        );
    }

    draw_set_halign(fa_right);

    if (cambio_bienestar > 0)
    {
        draw_text(
            panel_x2 - 38,
            linea_y,
            "+"
            +
            string(cambio_bienestar)
        );
    }
    else
    {
        draw_text(
            panel_x2 - 38,
            linea_y,
            string(cambio_bienestar)
        );
    }

    linea_y += 37;
}

// ============================================================================
// APOYO
// ============================================================================

if (cambio_apoyo != 0)
{
    var color_apoyo;

    if (cambio_apoyo > 0)
    {
        color_apoyo =
            make_color_rgb(
                105,
                215,
                145
            );
    }
    else
    {
        color_apoyo =
            make_color_rgb(
                230,
                150,
                95
            );
    }

    draw_set_color(
        make_color_rgb(
            31,
            36,
            49
        )
    );

    draw_roundrect(
        panel_x1 + 22,
        linea_y - 14,
        panel_x2 - 22,
        linea_y + 16,
        false
    );

    draw_set_halign(fa_left);

    draw_set_color(
        color_apoyo
    );

    if (cambio_apoyo > 0)
    {
        draw_text(
            panel_x1 + 38,
            linea_y,
            "Roger recibio mas apoyo"
        );
    }
    else
    {
        draw_text(
            panel_x1 + 38,
            linea_y,
            "Roger tiene menos apoyo"
        );
    }

    draw_set_halign(fa_right);

    if (cambio_apoyo > 0)
    {
        draw_text(
            panel_x2 - 38,
            linea_y,
            "+"
            +
            string(cambio_apoyo)
        );
    }
    else
    {
        draw_text(
            panel_x2 - 38,
            linea_y,
            string(cambio_apoyo)
        );
    }

    linea_y += 37;
}

// ============================================================================
// ACOSO
// ============================================================================

if (cambio_acoso != 0)
{
    var color_acoso;

    if (cambio_acoso > 0)
    {
        color_acoso =
            make_color_rgb(
                225,
                105,
                105
            );
    }
    else
    {
        color_acoso =
            make_color_rgb(
                105,
                210,
                145
            );
    }

    draw_set_color(
        make_color_rgb(
            31,
            36,
            49
        )
    );

    draw_roundrect(
        panel_x1 + 22,
        linea_y - 14,
        panel_x2 - 22,
        linea_y + 16,
        false
    );

    draw_set_halign(fa_left);

    draw_set_color(
        color_acoso
    );

    if (cambio_acoso > 0)
    {
        draw_text(
            panel_x1 + 38,
            linea_y,
            "La situacion de acoso empeoro"
        );
    }
    else
    {
        draw_text(
            panel_x1 + 38,
            linea_y,
            "La situacion de acoso disminuyo"
        );
    }

    draw_set_halign(fa_right);

    if (cambio_acoso > 0)
    {
        draw_text(
            panel_x2 - 38,
            linea_y,
            "+"
            +
            string(cambio_acoso)
        );
    }
    else
    {
        draw_text(
            panel_x2 - 38,
            linea_y,
            string(cambio_acoso)
        );
    }
}

// ============================================================================
// RESTAURAR DRAW
// ============================================================================

draw_set_alpha(1);

draw_set_color(c_white);

draw_set_halign(fa_left);

draw_set_valign(fa_top);
