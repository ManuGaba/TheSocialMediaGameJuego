// ============================================================================
// OBJ_INDICADOR_CONTINUAR
// EVENTO DRAW GUI COMPLETO
// ============================================================================

// ============================================================================
// NO DIBUJAR
// ============================================================================

if (alpha_indicador <= 0)
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
// PANEL
// ============================================================================

var panel_w =
    260
    *
    escala_indicador;

var panel_h =
    52
    *
    escala_indicador;

var panel_x2 =
    gui_w
    -
    28;

var panel_x1 =
    panel_x2
    -
    panel_w;

var panel_y2 =
    gui_h
    -
    24;

var panel_y1 =
    panel_y2
    -
    panel_h;

// ============================================================================
// SOMBRA
// ============================================================================

draw_set_alpha(
    0.30
    *
    alpha_indicador
);

draw_set_color(c_black);

draw_roundrect(
    panel_x1 + 5,
    panel_y1 + 5,
    panel_x2 + 5,
    panel_y2 + 5,
    false
);

// ============================================================================
// PANEL PRINCIPAL
// ============================================================================

draw_set_alpha(
    0.92
    *
    alpha_indicador
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
// TECLA
// ============================================================================

var tecla_x1 =
    panel_x1 + 11;

var tecla_x2 =
    panel_x1 + 93;

var tecla_y1 =
    panel_y1 + 9;

var tecla_y2 =
    panel_y2 - 9;

draw_set_color(
    make_color_rgb(
        232,
        236,
        245
    )
);

draw_roundrect(
    tecla_x1,
    tecla_y1,
    tecla_x2,
    tecla_y2,
    false
);

// ============================================================================
// ESPACIO
// ============================================================================

draw_set_alpha(
    alpha_indicador
);

draw_set_halign(fa_center);

draw_set_valign(fa_middle);

draw_set_color(
    make_color_rgb(
        28,
        32,
        42
    )
);

draw_text(
    (
        tecla_x1
        +
        tecla_x2
    )
    / 2,
    (
        tecla_y1
        +
        tecla_y2
    )
    / 2,
    "ESPACIO"
);

// ============================================================================
// CONTINUAR
// ============================================================================

draw_set_halign(fa_left);

draw_set_color(c_white);

draw_text(
    panel_x1 + 108,
    (
        panel_y1
        +
        panel_y2
    )
    / 2,
    "Continuar"
);

// ============================================================================
// FLECHA ANIMADA
// ============================================================================

var desplazamiento_flecha =
    sin(
        current_time / 180
    )
    *
    3;

draw_set_halign(fa_center);

draw_set_color(
    make_color_rgb(
        110,
        170,
        245
    )
);

draw_text(
    panel_x2
    -
    20
    +
    desplazamiento_flecha,
    (
        panel_y1
        +
        panel_y2
    )
    / 2,
    ">"
);

// ============================================================================
// RESTAURAR DRAW
// ============================================================================

draw_set_alpha(1);

draw_set_color(c_white);

draw_set_halign(fa_left);

draw_set_valign(fa_top);