/// @description Insert description here
// You can write your code in this editor

if event_data[? "event_type"] == "sprite event" // or you can check "sprite event"
{
    switch (event_data[? "message"])
    {
        case "Step":
			audio_sound_pitch(footstep_sounds[number], random_range(0.75, 1.25));
            audio_play_sound(footstep_sounds[number], 10, false);
			if (number == 0) number = 1;
			else number = 0;
        break;
		
		case "Respira":
			if (is_under_water) part_particles_burst(ps, x, y, WaterBubbles);
		break;
		
		case "Nadando":
			audio_sound_pitch(Dirt_Jump, random_range(0.75, 1.25));
            audio_play_sound(nadando_sounds[number], 10, false);
			if (number == 0) number = 1;
			else number = 0;
		break;
		
		case "Attack":
			sprite_index = floor_sprites[4];
		break;
		
		case "StopAttack":
			is_attacking = false;
		break;

        case "destroy":
            sequence_destroy(event_data[? "element_id"]);
        break;
    }
}