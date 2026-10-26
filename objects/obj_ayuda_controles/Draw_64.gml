// ============================================================================
// OBJ_AYUDA_CONTROLES
// EVENTO DRAW GUI COMPLETO - VERSION COMPACTA
// ============================================================================

if (alpha_ayuda <= 0)
{
    exit;
}

var gui_h = display_get_gui_height();

var panel_w = 360;
var panel_h = 218;
var panel_x1 = 24;
var panel_x2 = panel_x1 + panel_w;
var panel_y2 = gui_h - 24 + desplazamiento_y;
var panel_y1 = panel_y2 - panel_h;

// Sombra
draw_set_alpha(0.30 * alpha_ayuda);
draw_set_color(c_black);
draw_roundrect(panel_x1 + 6, panel_y1 + 7, panel_x2 + 6, panel_y2 + 7, false);

// Fondo
draw_set_alpha(0.95 * alpha_ayuda);
draw_set_color(make_color_rgb(22, 27, 38));
draw_roundrect(panel_x1, panel_y1, panel_x2, panel_y2, false);

// Borde y acento
draw_set_alpha(0.90 * alpha_ayuda);
draw_set_color(make_color_rgb(75, 120, 195));
draw_roundrect(panel_x1 - 1, panel_y1 - 1, panel_x2 + 1, panel_y2 + 1, true);
draw_set_color(make_color_rgb(90, 140, 220));
draw_roundrect(panel_x1, panel_y1, panel_x2, panel_y1 + 6, false);

// Titulo
draw_set_alpha(alpha_ayuda);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text(panel_x1 + 18, panel_y1 + 18, "CONTROLES");

draw_set_color(make_color_rgb(145, 155, 175));
draw_text(panel_x1 + 18, panel_y1 + 43, "Atajos principales");

draw_set_color(make_color_rgb(45, 55, 75));
draw_rectangle(panel_x1 + 18, panel_y1 + 67, panel_x2 - 18, panel_y1 + 69, false);

var tecla_x = panel_x1 + 20;
var texto_x = panel_x1 + 118;

// ESPACIO
draw_set_color(make_color_rgb(235, 238, 245));
draw_roundrect(tecla_x, panel_y1 + 82, tecla_x + 82, panel_y1 + 112, false);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(make_color_rgb(28, 32, 42));
draw_text(tecla_x + 41, panel_y1 + 97, "ESPACIO");
draw_set_halign(fa_left);
draw_set_color(c_white);
draw_text(texto_x, panel_y1 + 97, "Continuar dialogos");

// E
draw_set_color(make_color_rgb(235, 238, 245));
draw_roundrect(tecla_x, panel_y1 + 122, tecla_x + 42, panel_y1 + 152, false);
draw_set_halign(fa_center);
draw_set_color(make_color_rgb(28, 32, 42));
draw_text(tecla_x + 21, panel_y1 + 137, "E");
draw_set_halign(fa_left);
draw_set_color(c_white);
draw_text(texto_x, panel_y1 + 137, "Abrir o cerrar celular");

// CLICK
draw_set_color(make_color_rgb(235, 238, 245));
draw_roundrect(tecla_x, panel_y1 + 162, tecla_x + 82, panel_y1 + 192, false);
draw_set_halign(fa_center);
draw_set_color(make_color_rgb(28, 32, 42));
draw_text(tecla_x + 41, panel_y1 + 177, "CLICK");
draw_set_halign(fa_left);
draw_set_color(c_white);
draw_text(texto_x, panel_y1 + 177, "Apps y decisiones");

// F1
draw_set_halign(fa_right);
draw_set_valign(fa_middle);
draw_set_color(make_color_rgb(120, 175, 245));
draw_text(panel_x2 - 16, panel_y2 - 12, "F1  ·  Ocultar ayuda");

// Restaurar
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
