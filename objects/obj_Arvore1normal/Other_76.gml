
if event_data[? "event_type"] == "sprite event" // or you can check "sprite event"
{
    switch (event_data[? "message"])
    {
		case "AxeAttack":
			sprite_index = ArvoreBasicaToco_spr;
		break;

        case "destroy":
            sequence_destroy(event_data[? "element_id"]);
        break;
    }
}