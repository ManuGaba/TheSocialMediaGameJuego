// ============================================================================
// OBJ_AUDIO_GLOBAL
// EVENTO STEP COMPLETO
// ============================================================================

// Mantener una unica musica de fondo activa durante todo el juego.
if (asset_get_index("snd_musica_fondo") != -1)
{
    if (musica_id == -1 || !audio_is_playing(musica_id))
    {
        musica_id = audio_play_sound(snd_musica_fondo, -50, true);
        audio_sound_gain(musica_id, 0.30, 0);
    }
}
