// ============================================================
// OBJ_DEBUG
// EVENTO DRAW GUI COMPLETO
// ============================================================

if (!mostrar_debug)
{
    exit;
}

// ============================================================
// FONDO
// ============================================================

draw_set_alpha(0.80);

draw_set_color(c_black);

draw_rectangle(
    debug_x,
    debug_y,
    debug_x + debug_ancho,
    debug_y + debug_alto,
    false
);

draw_set_alpha(1);

// ============================================================
// BORDE
// ============================================================

draw_set_color(c_yellow);

draw_rectangle(
    debug_x,
    debug_y,
    debug_x + debug_ancho,
    debug_y + debug_alto,
    true
);

// ============================================================
// TEXTO
// ============================================================

draw_set_color(c_white);

draw_set_halign(fa_left);

draw_set_valign(fa_top);

var texto_x =
    debug_x + 12;

var texto_y =
    debug_y + 10;

var separacion =
    22;

// ============================================================
// TITULO
// ============================================================

draw_set_color(c_yellow);

draw_text(
    texto_x,
    texto_y,
    "MODO DEBUG"
);

texto_y +=
    separacion * 1.5;

draw_set_color(c_white);

// ============================================================
// ROOM
// ============================================================

draw_text(
    texto_x,
    texto_y,
    "Room: "
    + room_get_name(room)
);

texto_y +=
    separacion;

// ============================================================
// CONTROLADOR
// ============================================================

if (instance_exists(Obj_controlador_dialogo))
{
    draw_text(
        texto_x,
        texto_y,
        "Estado: "
        + string(
            Obj_controlador_dialogo.estado
        )
    );

    texto_y +=
        separacion;

    draw_text(
        texto_x,
        texto_y,
        "Dialogo activo: "
        + string(
            Obj_controlador_dialogo.dialogo_activo
        )
    );
}

else
{
    draw_set_color(c_red);

    draw_text(
        texto_x,
        texto_y,
        "CONTROLADOR NO EXISTE"
    );

    draw_set_color(c_white);

    texto_y +=
        separacion;
}

texto_y +=
    separacion;

// ============================================================
// HISTORIA
// ============================================================

if (variable_global_exists("etapa_historia"))
{
    draw_text(
        texto_x,
        texto_y,
        "Etapa: "
        + string(global.etapa_historia)
    );
}

texto_y +=
    separacion;

// ============================================================
// DECISION ACTUAL
// ============================================================

if (variable_global_exists("decision_actual"))
{
    draw_text(
        texto_x,
        texto_y,
        "Decision actual: "
        + string(global.decision_actual)
    );
}

texto_y +=
    separacion;

// ============================================================
// DECISION PENDIENTE
// ============================================================

if (variable_global_exists("decision_pendiente"))
{
    draw_text(
        texto_x,
        texto_y,
        "Decision pendiente: "
        + string(global.decision_pendiente)
    );
}

texto_y +=
    separacion * 1.4;

// ============================================================
// BIENESTAR
// ============================================================

if (variable_global_exists("bienestar"))
{
    draw_text(
        texto_x,
        texto_y,
        "Bienestar: "
        + string(global.bienestar)
    );
}

texto_y +=
    separacion;

// ============================================================
// APOYO
// ============================================================

if (variable_global_exists("apoyo"))
{
    draw_text(
        texto_x,
        texto_y,
        "Apoyo: "
        + string(global.apoyo)
    );
}

texto_y +=
    separacion;

// ============================================================
// ACOSO
// ============================================================

if (variable_global_exists("acoso"))
{
    draw_text(
        texto_x,
        texto_y,
        "Acoso: "
        + string(global.acoso)
    );
}

// ============================================================
// RESTAURAR DRAW
// ============================================================

draw_set_alpha(1);

draw_set_color(c_white);

draw_set_halign(fa_left);

draw_set_valign(fa_top);
