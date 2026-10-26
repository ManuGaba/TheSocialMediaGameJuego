// ============================================================
// OBJ_CONTROLADOR_DIALOGO
// EVENTO STEP COMPLETO
// ============================================================

// ============================================================
// TAMANO DE LA INTERFAZ (GUI)
// Altura de referencia fija (890) y ancho proporcional a la sala actual.
// Asi dialogos, celular y paneles se ven completos aunque la sala sea mas baja.
// ============================================================

var gui_alto_referencia = 890;

display_set_gui_size(room_width * gui_alto_referencia / room_height, gui_alto_referencia);

// ============================================================
// CONTROL CENTRAL DE TEXTO PROGRESIVO
// ============================================================

var espacio_dialogo_presionado = keyboard_check_pressed(vk_space);
var bloquear_avance_dialogo = false;

texto_actual_dialogo = "";

if (dialogo_activo)
{
    if (estado == "dialogo_roger" && linea_dialogo < cantidad_roger)
        texto_actual_dialogo = texto_roger[linea_dialogo];
    else if (estado == "dialogo_amigos" && linea_dialogo < cantidad_amigos)
        texto_actual_dialogo = texto_amigos[linea_dialogo];
    else if (estado == "dialogo_profesor" && linea_dialogo < cantidad_profesor)
        texto_actual_dialogo = texto_profesor[linea_dialogo];
    else if (estado == "dialogo_decision1_entrar" && linea_dialogo < cantidad_decision1_entrar)
        texto_actual_dialogo = texto_decision1_entrar[linea_dialogo];
    else if (estado == "dialogo_decision1_celular" && linea_dialogo < cantidad_decision1_celular)
        texto_actual_dialogo = texto_decision1_celular[linea_dialogo];
    else if (estado == "dialogo_decision1_no_entrar" && linea_dialogo < cantidad_decision1_no_entrar)
        texto_actual_dialogo = texto_decision1_no_entrar[linea_dialogo];
    else if (estado == "incidente_entrar" && linea_dialogo < cantidad_incidente_entrar)
        texto_actual_dialogo = texto_incidente_entrar[linea_dialogo];
    else if (estado == "incidente_celular" && linea_dialogo < cantidad_incidente_celular)
        texto_actual_dialogo = texto_incidente_celular[linea_dialogo];
    else if (estado == "incidente_no_entrar" && linea_dialogo < cantidad_incidente_no_entrar)
        texto_actual_dialogo = texto_incidente_no_entrar[linea_dialogo];
    else if (estado == "dialogo_decision2_responder" && linea_dialogo < cantidad_decision2_responder)
        texto_actual_dialogo = texto_decision2_responder[linea_dialogo];
    else if (estado == "dialogo_decision2_guardar" && linea_dialogo < cantidad_decision2_guardar)
        texto_actual_dialogo = texto_decision2_guardar[linea_dialogo];
    else if (estado == "dialogo_decision2_ignorar" && linea_dialogo < cantidad_decision2_ignorar)
        texto_actual_dialogo = texto_decision2_ignorar[linea_dialogo];
    else if (estado == "segundo_incidente_responder" && linea_dialogo < cantidad_segundo_incidente_responder)
        texto_actual_dialogo = texto_segundo_incidente_responder[linea_dialogo];
    else if (estado == "segundo_incidente_guardar" && linea_dialogo < cantidad_segundo_incidente_guardar)
        texto_actual_dialogo = texto_segundo_incidente_guardar[linea_dialogo];
    else if (estado == "segundo_incidente_ignorar" && linea_dialogo < cantidad_segundo_incidente_ignorar)
        texto_actual_dialogo = texto_segundo_incidente_ignorar[linea_dialogo];
    else if (estado == "dialogo_decision3_amigo" && linea_dialogo < cantidad_decision3_amigo)
        texto_actual_dialogo = texto_decision3_amigo[linea_dialogo];
    else if (estado == "dialogo_decision3_profesor" && linea_dialogo < cantidad_decision3_profesor)
        texto_actual_dialogo = texto_decision3_profesor[linea_dialogo];
    else if (estado == "dialogo_decision3_ocultar" && linea_dialogo < cantidad_decision3_ocultar)
        texto_actual_dialogo = texto_decision3_ocultar[linea_dialogo];
    else if (estado == "dialogo_decision4_familia" && linea_dialogo < cantidad_decision4_familia)
        texto_actual_dialogo = texto_decision4_familia[linea_dialogo];
    else if (estado == "dialogo_decision4_psicologa" && linea_dialogo < cantidad_decision4_psicologa)
        texto_actual_dialogo = texto_decision4_psicologa[linea_dialogo];
    else if (estado == "dialogo_decision4_solo" && linea_dialogo < cantidad_decision4_solo)
        texto_actual_dialogo = texto_decision4_solo[linea_dialogo];
}

// Al cambiar de linea o de estado, el texto vuelve a comenzar desde cero.
if (
    estado != estado_tecleo_anterior ||
    linea_dialogo != linea_tecleo_anterior
)
{
    // El nombre del hablante se muestra de inmediato en la insignia.
    // El efecto de tecleo empieza directamente sobre el mensaje visible.
    var posicion_prefijo_tecleo = string_pos(": ", texto_actual_dialogo);

    if (posicion_prefijo_tecleo > 0)
    {
        caracteres_visibles = posicion_prefijo_tecleo + 1;
    }
    else
    {
        caracteres_visibles = 0;
    }

    contador_tecleo = 0;
    estado_tecleo_anterior = estado;
    linea_tecleo_anterior = linea_dialogo;
}

var longitud_texto_actual = string_length(texto_actual_dialogo);

if (dialogo_activo && longitud_texto_actual > 0)
{
    if (caracteres_visibles < longitud_texto_actual)
    {
        contador_tecleo += 1;

        if (contador_tecleo >= intervalo_tecleo)
        {
            contador_tecleo = 0;
            caracteres_visibles = min(longitud_texto_actual, caracteres_visibles + 1);

            var caracter_nuevo = string_char_at(texto_actual_dialogo, caracteres_visibles);

            if (
                caracter_nuevo != " " &&
                caracter_nuevo != "." &&
                caracter_nuevo != "," &&
                caracter_nuevo != ":" &&
                asset_get_index("snd_tecleo") != -1
            )
            {
                if (!audio_is_playing(snd_tecleo))
                {
                    audio_play_sound(snd_tecleo, 5, false);
                }
            }
        }
    }

    // Si se presiona ESPACIO mientras escribe, primero completa la linea.
    if (
        espacio_dialogo_presionado &&
        caracteres_visibles < longitud_texto_actual
    )
    {
        caracteres_visibles = longitud_texto_actual;
        bloquear_avance_dialogo = true;
    }

    texto_dialogo_completo = (caracteres_visibles >= longitud_texto_actual);
}
else
{
    texto_dialogo_completo = true;
}

// ============================================================
// ROOM 1
// INICIO
// ============================================================

if (room == Room1 && estado == "inicio")
{
    roger = instance_create_layer(
        300,
        350,
        "Instances",
        obj_protagonista
    );

    estado = "dialogo_roger";

    dialogo_activo = true;

    linea_dialogo = 0;

    global.iniciar_dialogo = true;
}

// ============================================================
// ROOM 1
// DIALOGO ROGER
// ============================================================

if (room == Room1 && estado == "dialogo_roger")
{
    if (espacio_dialogo_presionado && !bloquear_avance_dialogo)
    {
        linea_dialogo += 1;

        if (linea_dialogo >= cantidad_roger)
        {
            dialogo_activo = false;

            global.iniciar_dialogo = false;

            estado = "cargando";

            tiempo_carga = 0;
        }
    }
}

// ============================================================
// CARGA
// ============================================================

if (estado == "cargando")
{
    tiempo_carga += 1;

    if (
        tiempo_carga >=
        game_get_speed(gamespeed_fps) * 3
    )
    {
        estado = "escuela";

        room_goto(Room2);
    }
}

// ============================================================
// CELULAR EN ROOM 2
// ============================================================

if (room == Room2)
{
    if (!instance_exists(obj_celu))
    {
        celu = instance_create_layer(
            0,
            0,
            "Instances",
            obj_celu
        );
    }
}

// ============================================================
// ROOM 2
// ESCUELA
// ============================================================

if (room == Room2 && estado == "escuela")
{
    roger = instance_create_layer(
        -100,
        350,
        "Instances",
        obj_protagonista
    );

    amigo = instance_create_layer(
        room_width + 100,
        350,
        "Instances",
        obj_amigo
    );

    amiga = instance_create_layer(
        room_width + 200,
        350,
        "Instances",
        obj_amiga
    );

    objetivo_roger =
        room_width * 0.25;

    objetivo_amigo =
        room_width * 0.50;

    objetivo_amiga =
        room_width * 0.75;

    roger.image_xscale = escala_normal;
    roger.image_yscale = escala_normal;

    amigo.image_xscale = escala_normal;
    amigo.image_yscale = escala_normal;

    amiga.image_xscale = escala_normal;
    amiga.image_yscale = escala_normal;

    estado =
        "entrada_amigos";
}

// ============================================================
// ENTRADA AMIGOS
// ============================================================

if (room == Room2 && estado == "entrada_amigos")
{
    if (instance_exists(roger))
    {
        roger.x =
            lerp(
                roger.x,
                objetivo_roger,
                0.08
            );
    }

    if (instance_exists(amigo))
    {
        amigo.x =
            lerp(
                amigo.x,
                objetivo_amigo,
                0.08
            );
    }

    if (instance_exists(amiga))
    {
        amiga.x =
            lerp(
                amiga.x,
                objetivo_amiga,
                0.08
            );
    }

    if (
        instance_exists(roger) &&
        instance_exists(amigo) &&
        instance_exists(amiga)
    )
    {
        if (
            abs(roger.x - objetivo_roger) < 2 &&
            abs(amigo.x - objetivo_amigo) < 2 &&
            abs(amiga.x - objetivo_amiga) < 2
        )
        {
            roger.x = objetivo_roger;

            amigo.x = objetivo_amigo;

            amiga.x = objetivo_amiga;

            linea_dialogo = 0;

            dialogo_activo = true;

            global.iniciar_dialogo = true;

            global.apoyo_amigo = true;

            global.apoyo_amiga = true;

            estado =
                "dialogo_amigos";
        }
    }
}

// ============================================================
// ANIMACION AMIGOS
// ============================================================

if (room == Room2 && estado == "dialogo_amigos")
{
    if (
        instance_exists(roger) &&
        instance_exists(amigo) &&
        instance_exists(amiga)
    )
    {
        roger.image_xscale =
            lerp(
                roger.image_xscale,
                escala_normal,
                0.08
            );

        roger.image_yscale =
            lerp(
                roger.image_yscale,
                escala_normal,
                0.08
            );

        amigo.image_xscale =
            lerp(
                amigo.image_xscale,
                escala_normal,
                0.08
            );

        amigo.image_yscale =
            lerp(
                amigo.image_yscale,
                escala_normal,
                0.08
            );

        amiga.image_xscale =
            lerp(
                amiga.image_xscale,
                escala_normal,
                0.08
            );

        amiga.image_yscale =
            lerp(
                amiga.image_yscale,
                escala_normal,
                0.08
            );

        if (
            linea_dialogo == 0 ||
            linea_dialogo == 3 ||
            linea_dialogo == 6
        )
        {
            amigo.image_xscale =
                lerp(
                    amigo.image_xscale,
                    escala_hablando,
                    0.15
                );

            amigo.image_yscale =
                lerp(
                    amigo.image_yscale,
                    escala_hablando,
                    0.15
                );
        }

        if (
            linea_dialogo == 1 ||
            linea_dialogo == 4 ||
            linea_dialogo == 7
        )
        {
            roger.image_xscale =
                lerp(
                    roger.image_xscale,
                    escala_hablando,
                    0.15
                );

            roger.image_yscale =
                lerp(
                    roger.image_yscale,
                    escala_hablando,
                    0.15
                );
        }

        if (
            linea_dialogo == 2 ||
            linea_dialogo == 5 ||
            linea_dialogo == 8
        )
        {
            amiga.image_xscale =
                lerp(
                    amiga.image_xscale,
                    escala_hablando,
                    0.15
                );

            amiga.image_yscale =
                lerp(
                    amiga.image_yscale,
                    escala_hablando,
                    0.15
                );
        }
    }
}

// ============================================================
// FIN DIALOGO AMIGOS
// ============================================================

if (room == Room2 && estado == "dialogo_amigos")
{
    if (espacio_dialogo_presionado && !bloquear_avance_dialogo)
    {
        linea_dialogo += 1;

        if (linea_dialogo >= cantidad_amigos)
        {
            dialogo_activo = false;

            global.iniciar_dialogo = false;

            estado = "clase";
        }
    }
}

// ============================================================
// IR A ROOM 3
// ============================================================

if (room == Room2 && estado == "clase")
{
    room_goto(Room3);
}

// ============================================================
// ROOM 3
// CLASE
// ============================================================

if (room == Room3 && estado == "clase")
{
    roger = instance_create_layer(
        -100,
        350,
        "Instances",
        obj_protagonista
    );

    profesor = instance_create_layer(
        room_width + 100,
        350,
        "Instances",
        obj_profesor
    );

    companiero1 = instance_create_layer(
        150,
        350,
        "Instances",
        obj_companiero1
    );

    companiero2 = instance_create_layer(
        room_width - 150,
        350,
        "Instances",
        obj_companiero2
    );

    objetivo_roger =
        room_width * 0.30;

    objetivo_profesor =
        room_width * 0.65;

    roger.image_xscale = escala_normal;
    roger.image_yscale = escala_normal;

    profesor.image_xscale = escala_normal;
    profesor.image_yscale = escala_normal;

    estado =
        "entrada_profesor";
}

// ============================================================
// ENTRADA PROFESOR
// ============================================================

if (room == Room3 && estado == "entrada_profesor")
{
    if (instance_exists(roger))
    {
        roger.x =
            lerp(
                roger.x,
                objetivo_roger,
                0.08
            );
    }

    if (instance_exists(profesor))
    {
        profesor.x =
            lerp(
                profesor.x,
                objetivo_profesor,
                0.08
            );
    }

    if (
        instance_exists(roger) &&
        instance_exists(profesor)
    )
    {
        if (
            abs(roger.x - objetivo_roger) < 2 &&
            abs(profesor.x - objetivo_profesor) < 2
        )
        {
            roger.x = objetivo_roger;

            profesor.x = objetivo_profesor;

            linea_dialogo = 0;

            dialogo_activo = true;

            global.iniciar_dialogo = true;

            estado =
                "dialogo_profesor";
        }
    }
}

// ============================================================
// ANIMACION PROFESOR
// ============================================================

if (room == Room3 && estado == "dialogo_profesor")
{
    if (
        instance_exists(roger) &&
        instance_exists(profesor)
    )
    {
        roger.image_xscale =
            lerp(
                roger.image_xscale,
                escala_normal,
                0.08
            );

        roger.image_yscale =
            lerp(
                roger.image_yscale,
                escala_normal,
                0.08
            );

        profesor.image_xscale =
            lerp(
                profesor.image_xscale,
                escala_normal,
                0.08
            );

        profesor.image_yscale =
            lerp(
                profesor.image_yscale,
                escala_normal,
                0.08
            );

        if (
            linea_dialogo == 0 ||
            linea_dialogo == 2 ||
            linea_dialogo == 4 ||
            linea_dialogo == 6
        )
        {
            profesor.image_xscale =
                lerp(
                    profesor.image_xscale,
                    escala_hablando,
                    0.15
                );

            profesor.image_yscale =
                lerp(
                    profesor.image_yscale,
                    escala_hablando,
                    0.15
                );
        }

        if (
            linea_dialogo == 1 ||
            linea_dialogo == 3 ||
            linea_dialogo == 5 ||
            linea_dialogo == 7
        )
        {
            roger.image_xscale =
                lerp(
                    roger.image_xscale,
                    escala_hablando,
                    0.15
                );

            roger.image_yscale =
                lerp(
                    roger.image_yscale,
                    escala_hablando,
                    0.15
                );
        }
    }
}

// ============================================================
// FIN PROFESOR INICIAL
// ============================================================

if (room == Room3 && estado == "dialogo_profesor")
{
    if (espacio_dialogo_presionado && !bloquear_avance_dialogo)
    {
        linea_dialogo += 1;

        if (linea_dialogo >= cantidad_profesor)
        {
            dialogo_activo = false;

            global.iniciar_dialogo = false;

            global.decision_pendiente = true;

            global.decision_actual = 1;

            global.decision1 = 0;

            global.etapa_historia = 2;

            estado =
                "volver_room2_decision1";

            room_goto(Room2);
        }
    }
}

// ============================================================
// VOLVER ROOM 2
// ============================================================

if (
    room == Room2 &&
    estado == "volver_room2_decision1"
)
{
    roger = instance_create_layer(
        room_width * 0.25,
        350,
        "Instances",
        obj_protagonista
    );

    amigo = instance_create_layer(
        room_width * 0.50,
        350,
        "Instances",
        obj_amigo
    );

    amiga = instance_create_layer(
        room_width * 0.75,
        350,
        "Instances",
        obj_amiga
    );

    roger.image_xscale = escala_normal;
    roger.image_yscale = escala_normal;

    amigo.image_xscale = escala_normal;
    amigo.image_yscale = escala_normal;

    amiga.image_xscale = escala_normal;
    amiga.image_yscale = escala_normal;

    estado =
        "esperando_decision1";
}

// ============================================================
// DECISION 1
// ============================================================

if (
    room == Room2 &&
    estado == "esperando_decision1"
)
{
    if (global.decision1 == 1)
    {
        global.decision_pendiente = false;

        global.decision_actual = 0;

        global.bienestar += 5;

        global.apoyo += 5;

        global.bienestar =
            clamp(global.bienestar, 0, 100);

        global.apoyo =
            clamp(global.apoyo, 0, 100);

        global.etapa_historia = 3;

        estado =
            "decision1_entrar_clases";
    }

    else if (global.decision1 == 2)
    {
        global.decision_pendiente = false;

        global.decision_actual = 0;

        global.bienestar -= 5;

        global.bienestar =
            clamp(global.bienestar, 0, 100);

        global.etapa_historia = 3;

        estado =
            "decision1_usar_celular";
    }

    else if (global.decision1 == 3)
    {
        global.decision_pendiente = false;

        global.decision_actual = 0;

        global.bienestar -= 10;

        global.profesor_preocupado = true;

        global.bienestar =
            clamp(global.bienestar, 0, 100);

        global.etapa_historia = 3;

        estado =
            "decision1_no_entrar";
    }
}

// ============================================================
// DECISION 1
// ENTRAR
// ============================================================

if (
    room == Room2 &&
    estado == "decision1_entrar_clases"
)
{
    linea_dialogo = 0;

    dialogo_activo = true;

    global.iniciar_dialogo = true;

    estado =
        "dialogo_decision1_entrar";
}

if (
    room == Room2 &&
    estado == "dialogo_decision1_entrar"
)
{
    if (espacio_dialogo_presionado && !bloquear_avance_dialogo)
    {
        linea_dialogo += 1;

        if (
            linea_dialogo >=
            cantidad_decision1_entrar
        )
        {
            dialogo_activo = false;

            global.iniciar_dialogo = false;

            estado =
                "preparar_incidente";
        }
    }
}

// ============================================================
// DECISION 1
// CELULAR
// ============================================================

if (
    room == Room2 &&
    estado == "decision1_usar_celular"
)
{
    linea_dialogo = 0;

    dialogo_activo = true;

    global.iniciar_dialogo = true;

    estado =
        "dialogo_decision1_celular";
}

if (
    room == Room2 &&
    estado == "dialogo_decision1_celular"
)
{
    if (espacio_dialogo_presionado && !bloquear_avance_dialogo)
    {
        linea_dialogo += 1;

        if (
            linea_dialogo >=
            cantidad_decision1_celular
        )
        {
            dialogo_activo = false;

            global.iniciar_dialogo = false;

            estado =
                "preparar_incidente";
        }
    }
}

// ============================================================
// DECISION 1
// NO ENTRAR
// ============================================================

if (
    room == Room2 &&
    estado == "decision1_no_entrar"
)
{
    linea_dialogo = 0;

    dialogo_activo = true;

    global.iniciar_dialogo = true;

    estado =
        "dialogo_decision1_no_entrar";
}

if (
    room == Room2 &&
    estado == "dialogo_decision1_no_entrar"
)
{
    if (espacio_dialogo_presionado && !bloquear_avance_dialogo)
    {
        linea_dialogo += 1;

        if (
            linea_dialogo >=
            cantidad_decision1_no_entrar
        )
        {
            dialogo_activo = false;

            global.iniciar_dialogo = false;

            estado =
                "preparar_incidente";
        }
    }
}

// ============================================================
// PRIMER INCIDENTE
// ============================================================

if (
    room == Room2 &&
    estado == "preparar_incidente"
)
{
    global.publicacion_aparecio = true;

    global.bienestar -= 15;

    global.acoso += 15;

    global.bienestar =
        clamp(global.bienestar, 0, 100);

    global.acoso =
        clamp(global.acoso, 0, 100);

    linea_dialogo = 0;

    dialogo_activo = true;

    global.iniciar_dialogo = true;

    if (global.decision1 == 1)
    {
        estado =
            "incidente_entrar";
    }

    else if (global.decision1 == 2)
    {
        estado =
            "incidente_celular";
    }

    else
    {
        estado =
            "incidente_no_entrar";
    }
}

// ============================================================
// PRIMER INCIDENTE
// ENTRAR
// ============================================================

if (
    room == Room2 &&
    estado == "incidente_entrar"
)
{
    if (espacio_dialogo_presionado && !bloquear_avance_dialogo)
    {
        linea_dialogo += 1;

        if (
            linea_dialogo >=
            cantidad_incidente_entrar
        )
        {
            dialogo_activo = false;

            global.iniciar_dialogo = false;

            estado =
                "incidente_terminado";
        }
    }
}

// ============================================================
// PRIMER INCIDENTE
// CELULAR
// ============================================================

if (
    room == Room2 &&
    estado == "incidente_celular"
)
{
    if (espacio_dialogo_presionado && !bloquear_avance_dialogo)
    {
        linea_dialogo += 1;

        if (
            linea_dialogo >=
            cantidad_incidente_celular
        )
        {
            dialogo_activo = false;

            global.iniciar_dialogo = false;

            estado =
                "incidente_terminado";
        }
    }
}

// ============================================================
// PRIMER INCIDENTE
// NO ENTRAR
// ============================================================

if (
    room == Room2 &&
    estado == "incidente_no_entrar"
)
{
    if (espacio_dialogo_presionado && !bloquear_avance_dialogo)
    {
        linea_dialogo += 1;

        if (
            linea_dialogo >=
            cantidad_incidente_no_entrar
        )
        {
            dialogo_activo = false;

            global.iniciar_dialogo = false;

            estado =
                "incidente_terminado";
        }
    }
}

// ============================================================
// ACTIVAR DECISION 2
// ============================================================

if (
    room == Room2 &&
    estado == "incidente_terminado"
)
{
    global.etapa_historia = 4;

    global.decision_pendiente = true;

    global.decision_actual = 2;

    global.decision2 = 0;

    estado =
        "esperando_decision2";
}

// ============================================================
// DECISION 2
// ============================================================

if (
    room == Room2 &&
    estado == "esperando_decision2"
)
{
    if (global.decision2 == 1)
    {
        global.decision_pendiente = false;

        global.decision_actual = 0;

        global.respondio = true;

        global.bienestar -= 10;

        global.acoso += 15;

        global.bienestar =
            clamp(global.bienestar, 0, 100);

        global.acoso =
            clamp(global.acoso, 0, 100);

        global.etapa_historia = 5;

        estado =
            "decision2_responder";
    }

    else if (global.decision2 == 2)
    {
        global.decision_pendiente = false;

        global.decision_actual = 0;

        global.guardo_pruebas = true;

        global.bloqueo_agresores = true;

        global.bienestar += 5;

        global.apoyo += 10;

        global.acoso -= 10;

        global.bienestar =
            clamp(global.bienestar, 0, 100);

        global.apoyo =
            clamp(global.apoyo, 0, 100);

        global.acoso =
            clamp(global.acoso, 0, 100);

        global.etapa_historia = 5;

        estado =
            "decision2_guardar_bloquear";
    }

    else if (global.decision2 == 3)
    {
        global.decision_pendiente = false;

        global.decision_actual = 0;

        global.ignoro = true;

        global.bienestar -= 5;

        global.acoso += 5;

        global.bienestar =
            clamp(global.bienestar, 0, 100);

        global.acoso =
            clamp(global.acoso, 0, 100);

        global.etapa_historia = 5;

        estado =
            "decision2_ignorar";
    }
}

// ============================================================
// DIALOGO DECISION 2
// RESPONDER
// ============================================================

if (
    room == Room2 &&
    estado == "decision2_responder"
)
{
    linea_dialogo = 0;

    dialogo_activo = true;

    global.iniciar_dialogo = true;

    estado =
        "dialogo_decision2_responder";
}

if (
    room == Room2 &&
    estado == "dialogo_decision2_responder"
)
{
    if (espacio_dialogo_presionado && !bloquear_avance_dialogo)
    {
        linea_dialogo += 1;

        if (
            linea_dialogo >=
            cantidad_decision2_responder
        )
        {
            dialogo_activo = false;

            global.iniciar_dialogo = false;

            estado =
                "ir_room4_segundo_incidente";
        }
    }
}

// ============================================================
// DIALOGO DECISION 2
// GUARDAR
// ============================================================

if (
    room == Room2 &&
    estado == "decision2_guardar_bloquear"
)
{
    linea_dialogo = 0;

    dialogo_activo = true;

    global.iniciar_dialogo = true;

    estado =
        "dialogo_decision2_guardar";
}

if (
    room == Room2 &&
    estado == "dialogo_decision2_guardar"
)
{
    if (espacio_dialogo_presionado && !bloquear_avance_dialogo)
    {
        linea_dialogo += 1;

        if (
            linea_dialogo >=
            cantidad_decision2_guardar
        )
        {
            dialogo_activo = false;

            global.iniciar_dialogo = false;

            estado =
                "ir_room4_segundo_incidente";
        }
    }
}

// ============================================================
// DIALOGO DECISION 2
// IGNORAR
// ============================================================

if (
    room == Room2 &&
    estado == "decision2_ignorar"
)
{
    linea_dialogo = 0;

    dialogo_activo = true;

    global.iniciar_dialogo = true;

    estado =
        "dialogo_decision2_ignorar";
}

if (
    room == Room2 &&
    estado == "dialogo_decision2_ignorar"
)
{
    if (espacio_dialogo_presionado && !bloquear_avance_dialogo)
    {
        linea_dialogo += 1;

        if (
            linea_dialogo >=
            cantidad_decision2_ignorar
        )
        {
            dialogo_activo = false;

            global.iniciar_dialogo = false;

            estado =
                "ir_room4_segundo_incidente";
        }
    }
}

// ============================================================
// IR A ROOM 4
// ============================================================

if (
    room == Room2 &&
    estado == "ir_room4_segundo_incidente"
)
{
    room_goto(Room4);
}

// ============================================================
// ROOM 4
// CREAR PERSONAJES FUERA DE PANTALLA
// ============================================================

if (
    room == Room4 &&
    estado == "ir_room4_segundo_incidente"
)
{
    global.segundo_incidente = true;

    roger = instance_create_layer(
        -100,
        350,
        "Instances",
        obj_protagonista
    );

    amigo = instance_create_layer(
        room_width + 100,
        350,
        "Instances",
        obj_amigo
    );

    amiga = instance_create_layer(
        room_width + 200,
        350,
        "Instances",
        obj_amiga
    );

    objetivo_roger =
        room_width * 0.25;

    objetivo_amigo =
        room_width * 0.52;

    objetivo_amiga =
        room_width * 0.75;

    roger.image_xscale = escala_normal;
    roger.image_yscale = escala_normal;

    amigo.image_xscale = escala_normal;
    amigo.image_yscale = escala_normal;

    amiga.image_xscale = escala_normal;
    amiga.image_yscale = escala_normal;

    estado =
        "entrada_room4_segundo_incidente";
}

// ============================================================
// ROOM 4
// ENTRADA PERSONAJES
// ============================================================

if (
    room == Room4 &&
    estado == "entrada_room4_segundo_incidente"
)
{
    roger.x =
        lerp(
            roger.x,
            objetivo_roger,
            0.08
        );

    amigo.x =
        lerp(
            amigo.x,
            objetivo_amigo,
            0.08
        );

    amiga.x =
        lerp(
            amiga.x,
            objetivo_amiga,
            0.08
        );

    if (
        abs(roger.x - objetivo_roger) < 2 &&
        abs(amigo.x - objetivo_amigo) < 2 &&
        abs(amiga.x - objetivo_amiga) < 2
    )
    {
        roger.x = objetivo_roger;

        amigo.x = objetivo_amigo;

        amiga.x = objetivo_amiga;

        linea_dialogo = 0;

        dialogo_activo = true;

        global.iniciar_dialogo = true;

        if (global.decision2 == 1)
        {
            global.bienestar -= 10;

            global.acoso += 15;

            global.bienestar =
                clamp(global.bienestar, 0, 100);

            global.acoso =
                clamp(global.acoso, 0, 100);

            estado =
                "segundo_incidente_responder";
        }

        else if (global.decision2 == 2)
        {
            global.bienestar -= 5;

            global.acoso += 5;

            global.apoyo += 5;

            global.bienestar =
                clamp(global.bienestar, 0, 100);

            global.acoso =
                clamp(global.acoso, 0, 100);

            global.apoyo =
                clamp(global.apoyo, 0, 100);

            estado =
                "segundo_incidente_guardar";
        }

        else
        {
            global.bienestar -= 10;

            global.acoso += 10;

            global.bienestar =
                clamp(global.bienestar, 0, 100);

            global.acoso =
                clamp(global.acoso, 0, 100);

            estado =
                "segundo_incidente_ignorar";
        }
    }
}

// ============================================================
// ROOM 4
// ANIMACION SEGUNDO INCIDENTE
// ============================================================

if (
    room == Room4 &&
    (
        estado == "segundo_incidente_responder" ||
        estado == "segundo_incidente_guardar" ||
        estado == "segundo_incidente_ignorar"
    )
)
{
    roger.image_xscale =
        lerp(
            roger.image_xscale,
            escala_normal,
            0.08
        );

    roger.image_yscale =
        lerp(
            roger.image_yscale,
            escala_normal,
            0.08
        );

    amigo.image_xscale =
        lerp(
            amigo.image_xscale,
            escala_normal,
            0.08
        );

    amigo.image_yscale =
        lerp(
            amigo.image_yscale,
            escala_normal,
            0.08
        );

    amiga.image_xscale =
        lerp(
            amiga.image_xscale,
            escala_normal,
            0.08
        );

    amiga.image_yscale =
        lerp(
            amiga.image_yscale,
            escala_normal,
            0.08
        );

    if (estado == "segundo_incidente_responder")
    {
        if (
            linea_dialogo == 0 ||
            linea_dialogo == 2
        )
        {
            roger.image_xscale =
                lerp(
                    roger.image_xscale,
                    escala_hablando,
                    0.15
                );

            roger.image_yscale =
                lerp(
                    roger.image_yscale,
                    escala_hablando,
                    0.15
                );
        }

        if (linea_dialogo == 1)
        {
            amigo.image_xscale =
                lerp(
                    amigo.image_xscale,
                    escala_hablando,
                    0.15
                );

            amigo.image_yscale =
                lerp(
                    amigo.image_yscale,
                    escala_hablando,
                    0.15
                );
        }

        if (linea_dialogo == 3)
        {
            amiga.image_xscale =
                lerp(
                    amiga.image_xscale,
                    escala_hablando,
                    0.15
                );

            amiga.image_yscale =
                lerp(
                    amiga.image_yscale,
                    escala_hablando,
                    0.15
                );
        }
    }

    if (estado == "segundo_incidente_guardar")
    {
        if (
            linea_dialogo == 0 ||
            linea_dialogo == 1
        )
        {
            roger.image_xscale =
                lerp(
                    roger.image_xscale,
                    escala_hablando,
                    0.15
                );

            roger.image_yscale =
                lerp(
                    roger.image_yscale,
                    escala_hablando,
                    0.15
                );
        }

        if (linea_dialogo == 2)
        {
            amigo.image_xscale =
                lerp(
                    amigo.image_xscale,
                    escala_hablando,
                    0.15
                );

            amigo.image_yscale =
                lerp(
                    amigo.image_yscale,
                    escala_hablando,
                    0.15
                );
        }

        if (linea_dialogo == 3)
        {
            amiga.image_xscale =
                lerp(
                    amiga.image_xscale,
                    escala_hablando,
                    0.15
                );

            amiga.image_yscale =
                lerp(
                    amiga.image_yscale,
                    escala_hablando,
                    0.15
                );
        }
    }

    if (estado == "segundo_incidente_ignorar")
    {
        if (
            linea_dialogo == 0 ||
            linea_dialogo == 1
        )
        {
            roger.image_xscale =
                lerp(
                    roger.image_xscale,
                    escala_hablando,
                    0.15
                );

            roger.image_yscale =
                lerp(
                    roger.image_yscale,
                    escala_hablando,
                    0.15
                );
        }

        if (linea_dialogo == 2)
        {
            amigo.image_xscale =
                lerp(
                    amigo.image_xscale,
                    escala_hablando,
                    0.15
                );

            amigo.image_yscale =
                lerp(
                    amigo.image_yscale,
                    escala_hablando,
                    0.15
                );
        }

        if (linea_dialogo == 3)
        {
            amiga.image_xscale =
                lerp(
                    amiga.image_xscale,
                    escala_hablando,
                    0.15
                );

            amiga.image_yscale =
                lerp(
                    amiga.image_yscale,
                    escala_hablando,
                    0.15
                );
        }
    }
}

// ============================================================
// FIN SEGUNDO INCIDENTE
// ============================================================

if (
    room == Room4 &&
    estado == "segundo_incidente_responder"
)
{
    if (espacio_dialogo_presionado && !bloquear_avance_dialogo)
    {
        linea_dialogo += 1;

        if (
            linea_dialogo >=
            cantidad_segundo_incidente_responder
        )
        {
            dialogo_activo = false;

            global.iniciar_dialogo = false;

            estado =
                "volver_room2_despues_incidente2";

            room_goto(Room2);
        }
    }
}

if (
    room == Room4 &&
    estado == "segundo_incidente_guardar"
)
{
    if (espacio_dialogo_presionado && !bloquear_avance_dialogo)
    {
        linea_dialogo += 1;

        if (
            linea_dialogo >=
            cantidad_segundo_incidente_guardar
        )
        {
            dialogo_activo = false;

            global.iniciar_dialogo = false;

            estado =
                "volver_room2_despues_incidente2";

            room_goto(Room2);
        }
    }
}

if (
    room == Room4 &&
    estado == "segundo_incidente_ignorar"
)
{
    if (espacio_dialogo_presionado && !bloquear_avance_dialogo)
    {
        linea_dialogo += 1;

        if (
            linea_dialogo >=
            cantidad_segundo_incidente_ignorar
        )
        {
            dialogo_activo = false;

            global.iniciar_dialogo = false;

            estado =
                "volver_room2_despues_incidente2";

            room_goto(Room2);
        }
    }
}

// ============================================================
// VOLVER ROOM 2
// ============================================================

if (
    room == Room2 &&
    estado == "volver_room2_despues_incidente2"
)
{
    roger = instance_create_layer(
        room_width * 0.25,
        350,
        "Instances",
        obj_protagonista
    );

    amigo = instance_create_layer(
        room_width * 0.50,
        350,
        "Instances",
        obj_amigo
    );

    amiga = instance_create_layer(
        room_width * 0.75,
        350,
        "Instances",
        obj_amiga
    );

    estado =
        "segundo_incidente_terminado";
}

// ============================================================
// ACTIVAR DECISION 3
// ============================================================

if (
    room == Room2 &&
    estado == "segundo_incidente_terminado"
)
{
    global.etapa_historia = 6;

    global.decision_pendiente = true;

    global.decision_actual = 3;

    global.decision3 = 0;

    estado =
        "esperando_decision3";
}

// ============================================================
// DECISION 3
// ============================================================

if (
    room == Room2 &&
    estado == "esperando_decision3"
)
{
    // AMIGOS
    if (global.decision3 == 1)
    {
        global.decision_pendiente = false;

        global.decision_actual = 0;

        global.conto_amigo = true;

        global.apoyo += 15;

        global.bienestar += 5;

        global.apoyo =
            clamp(global.apoyo, 0, 100);

        global.bienestar =
            clamp(global.bienestar, 0, 100);

        global.etapa_historia = 7;

        estado =
            "ir_room5_decision3";

        room_goto(Room5);
    }

    // PROFESOR
    else if (global.decision3 == 2)
    {
        global.decision_pendiente = false;

        global.decision_actual = 0;

        global.hablo_profesor = true;

        global.apoyo += 20;

        global.bienestar += 10;

        global.apoyo =
            clamp(global.apoyo, 0, 100);

        global.bienestar =
            clamp(global.bienestar, 0, 100);

        global.etapa_historia = 7;

        estado =
            "ir_profesor_decision3";

        room_goto(Room3);
    }

    // SOLO
    else if (global.decision3 == 3)
    {
        global.decision_pendiente = false;

        global.decision_actual = 0;

        global.oculto_problema = true;

        global.se_aislo = true;

        global.bienestar -= 15;

        global.apoyo -= 10;

        global.acoso += 10;

        global.bienestar =
            clamp(global.bienestar, 0, 100);

        global.apoyo =
            clamp(global.apoyo, 0, 100);

        global.acoso =
            clamp(global.acoso, 0, 100);

        global.etapa_historia = 7;

        estado =
            "ir_room8_decision3";

        room_goto(Room8);
    }
}

// ============================================================
// ROOM 5
// CREAR PERSONAJES
// ============================================================

if (
    room == Room5 &&
    estado == "ir_room5_decision3"
)
{
    roger = instance_create_layer(
        -100,
        350,
        "Instances",
        obj_protagonista
    );

    amigo = instance_create_layer(
        room_width + 100,
        350,
        "Instances",
        obj_amigo
    );

    amiga = instance_create_layer(
        room_width + 200,
        350,
        "Instances",
        obj_amiga
    );

    objetivo_roger =
        room_width * 0.25;

    objetivo_amigo =
        room_width * 0.50;

    objetivo_amiga =
        room_width * 0.75;

    estado =
        "entrada_room5_decision3";
}

// ============================================================
// ROOM 5
// ENTRADA
// ============================================================

if (
    room == Room5 &&
    estado == "entrada_room5_decision3"
)
{
    roger.x =
        lerp(
            roger.x,
            objetivo_roger,
            0.08
        );

    amigo.x =
        lerp(
            amigo.x,
            objetivo_amigo,
            0.08
        );

    amiga.x =
        lerp(
            amiga.x,
            objetivo_amiga,
            0.08
        );

    if (
        abs(roger.x - objetivo_roger) < 2 &&
        abs(amigo.x - objetivo_amigo) < 2 &&
        abs(amiga.x - objetivo_amiga) < 2
    )
    {
        roger.x = objetivo_roger;

        amigo.x = objetivo_amigo;

        amiga.x = objetivo_amiga;

        linea_dialogo = 0;

        dialogo_activo = true;

        global.iniciar_dialogo = true;

        estado =
            "dialogo_decision3_amigo";
    }
}

// ============================================================
// ROOM 5
// ANIMACION
// ============================================================

if (
    room == Room5 &&
    estado == "dialogo_decision3_amigo"
)
{
    roger.image_xscale =
        lerp(
            roger.image_xscale,
            escala_normal,
            0.08
        );

    roger.image_yscale =
        lerp(
            roger.image_yscale,
            escala_normal,
            0.08
        );

    amigo.image_xscale =
        lerp(
            amigo.image_xscale,
            escala_normal,
            0.08
        );

    amigo.image_yscale =
        lerp(
            amigo.image_yscale,
            escala_normal,
            0.08
        );

    amiga.image_xscale =
        lerp(
            amiga.image_xscale,
            escala_normal,
            0.08
        );

    amiga.image_yscale =
        lerp(
            amiga.image_yscale,
            escala_normal,
            0.08
        );

    if (
        linea_dialogo == 0 ||
        linea_dialogo == 1 ||
        linea_dialogo == 4
    )
    {
        roger.image_xscale =
            lerp(
                roger.image_xscale,
                escala_hablando,
                0.15
            );

        roger.image_yscale =
            lerp(
                roger.image_yscale,
                escala_hablando,
                0.15
            );
    }

    if (linea_dialogo == 2)
    {
        amigo.image_xscale =
            lerp(
                amigo.image_xscale,
                escala_hablando,
                0.15
            );

        amigo.image_yscale =
            lerp(
                amigo.image_yscale,
                escala_hablando,
                0.15
            );
    }

    if (linea_dialogo == 3)
    {
        amiga.image_xscale =
            lerp(
                amiga.image_xscale,
                escala_hablando,
                0.15
            );

        amiga.image_yscale =
            lerp(
                amiga.image_yscale,
                escala_hablando,
                0.15
            );
    }
}

// ============================================================
// ROOM 5
// FIN DIALOGO
// ============================================================

if (
    room == Room5 &&
    estado == "dialogo_decision3_amigo"
)
{
    if (espacio_dialogo_presionado && !bloquear_avance_dialogo)
    {
        linea_dialogo += 1;

        if (
            linea_dialogo >=
            cantidad_decision3_amigo
        )
        {
            dialogo_activo = false;

            global.iniciar_dialogo = false;

            estado =
                "volver_room2_despues_decision3";

            room_goto(Room2);
        }
    }
}

// ============================================================
// ROOM 3
// PROFESOR DECISION 3
// ============================================================

if (
    room == Room3 &&
    estado == "ir_profesor_decision3"
)
{
    roger = instance_create_layer(
        -100,
        350,
        "Instances",
        obj_protagonista
    );

    profesor = instance_create_layer(
        room_width + 100,
        350,
        "Instances",
        obj_profesor
    );

    objetivo_roger =
        room_width * 0.30;

    objetivo_profesor =
        room_width * 0.65;

    estado =
        "entrada_profesor_decision3";
}

// ============================================================
// ROOM 3
// ENTRADA PROFESOR DECISION 3
// ============================================================

if (
    room == Room3 &&
    estado == "entrada_profesor_decision3"
)
{
    roger.x =
        lerp(
            roger.x,
            objetivo_roger,
            0.08
        );

    profesor.x =
        lerp(
            profesor.x,
            objetivo_profesor,
            0.08
        );

    if (
        abs(roger.x - objetivo_roger) < 2 &&
        abs(profesor.x - objetivo_profesor) < 2
    )
    {
        roger.x = objetivo_roger;

        profesor.x = objetivo_profesor;

        linea_dialogo = 0;

        dialogo_activo = true;

        global.iniciar_dialogo = true;

        estado =
            "dialogo_decision3_profesor";
    }
}

// ============================================================
// ROOM 3
// ANIMACION PROFESOR DECISION 3
// ============================================================

if (
    room == Room3 &&
    estado == "dialogo_decision3_profesor"
)
{
    roger.image_xscale =
        lerp(
            roger.image_xscale,
            escala_normal,
            0.08
        );

    roger.image_yscale =
        lerp(
            roger.image_yscale,
            escala_normal,
            0.08
        );

    profesor.image_xscale =
        lerp(
            profesor.image_xscale,
            escala_normal,
            0.08
        );

    profesor.image_yscale =
        lerp(
            profesor.image_yscale,
            escala_normal,
            0.08
        );

    if (
        linea_dialogo == 0 ||
        linea_dialogo == 2 ||
        linea_dialogo == 5
    )
    {
        roger.image_xscale =
            lerp(
                roger.image_xscale,
                escala_hablando,
                0.15
            );

        roger.image_yscale =
            lerp(
                roger.image_yscale,
                escala_hablando,
                0.15
            );
    }

    if (
        linea_dialogo == 1 ||
        linea_dialogo == 3 ||
        linea_dialogo == 4
    )
    {
        profesor.image_xscale =
            lerp(
                profesor.image_xscale,
                escala_hablando,
                0.15
            );

        profesor.image_yscale =
            lerp(
                profesor.image_yscale,
                escala_hablando,
                0.15
            );
    }
}

// ============================================================
// ROOM 3
// FIN DIALOGO PROFESOR DECISION 3
// ============================================================

if (
    room == Room3 &&
    estado == "dialogo_decision3_profesor"
)
{
    if (espacio_dialogo_presionado && !bloquear_avance_dialogo)
    {
        linea_dialogo += 1;

        if (
            linea_dialogo >=
            cantidad_decision3_profesor
        )
        {
            dialogo_activo = false;

            global.iniciar_dialogo = false;

            estado =
                "volver_room2_despues_decision3";

            room_goto(Room2);
        }
    }
}

// ============================================================
// ROOM 8
// ROGER SOLO DECISION 3
// ============================================================

if (
    room == Room8 &&
    estado == "ir_room8_decision3"
)
{
    roger = instance_create_layer(
        -100,
        350,
        "Instances",
        obj_protagonista
    );

    objetivo_roger =
        room_width * 0.50;

    estado =
        "entrada_room8_decision3";
}

// ============================================================
// ROOM 8
// ENTRADA ROGER DECISION 3
// ============================================================

if (
    room == Room8 &&
    estado == "entrada_room8_decision3"
)
{
    roger.x =
        lerp(
            roger.x,
            objetivo_roger,
            0.08
        );

    if (
        abs(roger.x - objetivo_roger) < 2
    )
    {
        roger.x = objetivo_roger;

        linea_dialogo = 0;

        dialogo_activo = true;

        global.iniciar_dialogo = true;

        estado =
            "dialogo_decision3_ocultar";
    }
}

// ============================================================
// ROOM 8
// ANIMACION ROGER SOLO
// ============================================================

if (
    room == Room8 &&
    estado == "dialogo_decision3_ocultar"
)
{
    roger.image_xscale =
        lerp(
            roger.image_xscale,
            escala_hablando,
            0.12
        );

    roger.image_yscale =
        lerp(
            roger.image_yscale,
            escala_hablando,
            0.12
        );
}

// ============================================================
// ROOM 8
// FIN DECISION 3 SOLO
// ============================================================

if (
    room == Room8 &&
    estado == "dialogo_decision3_ocultar"
)
{
    if (espacio_dialogo_presionado && !bloquear_avance_dialogo)
    {
        linea_dialogo += 1;

        if (
            linea_dialogo >=
            cantidad_decision3_ocultar
        )
        {
            dialogo_activo = false;

            global.iniciar_dialogo = false;

            estado =
                "volver_room2_despues_decision3";

            room_goto(Room2);
        }
    }
}

// ============================================================
// VOLVER ROOM 2 DESPUES DECISION 3
// ============================================================

if (
    room == Room2 &&
    estado == "volver_room2_despues_decision3"
)
{
    roger = instance_create_layer(
        room_width * 0.25,
        350,
        "Instances",
        obj_protagonista
    );

    amigo = instance_create_layer(
        room_width * 0.50,
        350,
        "Instances",
        obj_amigo
    );

    amiga = instance_create_layer(
        room_width * 0.75,
        350,
        "Instances",
        obj_amiga
    );

    estado =
        "despues_decision3";
}

// ============================================================
// ACTIVAR DECISION 4
// ============================================================

if (
    room == Room2 &&
    estado == "despues_decision3"
)
{
    global.etapa_historia = 8;

    global.decision_pendiente = true;

    global.decision_actual = 4;

    global.decision4 = 0;

    estado =
        "esperando_decision4";
}

// ============================================================
// DECISION 4
// ============================================================

if (
    room == Room2 &&
    estado == "esperando_decision4"
)
{
    // FAMILIA
    if (global.decision4 == 1)
    {
        global.decision_pendiente = false;

        global.decision_actual = 0;

        global.hablo_familia = true;

        global.apoyo += 25;

        global.bienestar += 15;

        global.acoso -= 10;

        global.apoyo =
            clamp(global.apoyo, 0, 100);

        global.bienestar =
            clamp(global.bienestar, 0, 100);

        global.acoso =
            clamp(global.acoso, 0, 100);

        global.etapa_historia = 9;

        estado =
            "ir_room9_familia";

        room_goto(Room9);
    }

    // PSICOLOGA
    else if (global.decision4 == 2)
    {
        global.decision_pendiente = false;

        global.decision_actual = 0;

        global.aparece_psicologa = true;

        global.aprendio_seguridad = true;

        global.apoyo += 25;

        global.bienestar += 20;

        global.acoso -= 15;

        global.apoyo =
            clamp(global.apoyo, 0, 100);

        global.bienestar =
            clamp(global.bienestar, 0, 100);

        global.acoso =
            clamp(global.acoso, 0, 100);

        global.etapa_historia = 9;

        estado =
            "ir_room6_psicologa";

        room_goto(Room6);
    }

    // SOLO
    else if (global.decision4 == 3)
    {
        global.decision_pendiente = false;

        global.decision_actual = 0;

        global.sigue_solo = true;

        global.se_aislo = true;

        global.bienestar -= 20;

        global.apoyo -= 10;

        global.acoso += 15;

        global.bienestar =
            clamp(global.bienestar, 0, 100);

        global.apoyo =
            clamp(global.apoyo, 0, 100);

        global.acoso =
            clamp(global.acoso, 0, 100);

        global.etapa_historia = 9;

        estado =
            "ir_room8_decision4";

        room_goto(Room8);
    }
}

// ============================================================
// ROOM 9
// CREAR FAMILIA
// ============================================================

if (
    room == Room9 &&
    estado == "ir_room9_familia"
)
{
    roger = instance_create_layer(
        -100,
        350,
        "Instances",
        obj_protagonista
    );

    madre = instance_create_layer(
        room_width + 100,
        350,
        "Instances",
        obj_madre
    );

    padre = instance_create_layer(
        room_width + 200,
        350,
        "Instances",
        obj_padre
    );

    objetivo_roger =
        room_width * 0.25;

    objetivo_madre =
        room_width * 0.55;

    objetivo_padre =
        room_width * 0.75;

    roger.image_xscale = escala_normal;
    roger.image_yscale = escala_normal;

    madre.image_xscale = escala_normal;
    madre.image_yscale = escala_normal;

    padre.image_xscale = escala_normal;
    padre.image_yscale = escala_normal;

    roger.image_alpha = 0;
    madre.image_alpha = 0;
    padre.image_alpha = 0;

    dialogo_activo = false;

    global.iniciar_dialogo = false;

    tiempo_espera_familia = 0;

    estado =
        "entrada_room9_familia";
}

// ============================================================
// ROOM 9
// ENTRADA FAMILIA
// ============================================================

if (
    room == Room9 &&
    estado == "entrada_room9_familia"
)
{
    if (instance_exists(roger))
    {
        roger.x =
            lerp(
                roger.x,
                objetivo_roger,
                0.09
            );

        roger.image_alpha =
            lerp(
                roger.image_alpha,
                1,
                0.10
            );
    }

    if (instance_exists(madre))
    {
        madre.x =
            lerp(
                madre.x,
                objetivo_madre,
                0.075
            );

        madre.image_alpha =
            lerp(
                madre.image_alpha,
                1,
                0.09
            );
    }

    if (instance_exists(padre))
    {
        padre.x =
            lerp(
                padre.x,
                objetivo_padre,
                0.065
            );

        padre.image_alpha =
            lerp(
                padre.image_alpha,
                1,
                0.08
            );
    }

    if (
        instance_exists(roger) &&
        instance_exists(madre) &&
        instance_exists(padre)
    )
    {
        if (
            abs(roger.x - objetivo_roger) < 2 &&
            abs(madre.x - objetivo_madre) < 2 &&
            abs(padre.x - objetivo_padre) < 2
        )
        {
            roger.x = objetivo_roger;

            madre.x = objetivo_madre;

            padre.x = objetivo_padre;

            roger.image_alpha = 1;
            madre.image_alpha = 1;
            padre.image_alpha = 1;

            tiempo_espera_familia = 0;

            estado =
                "pausa_room9_familia";
        }
    }
}

// ============================================================
// ROOM 9
// PAUSA ANTES DEL DIALOGO
// ============================================================

if (
    room == Room9 &&
    estado == "pausa_room9_familia"
)
{
    tiempo_espera_familia += 1;

    if (
        tiempo_espera_familia >=
        game_get_speed(gamespeed_fps) * 0.5
    )
    {
        linea_dialogo = 0;

        dialogo_activo = true;

        global.iniciar_dialogo = true;

        estado =
            "dialogo_decision4_familia";
    }
}

// ============================================================
// ROOM 9
// ANIMACION FAMILIA
// ============================================================

if (
    room == Room9 &&
    estado == "dialogo_decision4_familia"
)
{
    if (
        instance_exists(roger) &&
        instance_exists(madre) &&
        instance_exists(padre)
    )
    {
        roger.image_xscale =
            lerp(
                roger.image_xscale,
                escala_normal,
                0.08
            );

        roger.image_yscale =
            lerp(
                roger.image_yscale,
                escala_normal,
                0.08
            );

        madre.image_xscale =
            lerp(
                madre.image_xscale,
                escala_normal,
                0.08
            );

        madre.image_yscale =
            lerp(
                madre.image_yscale,
                escala_normal,
                0.08
            );

        padre.image_xscale =
            lerp(
                padre.image_xscale,
                escala_normal,
                0.08
            );

        padre.image_yscale =
            lerp(
                padre.image_yscale,
                escala_normal,
                0.08
            );

        if (
            linea_dialogo == 0 ||
            linea_dialogo == 3
        )
        {
            roger.image_xscale =
                lerp(
                    roger.image_xscale,
                    escala_hablando,
                    0.15
                );

            roger.image_yscale =
                lerp(
                    roger.image_yscale,
                    escala_hablando,
                    0.15
                );
        }

        if (
            linea_dialogo == 1 ||
            linea_dialogo == 4
        )
        {
            madre.image_xscale =
                lerp(
                    madre.image_xscale,
                    escala_hablando,
                    0.15
                );

            madre.image_yscale =
                lerp(
                    madre.image_yscale,
                    escala_hablando,
                    0.15
                );
        }

        if (linea_dialogo == 2)
        {
            padre.image_xscale =
                lerp(
                    padre.image_xscale,
                    escala_hablando,
                    0.15
                );

            padre.image_yscale =
                lerp(
                    padre.image_yscale,
                    escala_hablando,
                    0.15
                );
        }
    }
}

// ============================================================
// ROOM 9
// FIN DIALOGO FAMILIA
// ============================================================

if (
    room == Room9 &&
    estado == "dialogo_decision4_familia"
)
{
    if (espacio_dialogo_presionado && !bloquear_avance_dialogo)
    {
        linea_dialogo += 1;

        if (
            linea_dialogo >=
            cantidad_decision4_familia
        )
        {
            dialogo_activo = false;

            global.iniciar_dialogo = false;

            estado =
                "volver_room2_final";

            room_goto(Room2);
        }
    }
}

// ============================================================
// ROOM 6
// CREAR PSICOLOGA
// ============================================================

if (
    room == Room6 &&
    estado == "ir_room6_psicologa"
)
{
    roger = instance_create_layer(
        -100,
        350,
        "Instances",
        obj_protagonista
    );

    psicologa = instance_create_layer(
        room_width + 100,
        350,
        "Instances",
        obj_psicologa
    );

    objetivo_roger =
        room_width * 0.30;

    objetivo_psicologa =
        room_width * 0.68;

    roger.image_xscale = escala_normal;
    roger.image_yscale = escala_normal;

    psicologa.image_xscale = escala_normal;
    psicologa.image_yscale = escala_normal;

    roger.image_alpha = 0;
    psicologa.image_alpha = 0;

    dialogo_activo = false;

    global.iniciar_dialogo = false;

    tiempo_espera_psicologa = 0;

    estado =
        "entrada_room6_psicologa";
}

// ============================================================
// ROOM 6
// ENTRADA PSICOLOGA
// ============================================================

if (
    room == Room6 &&
    estado == "entrada_room6_psicologa"
)
{
    if (instance_exists(roger))
    {
        roger.x =
            lerp(
                roger.x,
                objetivo_roger,
                0.09
            );

        roger.image_alpha =
            lerp(
                roger.image_alpha,
                1,
                0.10
            );
    }

    if (instance_exists(psicologa))
    {
        psicologa.x =
            lerp(
                psicologa.x,
                objetivo_psicologa,
                0.07
            );

        psicologa.image_alpha =
            lerp(
                psicologa.image_alpha,
                1,
                0.09
            );
    }

    if (
        instance_exists(roger) &&
        instance_exists(psicologa)
    )
    {
        if (
            abs(roger.x - objetivo_roger) < 2 &&
            abs(psicologa.x - objetivo_psicologa) < 2
        )
        {
            roger.x =
                objetivo_roger;

            psicologa.x =
                objetivo_psicologa;

            roger.image_alpha = 1;

            psicologa.image_alpha = 1;

            tiempo_espera_psicologa = 0;

            estado =
                "pausa_room6_psicologa";
        }
    }
}

// ============================================================
// ROOM 6
// PAUSA ANTES DEL DIALOGO
// ============================================================

if (
    room == Room6 &&
    estado == "pausa_room6_psicologa"
)
{
    tiempo_espera_psicologa += 1;

    if (
        tiempo_espera_psicologa >=
        game_get_speed(gamespeed_fps) * 0.5
    )
    {
        linea_dialogo = 0;

        dialogo_activo = true;

        global.iniciar_dialogo = true;

        estado =
            "dialogo_decision4_psicologa";
    }
}

// ============================================================
// ROOM 6
// ANIMACION PSICOLOGA
// ============================================================

if (
    room == Room6 &&
    estado == "dialogo_decision4_psicologa"
)
{
    if (
        instance_exists(roger) &&
        instance_exists(psicologa)
    )
    {
        roger.image_xscale =
            lerp(
                roger.image_xscale,
                escala_normal,
                0.08
            );

        roger.image_yscale =
            lerp(
                roger.image_yscale,
                escala_normal,
                0.08
            );

        psicologa.image_xscale =
            lerp(
                psicologa.image_xscale,
                escala_normal,
                0.08
            );

        psicologa.image_yscale =
            lerp(
                psicologa.image_yscale,
                escala_normal,
                0.08
            );

        if (
            linea_dialogo == 0 ||
            linea_dialogo == 2 ||
            linea_dialogo == 5
        )
        {
            roger.image_xscale =
                lerp(
                    roger.image_xscale,
                    escala_hablando,
                    0.15
                );

            roger.image_yscale =
                lerp(
                    roger.image_yscale,
                    escala_hablando,
                    0.15
                );
        }

        if (
            linea_dialogo == 1 ||
            linea_dialogo == 3 ||
            linea_dialogo == 4
        )
        {
            psicologa.image_xscale =
                lerp(
                    psicologa.image_xscale,
                    escala_hablando,
                    0.15
                );

            psicologa.image_yscale =
                lerp(
                    psicologa.image_yscale,
                    escala_hablando,
                    0.15
                );
        }
    }
}

// ============================================================
// ROOM 6
// FIN DIALOGO PSICOLOGA
// ============================================================

if (
    room == Room6 &&
    estado == "dialogo_decision4_psicologa"
)
{
    if (espacio_dialogo_presionado && !bloquear_avance_dialogo)
    {
        linea_dialogo += 1;

        if (
            linea_dialogo >=
            cantidad_decision4_psicologa
        )
        {
            dialogo_activo = false;

            global.iniciar_dialogo = false;

            estado =
                "volver_room2_final";

            room_goto(Room2);
        }
    }
}

// ============================================================
// ROOM 8
// ROGER SOLO DECISION 4
// ============================================================

if (
    room == Room8 &&
    estado == "ir_room8_decision4"
)
{
    roger = instance_create_layer(
        -100,
        350,
        "Instances",
        obj_protagonista
    );

    objetivo_roger =
        room_width * 0.50;

    roger.image_xscale = escala_normal;
    roger.image_yscale = escala_normal;

    roger.image_alpha = 0;

    dialogo_activo = false;

    global.iniciar_dialogo = false;

    tiempo_espera_solo = 0;

    estado =
        "entrada_room8_decision4";
}

// ============================================================
// ROOM 8
// ENTRADA SOLO DECISION 4
// ============================================================

if (
    room == Room8 &&
    estado == "entrada_room8_decision4"
)
{
    if (instance_exists(roger))
    {
        roger.x =
            lerp(
                roger.x,
                objetivo_roger,
                0.06
            );

        roger.image_alpha =
            lerp(
                roger.image_alpha,
                1,
                0.08
            );
    }

    if (instance_exists(roger))
    {
        if (
            abs(roger.x - objetivo_roger) < 2
        )
        {
            roger.x =
                objetivo_roger;

            roger.image_alpha = 1;

            tiempo_espera_solo = 0;

            estado =
                "pausa_room8_decision4";
        }
    }
}

// ============================================================
// ROOM 8
// PAUSA ANTES DEL DIALOGO SOLO
// ============================================================

if (
    room == Room8 &&
    estado == "pausa_room8_decision4"
)
{
    tiempo_espera_solo += 1;

    if (
        tiempo_espera_solo >=
        game_get_speed(gamespeed_fps) * 0.75
    )
    {
        linea_dialogo = 0;

        dialogo_activo = true;

        global.iniciar_dialogo = true;

        estado =
            "dialogo_decision4_solo";
    }
}

// ============================================================
// ROOM 8
// ANIMACION SOLO DECISION 4
// ============================================================

if (
    room == Room8 &&
    estado == "dialogo_decision4_solo"
)
{
    if (instance_exists(roger))
    {
        roger.image_xscale =
            lerp(
                roger.image_xscale,
                escala_hablando,
                0.12
            );

        roger.image_yscale =
            lerp(
                roger.image_yscale,
                escala_hablando,
                0.12
            );
    }
}

// ============================================================
// ROOM 8
// FIN DIALOGO SOLO
// ============================================================

if (
    room == Room8 &&
    estado == "dialogo_decision4_solo"
)
{
    if (espacio_dialogo_presionado && !bloquear_avance_dialogo)
    {
        linea_dialogo += 1;

        if (
            linea_dialogo >=
            cantidad_decision4_solo
        )
        {
            dialogo_activo = false;

            global.iniciar_dialogo = false;

            estado =
                "volver_room2_final";

            room_goto(Room2);
        }
    }
}

// ============================================================
// VOLVER ROOM 2 PARA FINAL
// ============================================================

if (
    room == Room2 &&
    estado == "volver_room2_final"
)
{
    estado =
        "decision4_terminada";
}

// ============================================================
// CALCULAR FINAL
// ============================================================

if (
    room == Room2 &&
    estado == "decision4_terminada"
)
{
    global.etapa_historia = 10;

    global.decision_pendiente = false;

    global.decision_actual = 0;

    puntaje_final = 0;

    // ========================================================
    // ACCIONES POSITIVAS
    // ========================================================

    if (global.guardo_pruebas)
    {
        puntaje_final += 2;
    }

    if (global.bloqueo_agresores)
    {
        puntaje_final += 2;
    }

    if (global.conto_amigo)
    {
        puntaje_final += 1;
    }

    if (global.hablo_profesor)
    {
        puntaje_final += 2;
    }

    if (global.hablo_familia)
    {
        puntaje_final += 2;
    }

    if (global.aprendio_seguridad)
    {
        puntaje_final += 2;
    }

    // ========================================================
    // DECISIONES QUE COMPLICARON
    // ========================================================

    if (global.respondio)
    {
        puntaje_final -= 1;
    }

    if (global.ignoro)
    {
        puntaje_final -= 1;
    }

    if (global.oculto_problema)
    {
        puntaje_final -= 2;
    }

    if (global.sigue_solo)
    {
        puntaje_final -= 2;
    }

    // ========================================================
    // BIENESTAR
    // ========================================================

    if (global.bienestar >= 70)
    {
        puntaje_final += 2;
    }

    else if (global.bienestar >= 40)
    {
        puntaje_final += 1;
    }

    else
    {
        puntaje_final -= 1;
    }

    // ========================================================
    // APOYO
    // ========================================================

    if (global.apoyo >= 60)
    {
        puntaje_final += 2;
    }

    else if (global.apoyo >= 30)
    {
        puntaje_final += 1;
    }

    else
    {
        puntaje_final -= 1;
    }

    // ========================================================
    // ACOSO
    // ========================================================

    if (global.acoso <= 25)
    {
        puntaje_final += 2;
    }

    else if (global.acoso <= 55)
    {
        puntaje_final += 1;
    }

    else
    {
        puntaje_final -= 1;
    }

    // ========================================================
    // ELEGIR FINAL
    // ========================================================

    if (puntaje_final >= 8)
    {
        global.final_juego = 1;

        estado =
            "final_apoyo";
    }

    else if (puntaje_final >= 3)
    {
        global.final_juego = 2;

        estado =
            "final_proceso";
    }

    else
    {
        global.final_juego = 3;

        estado =
            "final_mas_apoyo";
    }

    // ========================================================
    // ELIMINAR CELULAR
    // ========================================================

    if (instance_exists(obj_celu))
    {
        with (obj_celu)
        {
            instance_destroy();
        }
    }

    // ========================================================
    // IR AL ROOM DE RESULTADOS
    // ========================================================

    room_goto(Room7);
}

// ============================================================
// ROOM 7
// FINAL
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
    dialogo_activo = false;

    global.iniciar_dialogo = false;

    global.decision_pendiente = false;
}

// ============================================================
// REINICIAR
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
    if (keyboard_check_pressed(ord("R")))
    {
        global.etapa_historia = 1;

        global.decision_pendiente = false;

        global.decision_actual = 0;

        global.decision1 = 0;

        global.decision2 = 0;

        global.decision3 = 0;

        global.decision4 = 0;

        global.bienestar = 100;

        global.apoyo = 20;

        global.acoso = 0;

        global.guardo_pruebas = false;

        global.bloqueo_agresores = false;

        global.respondio = false;

        global.ignoro = false;

        global.conto_amigo = false;

        global.oculto_problema = false;

        global.se_aislo = false;

        global.hablo_profesor = false;

        global.hablo_familia = false;

        global.sigue_solo = false;

        global.aprendio_seguridad = false;

        global.apoyo_amigo = false;

        global.apoyo_amiga = false;

        global.profesor_preocupado = false;

        global.publicacion_aparecio = false;

        global.segundo_incidente = false;

        global.aparece_psicologa = false;

        global.final_juego = 0;

        global.iniciar_dialogo = false;

        instance_destroy();

        room_goto(Room1);
    }
}