// ============================================================================
// OBJ_ESTILO_DIALOGO
// EVENTO DRAW GUI COMPLETO
// ============================================================================

// ============================================================================
// NO DIBUJAR SI ESTA OCULTO
// ============================================================================

if (alpha_panel <= 0)
{
    exit;
}

// ============================================================================
// DATOS GUI
// ============================================================================

var gui_w =
    display_get_gui_width();

var gui_h =
    display_get_gui_height();

// ============================================================================
// DIMENSIONES GENERALES
// ============================================================================

var panel_w =
    gui_w * 0.90 * escala_panel;

var panel_h =
    gui_h * 0.22 * escala_panel;

var centro_x =
    gui_w / 2;

var panel_x1 =
    centro_x
    - panel_w / 2;

var panel_x2 =
    centro_x
    + panel_w / 2;

var panel_y2 =
    gui_h
    - gui_h * 0.045
    + desplazamiento_y;

var panel_y1 =
    panel_y2
    - panel_h;

// ============================================================================
// OSCURECER SUAVEMENTE LA PARTE INFERIOR
// ============================================================================

draw_set_alpha(
    0.10
    * alpha_panel
);

draw_set_color(c_black);

draw_rectangle(
    0,
    gui_h * 0.60,
    gui_w,
    gui_h,
    false
);

// ============================================================================
// SOMBRA DEL PANEL
// ============================================================================

draw_set_alpha(
    0.34
    * alpha_panel
);

draw_set_color(c_black);

draw_roundrect(
    panel_x1 + 8,
    panel_y1 + 10,
    panel_x2 + 8,
    panel_y2 + 10,
    false
);

// ============================================================================
// PANEL PRINCIPAL TRANSPARENTE
// ============================================================================

draw_set_alpha(
    0.42
    * alpha_panel
);

draw_set_color(
    make_color_rgb(
        18,
        22,
        31
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
// BORDE EXTERIOR
// ============================================================================

draw_set_alpha(
    0.90
    * alpha_panel
);

draw_set_color(
    make_color_rgb(
        82,
        118,
        180
    )
);

draw_roundrect(
    panel_x1 - 2,
    panel_y1 - 2,
    panel_x2 + 2,
    panel_y2 + 2,
    true
);

// ============================================================================
// BORDE INTERIOR
// ============================================================================

draw_set_alpha(
    0.50
    * alpha_panel
);

draw_set_color(
    make_color_rgb(
        115,
        150,
        215
    )
);

draw_roundrect(
    panel_x1 + 5,
    panel_y1 + 5,
    panel_x2 - 5,
    panel_y2 - 5,
    true
);

// ============================================================================
// BARRA DE ACENTO SUPERIOR
// ============================================================================

draw_set_alpha(
    0.95
    * alpha_panel
);

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
    panel_y1 + 7,
    false
);

// ============================================================================
// CABECERA
// ============================================================================

var cabecera_w =
    185;

var cabecera_h =
    32;

var cabecera_x1 =
    panel_x1 + 22;

var cabecera_x2 =
    cabecera_x1
    + cabecera_w;

var cabecera_y1 =
    panel_y1 - 14;

var cabecera_y2 =
    cabecera_y1
    + cabecera_h;

// ============================================================================
// SOMBRA CABECERA
// ============================================================================

draw_set_alpha(
    0.30
    * alpha_panel
);

draw_set_color(c_black);

draw_roundrect(
    cabecera_x1 + 4,
    cabecera_y1 + 4,
    cabecera_x2 + 4,
    cabecera_y2 + 4,
    false
);

// ============================================================================
// FONDO CABECERA
// ============================================================================

draw_set_alpha(
    alpha_panel
);

draw_set_color(
    make_color_rgb(
        37,
        47,
        66
    )
);

draw_roundrect(
    cabecera_x1,
    cabecera_y1,
    cabecera_x2,
    cabecera_y2,
    false
);

// ============================================================================
// ICONO DE CONVERSACION
// ============================================================================

var icono_x =
    cabecera_x1 + 19;

var icono_y =
    (
        cabecera_y1
        +
        cabecera_y2
    )
    / 2;

draw_set_color(
    make_color_rgb(
        100,
        165,
        240
    )
);

draw_circle(
    icono_x,
    icono_y,
    8,
    false
);

// ============================================================================
// PUNTO DE PULSO
// ============================================================================

draw_set_alpha(
    (
        0.45
        +
        pulso * 0.45
    )
    *
    alpha_panel
);

draw_set_color(
    make_color_rgb(
        140,
        200,
        255
    )
);

draw_circle(
    icono_x,
    icono_y,
    12,
    true
);

// ============================================================================
// TEXTO CABECERA
// ============================================================================

draw_set_alpha(alpha_panel);

draw_set_halign(fa_left);

draw_set_valign(fa_middle);

draw_set_color(c_white);

draw_text(
    cabecera_x1 + 37,
    icono_y,
    "CONVERSACION"
);

// ============================================================================
// DECORACION SUPERIOR DERECHA
// ============================================================================

var punto_y =
    panel_y1 + 24;

var punto_x =
    panel_x2 - 65;

draw_set_alpha(
    0.75
    * alpha_panel
);

draw_set_color(
    make_color_rgb(
        90,
        140,
        220
    )
);

draw_circle(
    punto_x,
    punto_y,
    4,
    false
);

draw_set_color(
    make_color_rgb(
        75,
        105,
        160
    )
);

draw_circle(
    punto_x + 18,
    punto_y,
    4,
    false
);

draw_set_color(
    make_color_rgb(
        60,
        80,
        120
    )
);

draw_circle(
    punto_x + 36,
    punto_y,
    4,
    false
);

// ============================================================================
// LINEA DECORATIVA IZQUIERDA
// ============================================================================

draw_set_alpha(
    0.85
    * alpha_panel
);

draw_set_color(
    make_color_rgb(
        80,
        135,
        215
    )
);

draw_rectangle(
    panel_x1 + 15,
    panel_y1 + 38,
    panel_x1 + 20,
    panel_y2 - 22,
    false
);

// ============================================================================
// ESQUINA DECORATIVA INFERIOR DERECHA
// ============================================================================

draw_set_alpha(
    0.30
    * alpha_panel
);

draw_set_color(
    make_color_rgb(
        90,
        140,
        220
    )
);

draw_circle(
    panel_x2 - 30,
    panel_y2 - 25,
    22,
    true
);

draw_circle(
    panel_x2 - 30,
    panel_y2 - 25,
    13,
    true
);

// ============================================================================
// TEXTO PEQUEÑO DE APOYO
// ============================================================================

draw_set_alpha(
    0.55
    * alpha_panel
);

draw_set_halign(fa_right);

draw_set_valign(fa_bottom);

draw_set_color(
    make_color_rgb(
        165,
        175,
        195
    )
);

draw_text(
    panel_x2 - 28,
    panel_y2 - 12,
    "THE SOCIAL MEDIA GAME"
);

// ============================================================================
// RESTAURAR DRAW
// ============================================================================

draw_set_alpha(1);

draw_set_color(c_white);

draw_set_halign(fa_left);

draw_set_valign(fa_top);