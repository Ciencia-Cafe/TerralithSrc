// Create Event

amplitude = 1;   // A amplitude da flutuação (o quanto ele se move para cima e para baixo)
speed = 0.01;    // A velocidade da flutuação
start_y = y;     // Salva a posição inicial do item no eixo Y
start_x = x;     // Salva a posição inicial do item no eixo X

//

// Create Event do NPC
tempo_entre_disparos = 60;  // Tempo entre os disparos (60 frames = 1 segundo)
contador_disparos = 0;      // Contador para controlar os disparos
velocidade_ovo = 6;         // Velocidade do projétil (obj_ovo)