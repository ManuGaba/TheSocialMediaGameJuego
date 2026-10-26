// ============================================================================
// OBJ_AUTOESTIMA
// EVENTO DRAW GUI COMPLETO - HUD COMPACTO
// ============================================================================

if (room == Room1 || room == Room7)
{
    exit;
}

if (!variable_global_exists("bienestar"))
{
    exit;
}

var bienestar_actual = clamp(global.bienestar, 0, 100);
var sprite_bienestar = spr_bienestar_1;

if (bienestar_actual >= 85)      sprite_bienestar = spr_bienestar_1;
else if (bienestar_actual >= 70) sprite_bienestar = spr_bienestar_2;
else if (bienestar_actual >= 55) sprite_bienestar = spr_bienestar_3;
else if (bienestar_actual >= 40) sprite_bienestar = spr_bienestar_4;
else if (bienestar_actual >= 25) sprite_bienestar = spr_bienestar_5;
else if (bienestar_actual >= 10) sprite_bienestar = spr_bienestar_6;
else                              sprite_bienestar = spr_bienestar_7;

var texto_estado = "Roger se siente bien";
var color_estado = make_color_rgb(95, 190, 225);

if (bienestar_actual < 70)
{
    texto_estado = "Roger esta preocupado";
    color_estado = make_color_rgb(235, 185, 75);
}

if (bienestar_actual < 40)
{
    texto_estado = "Roger necesita apoyo";
    color_estado = make_color_rgb(220, 105, 110);
}

// Panel compacto: el sprite original es muy grande (2172x724), por eso se
// dibuja estirado dentro de un area controlada y nunca vuelve a desbordarse.
var panel_x1 = 18;
var panel_y1 = 18;
var panel_w  = 380;
var panel_h  = 152;
var panel_x2 = panel_x1 + panel_w;
var panel_y2 = panel_y1 + panel_h;

// Sombra
draw_set_alpha(0.28);
draw_set_color(c_black);
draw_roundrect(panel_x1 + 5, panel_y1 + 6, panel_x2 + 5, panel_y2 + 6, false);

// Fondo
draw_set_alpha(0.95);
draw_set_color(make_color_rgb(22, 27, 38));
draw_roundrect(panel_x1, panel_y1, panel_x2, panel_y2, false);

// Borde y acento
draw_set_alpha(0.90);
draw_set_color(make_color_rgb(75, 120, 195));
draw_roundrect(panel_x1 - 1, panel_y1 - 1, panel_x2 + 1, panel_y2 + 1, true);
draw_set_color(make_color_rgb(90, 140, 220));
draw_roundrect(panel_x1, panel_y1, panel_x2, panel_y1 + 6, false);

// Cabecera
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_color(make_color_rgb(130, 180, 245));
draw_text(panel_x1 + 16, panel_y1 + 25, "BIENESTAR");

draw_set_color(make_color_rgb(195, 202, 218));
draw_text(panel_x1 + 112, panel_y1 + 25, texto_estado);

draw_set_color(color_estado);
draw_circle(panel_x2 - 20, panel_y1 + 25, 6, false);

// Area del medidor
var med_x = panel_x1 + 16;
var med_y = panel_y1 + 47;
var med_w = panel_w - 32;
var med_h = 92;

draw_set_color(make_color_rgb(31, 36, 49));
draw_roundrect(med_x - 5, med_y - 5, med_x + med_w + 5, med_y + med_h + 5, false);

draw_sprite_stretched(
    sprite_bienestar,
    0,
    med_x,
    med_y,
    med_w,
    med_h
);

// Restaurar estado de dibujo
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
