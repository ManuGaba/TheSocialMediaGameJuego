// ============================================================================
// OBJ_OBJETIVO_HISTORIA
// EVENTO DRAW GUI COMPLETO
// ============================================================================

// ============================================================================
// NO DIBUJAR SI ESTA OCULTO
// ============================================================================

if (alpha_objetivo <= 0)
{
    exit;
}

// ============================================================================
// DATOS GUI
// ============================================================================

var gui_w =
    display_get_gui_width();

// ============================================================================
// TAMAÑO DEL PANEL
// ============================================================================

var panel_w =
    410;

var panel_h =
    100;

// ============================================================================
// POSICION
// ============================================================================

var margen =
    22;

var panel_x2 =
    gui_w
    - margen
    + desplazamiento_x;

var panel_x1 =
    panel_x2
    - panel_w;

var panel_y1 =
    22;

var panel_y2 =
    panel_y1
    + panel_h;

// ============================================================================
// SOMBRA
// ============================================================================

draw_set_alpha(
    0.30
    * alpha_objetivo
);

draw_set_color(c_black);

draw_roundrect(
    panel_x1 + 6,
    panel_y1 + 7,
    panel_x2 + 6,
    panel_y2 + 7,
    false
);

// ============================================================================
// FONDO PRINCIPAL
// ============================================================================

draw_set_alpha(
    0.94
    * alpha_objetivo
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
    * alpha_objetivo
);

draw_set_color(
    make_color_rgb(
        75,
        120,
        195
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
// ICONO
// ============================================================================

var icono_x =
    panel_x1 + 38;

var icono_y =
    panel_y1 + panel_h / 2;

draw_set_alpha(
    alpha_objetivo
);

draw_set_color(
    make_color_rgb(
        90,
        150,
        235
    )
);

draw_circle(
    icono_x,
    icono_y,
    20,
    false
);

// ============================================================================
// CIRCULO INTERIOR
// ============================================================================

draw_set_color(
    make_color_rgb(
        22,
        27,
        38
    )
);

draw_circle(
    icono_x,
    icono_y,
    14,
    false
);

// ============================================================================
// SIGNO
// ============================================================================

draw_set_halign(fa_center);

draw_set_valign(fa_middle);

draw_set_color(
    make_color_rgb(
        125,
        180,
        250
    )
);

draw_text(
    icono_x,
    icono_y,
    "!"
);

// ============================================================================
// TITULO
// ============================================================================

draw_set_halign(fa_left);

draw_set_valign(fa_top);

draw_set_color(
    make_color_rgb(
        115,
        170,
        245
    )
);

draw_text(
    panel_x1 + 72,
    panel_y1 + 20,
    "OBJETIVO ACTUAL"
);

// ============================================================================
// TEXTO
// ============================================================================

draw_set_color(c_white);

draw_text(
    panel_x1 + 72,
    panel_y1 + 52,
    texto_objetivo
);

// ============================================================================
// AVISO DE DECISION
// ============================================================================

if (
    variable_global_exists("decision_pendiente") &&
    global.decision_pendiente
)
{
    var aviso_x =
        panel_x2 - 27;

    var aviso_y =
        panel_y1 + 25;

    var pulso_aviso =
        0.78
        +
        0.22
        *
        sin(
            current_time / 180
        );

    draw_set_alpha(
        pulso_aviso
        *
        alpha_objetivo
    );

    draw_set_color(
        make_color_rgb(
            245,
            195,
            65
        )
    );

    draw_circle(
        aviso_x,
        aviso_y,
        11,
        false
    );

    draw_set_color(
        make_color_rgb(
            25,
            27,
            34
        )
    );

    draw_set_halign(fa_center);

    draw_set_valign(fa_middle);

    draw_text(
        aviso_x,
        aviso_y,
        "!"
    );
}

// ============================================================================
// RESTAURAR DRAW
// ============================================================================

draw_set_alpha(1);

draw_set_color(c_white);

draw_set_halign(fa_left);

draw_set_valign(fa_top);