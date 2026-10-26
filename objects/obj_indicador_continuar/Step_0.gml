// ============================================================================
// OBJ_INDICADOR_CONTINUAR
// EVENTO STEP COMPLETO
// ============================================================================

mostrar_indicador = false;

if (instance_exists(Obj_controlador_dialogo))
{
    if (
        Obj_controlador_dialogo.dialogo_activo &&
        Obj_controlador_dialogo.texto_dialogo_completo
    )
    {
        mostrar_indicador = true;
    }
}

if (room == Room7)
{
    mostrar_indicador = false;
}

if (mostrar_indicador)
{
    tiempo_animacion += 1;

    alpha_indicador = lerp(alpha_indicador, 1, 0.15);
    escala_indicador = 1 + sin(current_time / 180) * 0.035;

    if (alpha_indicador > 0.98)
    {
        alpha_indicador = 1;
    }
}
else
{
    alpha_indicador = lerp(alpha_indicador, 0, 0.18);

    if (alpha_indicador < 0.02)
    {
        alpha_indicador = 0;
    }
}
