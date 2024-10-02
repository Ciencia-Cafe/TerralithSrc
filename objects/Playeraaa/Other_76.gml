/// @description Insert description here
// You can write your code in this editor

number = irandom_range(0, 1);

if event_data[? "event_type"] == "sprite event" // or you can check "sprite event"
{
    switch (event_data[? "message"])
    {
        case "Step":
            audio_play_sound(footstep_sounds[number], 10, false);
        break;

        case "destroy":
            sequence_destroy(event_data[? "element_id"]);
        break;
    }
}