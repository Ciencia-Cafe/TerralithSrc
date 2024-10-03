// Step Event
y = start_y + sin(current_time * speed) * amplitude;
x = start_x + sin(current_time * speed * 0.5) * amplitude;

//

// Step Event do NPC

// Atualizar o contador de disparos
contador_disparos += 1;

// Verificar se é hora de disparar
if (contador_disparos >= tempo_entre_disparos) {

    // Resetar o contador
    contador_disparos = 0;

    // Verificar se o Playeraaa existe no jogo
    if (instance_exists(Playeraaa) && distance_to_object(Playeraaa) < 200.0) {

        // Calcular a direção para o Playeraaa
        var dx = Playeraaa.x - x;  // Diferença na posição X
        var dy = Playeraaa.y - y;  // Diferença na posição Y
        var direcao = point_direction(x, y, Playeraaa.x, Playeraaa.y);  // Direção em graus

        // Criar o obj_ovo na posição do NPC
        var ovo = instance_create_layer(x, y, layer, obj_ovo);

        // Definir a velocidade do ovo na direção do Playeraaa
        ovo.direction = direcao;  // Define a direção do ovo para o Playeraaa
        ovo.speed = velocidade_ovo;  // Define a velocidade do ovo
    }
}