/// @description Insert description here
// You can write your code in this editor

if event_data[? "event_type"] == "sprite event" // or you can check "sprite event"
{
    switch (event_data[? "message"])
    {
		case "Dano":
			if (distance_to_object(obj_Player) < 10.0) {
				damage();
			}
		break;
		
		case "EsqMorre":
			instance_destroy(self);
		break;
		
		case "EsqEscape":
			taking_damage = false;
		break;

        case "destroy":
            sequence_destroy(event_data[? "element_id"]);
        break;
    }
}