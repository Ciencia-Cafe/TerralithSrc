_cam_x = camera_get_view_x(view_camera[0]);
_cam_y = camera_get_view_y(view_camera[0]);

view_w = camera_get_view_width(view_camera[0]);
view_h = camera_get_view_height(view_camera[0]);

var current_selected = 0;

inv_y_offset = lerp(inv_y_offset, unlerped_inv_y_offset, 0.1);

var inv_x = (_cam_x + (view_w * 0.5) - 160) + 11;
var current_inv_y = _cam_y + (view_h * 0.75);
var inv_y = current_inv_y; // a

var bar_width = 32;
var bar_pos = _cam_x + (view_w * 0.1);

mouse_pos.x = window_mouse_get_delta_x();
mouse_pos.y = window_mouse_get_delta_y();

mouse_position.x = (floor(current_mouse_pos.x / 16) * 16) + 8;
mouse_position.y = (floor(current_mouse_pos.y / 16) * 16) + 8;

if (instance_exists(obj_Player)) {
	if (keyboard_check_pressed(ord("E"))) {
		current_mouse_pos.x = obj_Player.x;
		current_mouse_pos.y = obj_Player.y;
	}
	
	if (point_distance(current_mouse_pos.x + mouse_pos.x, current_mouse_pos.y + mouse_pos.y, obj_Player.x, obj_Player.y) < 100.0) {
		current_mouse_pos.x += mouse_pos.x;
		current_mouse_pos.y += mouse_pos.y;
	}
	else {
		draw_circle(obj_Player.x, obj_Player.y, 100, true);
	}
	
	current_mouse_pos.x += obj_Player.move_x;
	current_mouse_pos.y += obj_Player.move_y;
	
	draw_sprite_stretched(HealthBar, -100, bar_pos - 15, _cam_y + (view_h * 0.25) - 4, bar_width * (obj_Player.HEALTH_LEVEL / obj_Player.MAX_BAR_LEVEL), 8);
	draw_sprite(OuterBar, -101, bar_pos, _cam_y + (view_h * 0.25));

	draw_sprite_stretched(OxigenBar, -100, bar_pos - 15, _cam_y + (view_h * 0.25) - 4 + 32,  bar_width * (obj_Player.OXYGEN_LEVEL / obj_Player.MAX_BAR_LEVEL), 8);
	draw_sprite(OuterBar, -101, bar_pos, _cam_y + (view_h * 0.25) + 32);


	draw_sprite(Cursor, -100, mouse_position.x, mouse_position.y);
	draw_sprite(RealCursor, -101, current_mouse_pos.x, current_mouse_pos.y);
	draw_sprite(Gui_Inventario_spr, -100, _cam_x + ((view_w * 0.5) - 160), inv_y + inv_y_offset);
	draw_sprite(Gui_Selected, -101, inv_x + (50 * obj_Player.current_inv_index), inv_y + inv_y_offset);
	
	for (var i = 0; i < 6; i++) {
		var item_x = inv_x + (50 * i) + 24;
		var item_y = inv_y + 26 + inv_y_offset;
	
		if (obj_Player.player_inventory[i] == "Axe") {
			draw_sprite(Machado_spr, -102, item_x, item_y);
		}
		else if (obj_Player.player_inventory[i] == "Sword") {
			draw_sprite(Espada_spr, -102, item_x, item_y);
		}
		else if (obj_Player.player_inventory[i] == "Fork") {
			draw_sprite(Garfo_spr, -102, item_x, item_y);
		}
		else if (obj_Player.player_inventory[i] == "Shovel") {
			draw_sprite(Pa_spr, -102, item_x, item_y);
		}
		else if (obj_Player.player_inventory[i] == "Rod") {
			draw_sprite(Vara_spr, -102, item_x, item_y);
		}
	}
}

if (elapsed_time >= 3.0) {
	unlerped_inv_y_offset = 128;
	elapsed_time = 0;
}

elapsed_time += delta_time / 1000000;