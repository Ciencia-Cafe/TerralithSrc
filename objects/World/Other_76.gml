if event_data[? "event_type"] == "sprite event"
{
    switch (event_data[? "message"])
    {
		case "AxeAttack":
			if (distance_to_object(obj_Player) < 10.0) {
				damage();
			}
		break;
    }
}