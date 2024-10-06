/// @description Insert description here
// You can write your code in this editor

if event_data[? "event_type"] == "sprite event" // or you can check "sprite event"
{
    switch (event_data[? "message"])
    {
        case "Step":
            audio_play_sound(footstep_sounds[number], 10, false);
			if (number == 0) number = 1;
			else number = 0;
        break;
		
		case "Respira":
			if (is_flying) part_particles_burst(ps, x, y, WaterBubbles);
		break;

        case "destroy":
            sequence_destroy(event_data[? "element_id"]);
        break;
    }
}