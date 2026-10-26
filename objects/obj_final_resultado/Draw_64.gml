// ============================================================================
// OBJ_FINAL_RESULTADO
// EVENTO DRAW GUI COMPLETO
// ============================================================================

// ============================================================================
// DATOS GUI
// ============================================================================

var gui_w =
    display_get_gui_width();

var gui_h =
    display_get_gui_height();

var centro_x =
    gui_w / 2;

// ============================================================================
// FONDO GENERAL
// ============================================================================

draw_set_alpha(1);

draw_set_color(
    make_color_rgb(
        15,
        19,
        28
    )
);

draw_rectangle(
    0,
    0,
    gui_w,
    gui_h,
    false
);

// ============================================================================
// DECORACION DE FONDO
// ============================================================================

draw_set_alpha(
    0.10
    *
    alpha_panel
);

draw_set_color(
    color_final
);

draw_circle(
    gui_w * 0.12,
    gui_h * 0.18,
    140,
    false
);

draw_circle(
    gui_w * 0.88,
    gui_h * 0.80,
    180,
    false
);

draw_set_alpha(
    0.05
    *
    alpha_panel
);

draw_circle(
    gui_w * 0.82,
    gui_h * 0.15,
    90,
    false
);

// ============================================================================
// CONTENEDOR PRINCIPAL
// ============================================================================

var panel_w =
    gui_w * 0.86 * escala_panel;

var panel_h =
    gui_h * 0.84 * escala_panel;

var panel_x1 =
    centro_x
    -
    panel_w / 2;

var panel_x2 =
    centro_x
    +
    panel_w / 2;

var panel_y1 =
    gui_h * 0.08
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
    0.35
    *
    alpha_panel
);

draw_set_color(c_black);

draw_roundrect(
    panel_x1 + 10,
    panel_y1 + 12,
    panel_x2 + 10,
    panel_y2 + 12,
    false
);

// ============================================================================
// PANEL
// ============================================================================

draw_set_alpha(
    0.97
    *
    alpha_panel
);

draw_set_color(
    make_color_rgb(
        23,
        28,
        39
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
    0.90
    *
    alpha_panel
);

draw_set_color(
    color_final
);

draw_roundrect(
    panel_x1 - 2,
    panel_y1 - 2,
    panel_x2 + 2,
    panel_y2 + 2,
    true
);

// ============================================================================
// BARRA SUPERIOR
// ============================================================================

draw_set_alpha(
    alpha_panel
);

draw_set_color(
    color_final
);

draw_roundrect(
    panel_x1,
    panel_y1,
    panel_x2,
    panel_y1 + 8,
    false
);

// ============================================================================
// ICONO CENTRAL
// ============================================================================

var icono_x =
    centro_x;

var icono_y =
    panel_y1 + 62;

draw_set_alpha(
    0.20
    *
    alpha_panel
);

draw_set_color(
    color_final
);

draw_circle(
    icono_x,
    icono_y,
    42
    +
    pulso * 4,
    false
);

draw_set_alpha(
    alpha_panel
);

draw_set_color(
    color_final
);

draw_circle(
    icono_x,
    icono_y,
    29,
    false
);

// ============================================================================
// SIMBOLO FINAL
// ============================================================================

draw_set_halign(fa_center);

draw_set_valign(fa_middle);

draw_set_color(
    make_color_rgb(
        20,
        24,
        32
    )
);

var simbolo =
    "!";

if (global.final_juego == 1)
{
    simbolo =
        "+";
}

else if (global.final_juego == 2)
{
    simbolo =
        "~";
}

draw_text(
    icono_x,
    icono_y,
    simbolo
);

// ============================================================================
// ESTADO PEQUEÑO
// ============================================================================

var estado_w =
    180;

var estado_h =
    28;

var estado_x1 =
    centro_x
    -
    estado_w / 2;

var estado_x2 =
    centro_x
    +
    estado_w / 2;

var estado_y1 =
    panel_y1 + 108;

var estado_y2 =
    estado_y1
    +
    estado_h;

draw_set_color(
    make_color_rgb(
        34,
        40,
        54
    )
);

draw_roundrect(
    estado_x1,
    estado_y1,
    estado_x2,
    estado_y2,
    false
);

draw_set_color(
    color_final
);

draw_text(
    centro_x,
    (
        estado_y1
        +
        estado_y2
    )
    / 2,
    texto_estado
);

// ============================================================================
// TITULO
// ============================================================================

draw_set_halign(fa_center);

draw_set_valign(fa_top);

draw_set_color(c_white);

draw_text(
    centro_x,
    panel_y1 + 152,
    titulo_final
);

// ============================================================================
// SUBTITULO
// ============================================================================

draw_set_color(
    make_color_rgb(
        175,
        184,
        205
    )
);

draw_text_ext(
    centro_x,
    panel_y1 + 185,
    subtitulo_final,
    24,
    640
);

// ============================================================================
// SEPARADOR
// ============================================================================

draw_set_color(
    make_color_rgb(
        50,
        58,
        76
    )
);

draw_rectangle(
    panel_x1 + 60,
    panel_y1 + 232,
    panel_x2 - 60,
    panel_y1 + 234,
    false
);

// ============================================================================
// TITULO ESTADISTICAS
// ============================================================================

draw_set_halign(fa_left);

draw_set_valign(fa_top);

draw_set_color(
    make_color_rgb(
        125,
        175,
        240
    )
);

draw_text(
    panel_x1 + 60,
    panel_y1 + 253,
    "RESULTADO DE LA HISTORIA"
);

// ============================================================================
// TARJETAS DE ESTADISTICAS
// ============================================================================

var cards_y1 =
    panel_y1 + 290;

var cards_y2 =
    cards_y1 + 115;

var separacion =
    20;

var card_w =
    (
        panel_w
        -
        120
        -
        separacion * 2
    )
    /
    3;

// ============================================================================
// TARJETA BIENESTAR
// ============================================================================

var card1_x1 =
    panel_x1 + 60;

var card1_x2 =
    card1_x1 + card_w;

draw_set_color(
    make_color_rgb(
        31,
        37,
        51
    )
);

draw_roundrect(
    card1_x1,
    cards_y1,
    card1_x2,
    cards_y2,
    false
);

draw_set_color(
    make_color_rgb(
        95,
        180,
        230
    )
);

draw_set_halign(fa_left);

draw_text(
    card1_x1 + 18,
    cards_y1 + 16,
    "BIENESTAR"
);

draw_set_halign(fa_right);

draw_set_color(c_white);

draw_text(
    card1_x2 - 18,
    cards_y1 + 16,
    string(global.bienestar)
);

// ============================================================================
// BARRA BIENESTAR
// ============================================================================

var barra_y1 =
    cards_y1 + 62;

var barra_y2 =
    barra_y1 + 14;

draw_set_color(
    make_color_rgb(
        46,
        53,
        69
    )
);

draw_roundrect(
    card1_x1 + 18,
    barra_y1,
    card1_x2 - 18,
    barra_y2,
    false
);

var progreso_bienestar =
    clamp(
        global.bienestar / 100,
        0,
        1
    );

draw_set_color(
    make_color_rgb(
        95,
        180,
        230
    )
);

draw_roundrect(
    card1_x1 + 18,
    barra_y1,
    card1_x1
    + 18
    +
    (
        card_w - 36
    )
    *
    progreso_bienestar,
    barra_y2,
    false
);

// ============================================================================
// TARJETA APOYO
// ============================================================================

var card2_x1 =
    card1_x2
    +
    separacion;

var card2_x2 =
    card2_x1
    +
    card_w;

draw_set_color(
    make_color_rgb(
        31,
        37,
        51
    )
);

draw_roundrect(
    card2_x1,
    cards_y1,
    card2_x2,
    cards_y2,
    false
);

draw_set_color(
    make_color_rgb(
        105,
        205,
        145
    )
);

draw_set_halign(fa_left);

draw_text(
    card2_x1 + 18,
    cards_y1 + 16,
    "APOYO"
);

draw_set_halign(fa_right);

draw_set_color(c_white);

draw_text(
    card2_x2 - 18,
    cards_y1 + 16,
    string(global.apoyo)
);

// ============================================================================
// BARRA APOYO
// ============================================================================

draw_set_color(
    make_color_rgb(
        46,
        53,
        69
    )
);

draw_roundrect(
    card2_x1 + 18,
    barra_y1,
    card2_x2 - 18,
    barra_y2,
    false
);

var progreso_apoyo =
    clamp(
        global.apoyo / 100,
        0,
        1
    );

draw_set_color(
    make_color_rgb(
        105,
        205,
        145
    )
);

draw_roundrect(
    card2_x1 + 18,
    barra_y1,
    card2_x1
    + 18
    +
    (
        card_w - 36
    )
    *
    progreso_apoyo,
    barra_y2,
    false
);

// ============================================================================
// TARJETA ACOSO
// ============================================================================

var card3_x1 =
    card2_x2
    +
    separacion;

var card3_x2 =
    card3_x1
    +
    card_w;

draw_set_color(
    make_color_rgb(
        31,
        37,
        51
    )
);

draw_roundrect(
    card3_x1,
    cards_y1,
    card3_x2,
    cards_y2,
    false
);

draw_set_color(
    make_color_rgb(
        225,
        105,
        115
    )
);

draw_set_halign(fa_left);

draw_text(
    card3_x1 + 18,
    cards_y1 + 16,
    "ACOSO"
);

draw_set_halign(fa_right);

draw_set_color(c_white);

draw_text(
    card3_x2 - 18,
    cards_y1 + 16,
    string(global.acoso)
);

// ============================================================================
// BARRA ACOSO
// ============================================================================

draw_set_color(
    make_color_rgb(
        46,
        53,
        69
    )
);

draw_roundrect(
    card3_x1 + 18,
    barra_y1,
    card3_x2 - 18,
    barra_y2,
    false
);

var progreso_acoso =
    clamp(
        global.acoso / 100,
        0,
        1
    );

draw_set_color(
    make_color_rgb(
        225,
        105,
        115
    )
);

draw_roundrect(
    card3_x1 + 18,
    barra_y1,
    card3_x1
    + 18
    +
    (
        card_w - 36
    )
    *
    progreso_acoso,
    barra_y2,
    false
);

// ============================================================================
// RESUMEN DE DECISIONES
// ============================================================================

var resumen_y1 =
    cards_y2 + 28;

var resumen_y2 =
    resumen_y1 + 142;

draw_set_color(
    make_color_rgb(
        28,
        34,
        47
    )
);

draw_roundrect(
    panel_x1 + 60,
    resumen_y1,
    panel_x2 - 60,
    resumen_y2,
    false
);

// ============================================================================
// TITULO RESUMEN
// ============================================================================

draw_set_halign(fa_left);

draw_set_color(
    make_color_rgb(
        125,
        175,
        240
    )
);

draw_text(
    panel_x1 + 82,
    resumen_y1 + 18,
    "DECISIONES IMPORTANTES"
);

// ============================================================================
// COLUMNA IZQUIERDA
// ============================================================================

var col1_x =
    panel_x1 + 82;

var col2_x =
    centro_x + 30;

var texto_y =
    resumen_y1 + 52;

// ============================================================================
// DECISIONES POSITIVAS / NEGATIVAS
// ============================================================================

draw_set_color(
    global.guardo_pruebas
    ?
    make_color_rgb(
        105,
        205,
        145
    )
    :
    make_color_rgb(
        115,
        120,
        135
    )
);

draw_text(
    col1_x,
    texto_y,
    global.guardo_pruebas
    ?
    "+ Guardo pruebas"
    :
    "- No guardo pruebas"
);

draw_set_color(
    global.bloqueo_agresores
    ?
    make_color_rgb(
        105,
        205,
        145
    )
    :
    make_color_rgb(
        115,
        120,
        135
    )
);

draw_text(
    col1_x,
    texto_y + 28,
    global.bloqueo_agresores
    ?
    "+ Bloqueo a los agresores"
    :
    "- No bloqueo a los agresores"
);

draw_set_color(
    (
        global.conto_amigo
        ||
        global.hablo_profesor
        ||
        global.hablo_familia
    )
    ?
    make_color_rgb(
        105,
        205,
        145
    )
    :
    make_color_rgb(
        225,
        120,
        120
    )
);

draw_text(
    col1_x,
    texto_y + 56,
    (
        global.conto_amigo
        ||
        global.hablo_profesor
        ||
        global.hablo_familia
    )
    ?
    "+ Busco apoyo"
    :
    "- Evito pedir ayuda"
);

// ============================================================================
// COLUMNA DERECHA
// ============================================================================

draw_set_color(
    global.aprendio_seguridad
    ?
    make_color_rgb(
        105,
        205,
        145
    )
    :
    make_color_rgb(
        115,
        120,
        135
    )
);

draw_text(
    col2_x,
    texto_y,
    global.aprendio_seguridad
    ?
    "+ Aprendio sobre seguridad"
    :
    "- No busco ayuda profesional"
);

draw_set_color(
    global.sigue_solo
    ?
    make_color_rgb(
        225,
        120,
        120
    )
    :
    make_color_rgb(
        105,
        205,
        145
    )
);

draw_text(
    col2_x,
    texto_y + 28,
    global.sigue_solo
    ?
    "- Intento seguir solo"
    :
    "+ Acepto recibir ayuda"
);

draw_set_color(
    global.respondio
    ?
    make_color_rgb(
        225,
        120,
        120
    )
    :
    make_color_rgb(
        105,
        205,
        145
    )
);

draw_text(
    col2_x,
    texto_y + 56,
    global.respondio
    ?
    "- Respondio al acoso"
    :
    "+ Evito confrontar"
);

// ============================================================================
// MENSAJE EDUCATIVO
// ============================================================================

var mensaje_y1 =
    resumen_y2 + 22;

var mensaje_y2 =
    mensaje_y1 + 82;

draw_set_color(
    make_color_rgb(
        34,
        40,
        54
    )
);

draw_roundrect(
    panel_x1 + 60,
    mensaje_y1,
    panel_x2 - 60,
    mensaje_y2,
    false
);

// ============================================================================
// ACENTO
// ============================================================================

draw_set_color(
    color_final
);

draw_rectangle(
    panel_x1 + 60,
    mensaje_y1,
    panel_x1 + 66,
    mensaje_y2,
    false
);

// ============================================================================
// TEXTO MENSAJE
// ============================================================================

draw_set_halign(fa_left);

draw_set_valign(fa_top);

draw_set_color(c_white);

draw_text_ext(
    panel_x1 + 88,
    mensaje_y1 + 18,
    mensaje_final,
    22,
    panel_w - 220
);

// ============================================================================
// BOTON REINICIAR
// ============================================================================

var boton_w =
    330;

var boton_h =
    46;

var boton_x1 =
    centro_x
    -
    boton_w / 2;

var boton_x2 =
    centro_x
    +
    boton_w / 2;

var boton_y1 =
    panel_y2 - 62;

var boton_y2 =
    boton_y1
    +
    boton_h;

// ============================================================================
// PULSO BOTON
// ============================================================================

draw_set_alpha(
    (
        0.82
        +
        pulso * 0.18
    )
    *
    alpha_panel
);

draw_set_color(
    color_final
);

draw_roundrect(
    boton_x1,
    boton_y1,
    boton_x2,
    boton_y2,
    false
);

// ============================================================================
// TEXTO BOTON
// ============================================================================

draw_set_alpha(alpha_panel);

draw_set_halign(fa_center);

draw_set_valign(fa_middle);

draw_set_color(
    make_color_rgb(
        18,
        22,
        30
    )
);

draw_text(
    centro_x,
    (
        boton_y1
        +
        boton_y2
    )
    / 2,
    "R  ·  VOLVER A JUGAR"
);

// ============================================================================
// PIE
// ============================================================================

draw_set_halign(fa_center);

draw_set_valign(fa_bottom);

draw_set_color(
    make_color_rgb(
        115,
        123,
        145
    )
);

draw_text(
    centro_x,
    gui_h - 12,
    "THE SOCIAL MEDIA GAME"
);

// ============================================================================
// RESTAURAR DRAW
// ============================================================================

draw_set_alpha(1);

draw_set_color(c_white);

draw_set_halign(fa_left);

draw_set_valign(fa_top);
