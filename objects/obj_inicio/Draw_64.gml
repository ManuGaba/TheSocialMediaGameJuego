// ============================================================================
// OBJ_INICIO
// EVENTO DRAW GUI COMPLETO
// ============================================================================

var gui_w_inicio = display_get_gui_width();
var gui_h_inicio = display_get_gui_height();

// ============================================================================
// ROOM 14 - CREDITOS DE PORTADA
// ============================================================================

// La portada ya contiene titulo y autores. Este pequeño credito completa
// los datos de entrega sin tapar la ilustracion principal.
if (room == Room14)
{
    var credit_x1 = 24;
    var credit_y1 = 20;
    var credit_x2 = min(gui_w_inicio - 24, 650);
    var credit_y2 = 62;

    draw_set_alpha(0.82);
    draw_set_color(make_color_rgb(15, 24, 36));
    draw_roundrect(credit_x1, credit_y1, credit_x2, credit_y2, false);

    draw_set_alpha(0.95);
    draw_set_color(make_color_rgb(70, 145, 225));
    draw_roundrect(credit_x1, credit_y1, credit_x2, credit_y2, true);

    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text(
        credit_x1 + 18,
        (credit_y1 + credit_y2) / 2,
        "Lengua-Videojuegos  ·  Docentes: Ana Silva / Enzo Falcon"
    );
}

// ============================================================================
// ROOM 15 - ACLARACION DE CONTROLES ACTUALES
// ============================================================================

// La imagen de controles original mencionaba flechas para tomar decisiones.
// En la version final las decisiones se eligen dentro del celular con CLICK.
if (room == Room15)
{
    var control_panel_w = min(620, gui_w_inicio * 0.38);
    var control_panel_h = 118;
    var control_x2 = gui_w_inicio - 28;
    var control_x1 = control_x2 - control_panel_w;
    var control_y2 = gui_h_inicio - 28;
    var control_y1 = control_y2 - control_panel_h;

    draw_set_alpha(0.90);
    draw_set_color(make_color_rgb(15, 24, 36));
    draw_roundrect(control_x1, control_y1, control_x2, control_y2, false);

    draw_set_alpha(0.96);
    draw_set_color(make_color_rgb(70, 145, 225));
    draw_roundrect(control_x1, control_y1, control_x2, control_y2, true);

    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    draw_set_color(make_color_rgb(115, 180, 245));
    draw_text(control_x1 + 20, control_y1 + 16, "DECISIONES");

    draw_set_color(c_white);
    draw_text_ext(
        control_x1 + 20,
        control_y1 + 45,
        "Abri el celular con E, entra a DECISIONES y elegi con CLICK. ESPACIO se usa para continuar los dialogos.",
        22,
        control_panel_w - 40
    );
}

// ============================================================================
// RESTAURAR ESTADO DE DIBUJO
// ============================================================================

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);
