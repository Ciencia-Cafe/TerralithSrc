// Create Event

amplitude = 5;   // A amplitude da flutuação (o quanto ele se move para cima e para baixo)
speed = 0.005;    // A velocidade da flutuação
start_y = y;     // Salva a posição inicial do item no eixo Y
start_x = x;     // Salva a posição inicial do item no eixo X

audio_play_sound_at(wind, x, y, 0, 1.0, 1.0, 1.0, true, 0);