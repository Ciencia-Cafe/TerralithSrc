// Step Event do obj_EsqueletoEs1

// Reduz o cooldown a cada frame, até o mínimo de 0
if (cooldown_arremesso > 0) {
    cooldown_arremesso -= 1;
}

// Calcula a distância entre o esqueleto e o player
var distancia_para_player = point_distance(x, y, obj_Player.x, obj_Player.y);

// Se o player estiver dentro do alcance e o cooldown permitir, inicia o ataque
if (distancia_para_player <= distancia_ataque && cooldown_arremesso == 0 && !estado_atacando) {
    sprite_index = Esqueleto1Attack_spr;  // Muda para a animação de ataque
    estado_atacando = true;               // Define o estado de ataque
    image_index = 0;                      // Reinicia a animação de ataque
}
// Continua no Step Event do obj_EsqueletoEs1

// Verifica se o esqueleto está atacando e se a animação terminou
if (estado_atacando && image_index >= image_number - 1) {
    // Arremessa o osso em direção ao player
    var osso = instance_create_layer(x, y, "Instances", obj_OssoEsqueleto);  // Certifique-se de que o objeto do osso existe e está nomeado corretamente
    osso.direction = point_direction(x, y, obj_Player.x, obj_Player.y);
    osso.speed = 6;  // Define a velocidade do osso
    
    // Volta à animação de idle e inicia o cooldown
    sprite_index = Esqueleto1Idle_spr;
    estado_atacando = false;
    cooldown_arremesso = tempo_cooldown;  // Reseta o cooldown do arremesso
}
