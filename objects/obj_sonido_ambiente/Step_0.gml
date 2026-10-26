// ============================================================================
// OBJ_SONIDO_AMBIENTE
// EVENTO STEP COMPLETO
// ============================================================================

var en_menu = (room == Room14 || room == Room17 || room == Room18 || room == Room19);
var hay_controlador = instance_exists(Obj_controlador_dialogo);
var hay_celu = instance_exists(obj_celu);

// Estado de la historia (solo lectura)
var bienestar = 100;
var acoso = 0;

if (variable_global_exists("bienestar"))
{
    bienestar = global.bienestar;
}

if (variable_global_exists("acoso"))
{
    acoso = global.acoso;
}

// ============================================================================
// MUSICA DE ESCENA
// calma: inicio de la historia / tension: despues del acoso / final: resultados
// ============================================================================

var modo_objetivo = "";

if (!en_menu)
{
    if (room == Room7)
    {
        modo_objetivo = "final";
    }
    else if (acoso >= 15 && bienestar < 60)
    {
        modo_objetivo = "tension";
    }
    else
    {
        modo_objetivo = "calma";
    }
}

if (modo_objetivo != musica_modo)
{
    // La musica anterior se apaga con un fundido
    if (musica_saliente != -1)
    {
        audio_stop_sound(musica_saliente);
        musica_saliente = -1;
    }

    if (musica_id != -1)
    {
        audio_sound_gain(musica_id, 0, 1200);
        musica_saliente = musica_id;
        tiempo_saliente = 75;
        musica_id = -1;
    }

    if (modo_objetivo == "calma")
    {
        musica_id = audio_play_sound(snd_musica_escuela, 6, true);
        audio_sound_gain(musica_id, 0, 0);
        audio_sound_gain(musica_id, 0.40, 1500);
    }
    else if (modo_objetivo == "tension")
    {
        musica_id = audio_play_sound(snd_musica_tension, 6, true);
        audio_sound_gain(musica_id, 0, 0);
        audio_sound_gain(musica_id, 0.35, 1500);
    }

    musica_modo = modo_objetivo;
}

if (musica_saliente != -1)
{
    tiempo_saliente -= 1;

    if (tiempo_saliente <= 0)
    {
        audio_stop_sound(musica_saliente);
        musica_saliente = -1;
    }
}

// La musica original se baja durante la partida y vuelve en los menus
if (instance_exists(obj_audio_global))
{
    if (variable_instance_exists(obj_audio_global, "musica_id") && obj_audio_global.musica_id != -1)
    {
        if (!en_menu && !musica_vieja_bajada)
        {
            audio_sound_gain(obj_audio_global.musica_id, 0, 1500);
            musica_vieja_bajada = true;
        }
        else if (en_menu && musica_vieja_bajada)
        {
            audio_sound_gain(obj_audio_global.musica_id, 0.30, 1000);
            musica_vieja_bajada = false;
        }
    }
}

// ============================================================================
// FINAL (un sonido distinto para cada final)
// ============================================================================

if (modo_objetivo == "final")
{
    if (!final_sonado && variable_global_exists("final_juego"))
    {
        var sonido_final = -1;

        if (global.final_juego == 1)
        {
            sonido_final = snd_final_apoyo;
        }
        else if (global.final_juego == 2)
        {
            sonido_final = snd_final_proceso;
        }
        else if (global.final_juego == 3)
        {
            sonido_final = snd_final_ayuda;
        }

        if (sonido_final != -1)
        {
            var id_final = audio_play_sound(sonido_final, 8, false);
            audio_sound_gain(id_final, 0.60, 0);
            final_sonado = true;
        }
    }
}
else
{
    final_sonado = false;
}

// ============================================================================
// AMBIENTE DE ESCUELA (murmullo lejano)
// ============================================================================

var en_escuela = (room == Room2 || room == Room3 || room == Room4);

if (murmullo_id != -1 && !audio_is_playing(murmullo_id))
{
    murmullo_id = -1;
}

if (en_escuela && murmullo_id == -1)
{
    murmullo_id = audio_play_sound(snd_murmullo, 2, true);
    audio_sound_gain(murmullo_id, 0, 0);
    audio_sound_gain(murmullo_id, 0.10, 2000);
}
else if (!en_escuela && murmullo_id != -1)
{
    audio_stop_sound(murmullo_id);
    murmullo_id = -1;
}

// ============================================================================
// ZUMBIDO DE TENSION (cuando el bienestar esta muy bajo)
// ============================================================================

var tension_alta = (!en_menu && room != Room7 && bienestar <= 40);

if (zumbido_id != -1 && !audio_is_playing(zumbido_id))
{
    zumbido_id = -1;
}

if (tension_alta && zumbido_id == -1)
{
    zumbido_id = audio_play_sound(snd_tension_zumbido, 3, true);
    audio_sound_gain(zumbido_id, 0, 0);
    audio_sound_gain(zumbido_id, 0.22, 2500);
}
else if (!tension_alta && zumbido_id != -1)
{
    audio_stop_sound(zumbido_id);
    zumbido_id = -1;
}

// ============================================================================
// PASOS Y TIMBRE (segun el estado del controlador)
// ============================================================================

if (hay_controlador && variable_instance_exists(Obj_controlador_dialogo, "estado"))
{
    var estado_actual = Obj_controlador_dialogo.estado;

    // Timbre al comenzar el dia y al comenzar la clase
    if (estado_actual != estado_anterior)
    {
        if (estado_actual == "entrada_amigos" || estado_actual == "entrada_profesor")
        {
            var id_timbre = audio_play_sound(snd_timbre_escuela, 5, false);
            audio_sound_gain(id_timbre, 0.45, 0);
        }

        estado_anterior = estado_actual;
    }

    // Pasos mientras los personajes entran a escena
    if (string_pos("entrada", estado_actual) == 1)
    {
        tiempo_pasos -= 1;

        if (tiempo_pasos <= 0)
        {
            var id_paso = audio_play_sound(snd_pasos, 4, false);
            audio_sound_gain(id_paso, 0.50, 0);
            audio_sound_pitch(id_paso, random_range(0.9, 1.1));
            tiempo_pasos = 22;
        }
    }
    else
    {
        tiempo_pasos = 0;
    }
}

// ============================================================================
// CELULAR (abrir, cerrar, mensajes enviados)
// ============================================================================

if (hay_celu)
{
    if (variable_instance_exists(obj_celu, "celular_abierto"))
    {
        var abierto = obj_celu.celular_abierto;

        if (abierto && !celular_abierto_anterior)
        {
            var id_abrir = audio_play_sound(snd_celu_abrir, 7, false);
            audio_sound_gain(id_abrir, 0.45, 0);
        }
        else if (!abierto && celular_abierto_anterior)
        {
            var id_cerrar = audio_play_sound(snd_celu_cerrar, 7, false);
            audio_sound_gain(id_cerrar, 0.45, 0);
        }

        celular_abierto_anterior = abierto;
    }

    var chatamix_enviado = false;
    var televuelo_enviado = false;

    if (variable_instance_exists(obj_celu, "mensaje_chatamix_enviado"))
    {
        chatamix_enviado = obj_celu.mensaje_chatamix_enviado;
    }

    if (variable_instance_exists(obj_celu, "mensaje_televuelo_enviado"))
    {
        televuelo_enviado = obj_celu.mensaje_televuelo_enviado;
    }

    if ((chatamix_enviado && !chatamix_enviado_anterior) || (televuelo_enviado && !televuelo_enviado_anterior))
    {
        var id_enviado = audio_play_sound(snd_mensaje_enviado, 7, false);
        audio_sound_gain(id_enviado, 0.50, 0);
    }

    chatamix_enviado_anterior = chatamix_enviado;
    televuelo_enviado_anterior = televuelo_enviado;
}
else
{
    celular_abierto_anterior = false;
    chatamix_enviado_anterior = false;
    televuelo_enviado_anterior = false;
}

// Vibracion junto con el sonido de notificacion que ya existe
var notificacion_sonando = audio_is_playing(snd_notificacion);

if (notificacion_sonando && !notificacion_anterior)
{
    var id_vibracion = audio_play_sound(snd_vibracion, 7, false);
    audio_sound_gain(id_vibracion, 0.35, 0);
}

notificacion_anterior = notificacion_sonando;
