// ============================================================================
// OBJ_AUDIO_GLOBAL
// EVENTO CREATE COMPLETO
// ============================================================================

if (instance_number(obj_audio_global) > 1)
{
    instance_destroy();
    exit;
}

persistent = true;
depth = -1000000;

musica_id = -1;
ultima_decision_pendiente = false;

if (asset_get_index("snd_musica_fondo") != -1)
{
    musica_id = audio_play_sound(snd_musica_fondo, -50, true);
    audio_sound_gain(musica_id, 0.30, 0);
}
