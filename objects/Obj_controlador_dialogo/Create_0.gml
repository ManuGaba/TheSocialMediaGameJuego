if (instance_number(Obj_controlador_dialogo) > 1) { instance_destroy(); exit; }
// ============================================================
// OBJ_CONTROLADOR_DIALOGO
// EVENTO CREAR COMPLETO
// ============================================================

persistent = true;

// ============================================================
// ESTADO GENERAL
// ============================================================

estado = "inicio";

dialogo_activo = false;

linea_dialogo = 0;

tiempo_carga = 0;

puntaje_final = 0;

// ============================================================
// TEXTO PROGRESIVO + SONIDO DE TECLEADO
// ============================================================

caracteres_visibles = 0;
contador_tecleo = 0;
intervalo_tecleo = max(1, round(game_get_speed(gamespeed_fps) * 0.025));
linea_tecleo_anterior = -1;
estado_tecleo_anterior = "";
texto_actual_dialogo = "";
texto_dialogo_completo = false;

// ============================================================
// REFERENCIAS
// ============================================================

roger = noone;

amigo = noone;

amiga = noone;

profesor = noone;

companiero1 = noone;

companiero2 = noone;

psicologa = noone;

madre = noone;

padre = noone;

celu = noone;

// ============================================================
// ROOM 1
// ============================================================

texto_roger = [
    "Roger: Esta es mi nueva escuela.",
    "Roger: No conozco a mucha gente por aqui.",
    "Roger: Espero tener una vida simple, sencilla y sin problemas."
];

cantidad_roger =
    array_length(texto_roger);

// ============================================================
// ROOM 2
// AMIGOS
// ============================================================

texto_amigos = [
    "Amigo: Hola, Roger. ¿Como te estas adaptando?",
    "Roger: Bien, aunque todavia no conozco a mucha gente.",
    "Amiga: Si necesitas ayuda, podes contar con nosotros.",
    "Amigo: Hay algo importante que queremos contarte.",
    "Roger: ¿Que cosa?",
    "Amiga: El ciberbullying es un problema que puede ocurrir en internet.",
    "Amigo: Puede suceder mediante mensajes, redes sociales o videojuegos.",
    "Roger: Entiendo. Es importante tratar bien a los demas.",
    "Amiga: Exacto. Y si algo te preocupa, podes pedir ayuda."
];

cantidad_amigos =
    array_length(texto_amigos);

// ============================================================
// ROOM 3
// PROFESOR
// ============================================================

texto_profesor = [
    "Profesor: Buenos dias, Roger. Bienvenido a la clase.",
    "Roger: Buenos dias, profesor.",
    "Profesor: Hoy vamos a hablar sobre la convivencia y el respeto.",
    "Roger: ¿Tambien vamos a hablar sobre lo que pasa en internet?",
    "Profesor: Si. El ciberbullying puede afectar a las personas de muchas maneras.",
    "Roger: ¿Y que podemos hacer si alguien pasa por eso?",
    "Profesor: Lo importante es pedir ayuda a un adulto de confianza.",
    "Roger: Entiendo, profesor. Gracias por explicarlo."
];

cantidad_profesor =
    array_length(texto_profesor);

// ============================================================
// DECISION 1
// ENTRAR
// ============================================================

texto_decision1_entrar = [
    "Roger: Mejor entro a clases.",
    "Roger: No quiero atrasarme."
];

cantidad_decision1_entrar =
    array_length(texto_decision1_entrar);

// ============================================================
// DECISION 1
// CELULAR
// ============================================================

texto_decision1_celular = [
    "Roger: Voy a mirar el celular un momento.",
    "Roger: Espero no perderme nada importante."
];

cantidad_decision1_celular =
    array_length(texto_decision1_celular);

// ============================================================
// DECISION 1
// NO ENTRAR
// ============================================================

texto_decision1_no_entrar = [
    "Roger: No tengo muchas ganas de entrar ahora.",
    "Roger: Voy a quedarme afuera un rato."
];

cantidad_decision1_no_entrar =
    array_length(texto_decision1_no_entrar);

// ============================================================
// PRIMER INCIDENTE
// ENTRAR
// ============================================================

texto_incidente_entrar = [
    "Amigo: Roger... tenes que ver esto.",
    "Roger: ¿Que paso?",
    "Amiga: Alguien publico una foto tuya en una red social.",
    "Roger: ¿Una foto mia?",
    "Amigo: Si. Y algunas personas empezaron a compartirla.",
    "Roger: Yo nunca di permiso para publicar eso.",
    "Roger: No entiendo por que estan haciendo esto."
];

cantidad_incidente_entrar =
    array_length(texto_incidente_entrar);

// ============================================================
// PRIMER INCIDENTE
// CELULAR
// ============================================================

texto_incidente_celular = [
    "Roger: ¿Que es esta notificacion?",
    "Roger: Espera... esa foto soy yo.",
    "Roger: ¿Quien publico esto?",
    "Roger: Ya hay personas comentando y compartiendola.",
    "Roger: Yo nunca di permiso para subir esa foto.",
    "Roger: Esto no me gusta nada."
];

cantidad_incidente_celular =
    array_length(texto_incidente_celular);

// ============================================================
// PRIMER INCIDENTE
// NO ENTRAR
// ============================================================

texto_incidente_no_entrar = [
    "Roger: Me llego una notificacion.",
    "Roger: ¿Que es esto?",
    "Roger: Esa es una foto mia.",
    "Roger: Alguien la publico sin preguntarme.",
    "Roger: Ya la estan compartiendo.",
    "Roger: Tal vez no fue buena idea quedarme solo afuera."
];

cantidad_incidente_no_entrar =
    array_length(texto_incidente_no_entrar);

// ============================================================
// DECISION 2
// RESPONDER
// ============================================================

texto_decision2_responder = [
    "Roger: No me voy a quedar callado.",
    "Roger: Voy a responder a esta publicacion.",
    "Roger: Esto solo esta haciendo que haya mas comentarios."
];

cantidad_decision2_responder =
    array_length(texto_decision2_responder);

// ============================================================
// DECISION 2
// GUARDAR PRUEBAS
// ============================================================

texto_decision2_guardar = [
    "Roger: Mejor guardo capturas de lo que esta pasando.",
    "Roger: Voy a bloquear a estas cuentas.",
    "Roger: Si esto continua, puedo mostrar las pruebas a un adulto."
];

cantidad_decision2_guardar =
    array_length(texto_decision2_guardar);

// ============================================================
// DECISION 2
// IGNORAR
// ============================================================

texto_decision2_ignorar = [
    "Roger: Tal vez si no hago nada, se olviden de esto.",
    "Roger: Voy a intentar ignorarlo.",
    "Roger: Pero la publicacion sigue circulando."
];

cantidad_decision2_ignorar =
    array_length(texto_decision2_ignorar);

// ============================================================
// SEGUNDO INCIDENTE
// RESPONDER
// ============================================================

texto_segundo_incidente_responder = [
    "Roger: Me siguen llegando notificaciones.",
    "Amigo: Parece que responder hizo que mas personas se sumaran.",
    "Roger: Esto se esta saliendo de control.",
    "Amiga: No tenes que enfrentarlo solo."
];

cantidad_segundo_incidente_responder =
    array_length(texto_segundo_incidente_responder);

// ============================================================
// SEGUNDO INCIDENTE
// GUARDAR
// ============================================================

texto_segundo_incidente_guardar = [
    "Roger: Aparecio otra cuenta compartiendo la foto.",
    "Roger: Por suerte guarde las capturas anteriores.",
    "Amigo: Eso puede servir para mostrar lo que esta pasando.",
    "Amiga: Tambien podemos ayudarte a hablar con alguien."
];

cantidad_segundo_incidente_guardar =
    array_length(texto_segundo_incidente_guardar);

// ============================================================
// SEGUNDO INCIDENTE
// IGNORAR
// ============================================================

texto_segundo_incidente_ignorar = [
    "Roger: Pense que si lo ignoraba iba a parar.",
    "Roger: Pero siguen compartiendo la foto.",
    "Amigo: No parece que vaya a desaparecer solo.",
    "Amiga: Podemos ayudarte si queres."
];

cantidad_segundo_incidente_ignorar =
    array_length(texto_segundo_incidente_ignorar);

// ============================================================
// DECISION 3
// AMIGO
// ============================================================

texto_decision3_amigo = [
    "Roger: Creo que necesito contarle a alguien lo que esta pasando.",
    "Roger: ¿Puedo hablar con ustedes?",
    "Amigo: Claro. No tenes que manejar esto solo.",
    "Amiga: Podemos acompañarte y buscar ayuda juntos.",
    "Roger: Gracias. Me siento un poco mas tranquilo."
];

cantidad_decision3_amigo =
    array_length(texto_decision3_amigo);

// ============================================================
// DECISION 3
// PROFESOR
// ============================================================

texto_decision3_profesor = [
    "Roger: Profesor, necesito contarle algo.",
    "Profesor: Claro, Roger. ¿Que esta pasando?",
    "Roger: Publicaron una foto mia y siguen compartiendola.",
    "Profesor: Hiciste bien en venir a hablar conmigo.",
    "Profesor: Vamos a buscar una forma de ayudarte y detener la situacion.",
    "Roger: Gracias, profesor."
];

cantidad_decision3_profesor =
    array_length(texto_decision3_profesor);

// ============================================================
// DECISION 3
// OCULTAR
// ============================================================

texto_decision3_ocultar = [
    "Roger: Mejor no digo nada.",
    "Roger: No quiero preocupar a nadie.",
    "Roger: Voy a intentar resolverlo solo.",
    "Roger: Pero cada vez me cuesta mas ignorar lo que esta pasando."
];

cantidad_decision3_ocultar =
    array_length(texto_decision3_ocultar);

// ============================================================
// DECISION 4
// FAMILIA
// ============================================================

texto_decision4_familia = [
    "Roger: Creo que tambien deberia hablar con mi familia.",
    "Madre: Gracias por contarnos lo que esta pasando.",
    "Padre: Vamos a ayudarte. No tenes que resolver esto solo.",
    "Roger: Me preocupaba contarles, pero creo que fue lo correcto.",
    "Madre: Lo importante es que podamos acompañarte."
];

cantidad_decision4_familia =
    array_length(texto_decision4_familia);

// ============================================================
// DECISION 4
// PSICOLOGA
// ============================================================

texto_decision4_psicologa = [
    "Roger: Quiero hablar con alguien que pueda orientarme.",
    "Psicologa: Hiciste bien en pedir ayuda.",
    "Roger: No sabia bien que hacer con todo esto.",
    "Psicologa: Podemos trabajar juntos para que te sientas acompañado.",
    "Psicologa: Tambien es importante guardar pruebas, bloquear y pedir ayuda.",
    "Roger: Ahora entiendo mejor como actuar."
];

cantidad_decision4_psicologa =
    array_length(texto_decision4_psicologa);

// ============================================================
// DECISION 4
// SOLO
// ============================================================

texto_decision4_solo = [
    "Roger: Voy a seguir tratando de manejar esto solo.",
    "Roger: No quiero hablar con nadie mas.",
    "Roger: Pero las notificaciones siguen apareciendo.",
    "Roger: Esto cada vez se siente mas dificil."
];

cantidad_decision4_solo =
    array_length(texto_decision4_solo);

// ============================================================
// CONTROL
// ============================================================

global.iniciar_dialogo = false;

entrada_terminada = false;

escala_normal = 1.15;

escala_hablando = 1.22;

objetivo_roger = 0;

objetivo_amigo = 0;

objetivo_amiga = 0;

objetivo_profesor = 0;

// ============================================================
// PROGRESO
// ============================================================

if (!variable_global_exists("etapa_historia"))
{
    global.etapa_historia = 1;
}

// ============================================================
// DECISIONES
// ============================================================

if (!variable_global_exists("decision_pendiente"))
{
    global.decision_pendiente = false;
}

if (!variable_global_exists("decision_actual"))
{
    global.decision_actual = 0;
}

if (!variable_global_exists("decision1"))
{
    global.decision1 = 0;
}

if (!variable_global_exists("decision2"))
{
    global.decision2 = 0;
}

if (!variable_global_exists("decision3"))
{
    global.decision3 = 0;
}

if (!variable_global_exists("decision4"))
{
    global.decision4 = 0;
}

// ============================================================
// ESTADO
// ============================================================

if (!variable_global_exists("bienestar"))
{
    global.bienestar = 100;
}

if (!variable_global_exists("apoyo"))
{
    global.apoyo = 20;
}

if (!variable_global_exists("acoso"))
{
    global.acoso = 0;
}

// ============================================================
// ACCIONES
// ============================================================

if (!variable_global_exists("guardo_pruebas"))
{
    global.guardo_pruebas = false;
}

if (!variable_global_exists("bloqueo_agresores"))
{
    global.bloqueo_agresores = false;
}

if (!variable_global_exists("respondio"))
{
    global.respondio = false;
}

if (!variable_global_exists("ignoro"))
{
    global.ignoro = false;
}

if (!variable_global_exists("conto_amigo"))
{
    global.conto_amigo = false;
}

if (!variable_global_exists("oculto_problema"))
{
    global.oculto_problema = false;
}

if (!variable_global_exists("se_aislo"))
{
    global.se_aislo = false;
}

if (!variable_global_exists("hablo_profesor"))
{
    global.hablo_profesor = false;
}

if (!variable_global_exists("hablo_familia"))
{
    global.hablo_familia = false;
}

if (!variable_global_exists("sigue_solo"))
{
    global.sigue_solo = false;
}

if (!variable_global_exists("aprendio_seguridad"))
{
    global.aprendio_seguridad = false;
}

// ============================================================
// APOYO
// ============================================================

if (!variable_global_exists("apoyo_amigo"))
{
    global.apoyo_amigo = false;
}

if (!variable_global_exists("apoyo_amiga"))
{
    global.apoyo_amiga = false;
}

if (!variable_global_exists("profesor_preocupado"))
{
    global.profesor_preocupado = false;
}

// ============================================================
// CONFLICTO
// ============================================================

if (!variable_global_exists("publicacion_aparecio"))
{
    global.publicacion_aparecio = false;
}

if (!variable_global_exists("segundo_incidente"))
{
    global.segundo_incidente = false;
}

if (!variable_global_exists("aparece_psicologa"))
{
    global.aparece_psicologa = false;
}

// ============================================================
// FINAL
// ============================================================

if (!variable_global_exists("final_juego"))
{
    global.final_juego = 0;
}

// ============================================================
// VIEJAS
// ============================================================

opcion = 0;

cantidad_opciones = 3;

mostrar_opciones = false;