// ============================================================================
// OBJ_SONIDO_AMBIENTE
// EVENTO CREATE COMPLETO
// Agrega musica de escena, ambiente y efectos nuevos.
// Solo LEE el estado del juego: no modifica ningun objeto existente.
// ============================================================================

if (instance_number(obj_sonido_ambiente) > 1)
{
    instance_destroy();
    exit;
}

persistent = true;

// Musica de escena
musica_modo = "";
musica_id = -1;
musica_saliente = -1;
tiempo_saliente = 0;
musica_vieja_bajada = false;

// Ambiente
murmullo_id = -1;
zumbido_id = -1;

// Valores anteriores (para detectar cambios)
estado_anterior = "";
celular_abierto_anterior = false;
chatamix_enviado_anterior = false;
televuelo_enviado_anterior = false;
notificacion_anterior = false;

// Pasos y final
tiempo_pasos = 0;
final_sonado = false;
