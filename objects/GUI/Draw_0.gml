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
	player_oldpos.x = player_pos.x;
	player_oldpos.y = player_pos.y;
	player_pos.x = obj_Player.x;
	player_pos.y = obj_Player.y;
	
	player_vel = vector_subtract(player_pos, player_oldpos);
	
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
	
	current_mouse_pos.x += player_vel.x;
	current_mouse_pos.y += player_vel.y;
	
	draw_sprite_stretched(HealthBar, -100, bar_pos - 15, _cam_y + (view_h * 0.25) - 4, bar_width * (obj_Player.HEALTH_LEVEL / obj_Player.MAX_BAR_LEVEL), 8);
	draw_sprite(OuterBar, -101, bar_pos, _cam_y + (view_h * 0.25));

	draw_sprite_stretched(OxigenBar, -100, bar_pos - 15, _cam_y + (view_h * 0.25) - 4 + 32,  bar_width * (obj_Player.OXYGEN_LEVEL / obj_Player.MAX_BAR_LEVEL), 8);
	draw_sprite(OuterBar, -101, bar_pos, _cam_y + (view_h * 0.25) + 32);
	
	var middle_screen_x = _cam_x + (view_w * 0.5);
	var middle_screen_y = _cam_y + (view_h * 0.5);
	
	var inv_grid_size = 22;
	
	var inv_size_x = inv_grid_size * 6;
	var inv_size_y = inv_grid_size * 3;
	
	if (show_inventory) {
		current_cursor = Rato_spr;
		draw_sprite(InventoryBlueprint_spr, -101, (floor((middle_screen_x - (inv_size_x * 0.5)) / inv_grid_size) * inv_grid_size) + (inv_grid_size * 0.5), (floor((middle_screen_y - (inv_size_y * 0.5)) / inv_grid_size) * inv_grid_size) + (inv_grid_size * 0.5));
		//draw_rectangle_color((floor((middle_screen_x - (inv_size_x * 0.5)) / inv_grid_size) * inv_grid_size) + (inv_grid_size * 0.5), (floor((middle_screen_y - (inv_size_y * 0.5)) / inv_grid_size) * inv_grid_size) + (inv_grid_size * 0.5), (floor((middle_screen_x + (inv_size_x * 0.5)) / inv_grid_size) * inv_grid_size) + (inv_grid_size * 0.5), (floor((middle_screen_y + (inv_size_y * 0.5)) / inv_grid_size) * inv_grid_size) + (inv_grid_size * 0.5), c_black, c_black, c_black, c_black, false);
		
		var inventory = obj_Player.player_inventory;
		var inventory_sprites = get_inventory_sprites(inventory);
		
		for (var i = 0; i < 6; i++) {
			for (var j = 0; j < 3; j++) {
				var slot_pos = new vector(middle_screen_x - (inv_size_x * 0.5) + (i * inv_grid_size), middle_screen_y - (inv_size_y * 0.5) + (j * inv_grid_size));
				if (mouse_position.x == ((floor(slot_pos.x / inv_grid_size) * inv_grid_size) + (inv_grid_size * 0.5)) - i && mouse_position.y == ((floor(slot_pos.y / inv_grid_size) * inv_grid_size) + (inv_grid_size * 0.5)) - j) {
					draw_sprite(Selection, -102, ((floor(slot_pos.x / inv_grid_size) * inv_grid_size) + (inv_grid_size * 0.5)) - i, ((floor(slot_pos.y / inv_grid_size) * inv_grid_size) + (inv_grid_size * 0.5)) - j);
					if (mouse_clicked) {
						currently_selected = inventory_sprites[j][i];
						obj_Player.drop_item(i);
						
						mouse_clicked = false;
					}
				}
				else {
					draw_sprite(Selection_1, -102, ((floor(slot_pos.x / inv_grid_size) * inv_grid_size) + (inv_grid_size * 0.5)) - i, ((floor(slot_pos.y / inv_grid_size) * inv_grid_size) + (inv_grid_size * 0.5)) - j);
				}
				
				if (inventory_sprites[j][i] != noone) {
					draw_sprite(inventory_sprites[j][i], -103, ((floor(slot_pos.x / inv_grid_size) * inv_grid_size) + inv_grid_size) - i, ((floor(slot_pos.y / inv_grid_size) * inv_grid_size) + (inv_grid_size + 1)) - j);
				}
				if (currently_selected != noone) {
					draw_sprite(currently_selected, -104, mouse_position.x, mouse_position.y);
				}
			}
		}
	}
	else {
		current_cursor = RealCursor;
	}
	
	draw_sprite(Cursor, -103, mouse_position.x, mouse_position.y);

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
else {
	current_mouse_pos.x = mouse_x;
	current_mouse_pos.y = mouse_y;
}

if (show_pause_menu) {
	instance_deactivate_layer("Instances");
	instance_deactivate_layer("Instances_1");
		
	current_cursor = Rato_spr;
	window_mouse_set_locked(false);
}
else {
	instance_activate_layer("Instances");
	
	window_mouse_set_locked(true);
}

draw_sprite(current_cursor, -103, current_mouse_pos.x, current_mouse_pos.y);

if (elapsed_time >= 3.0) {
	unlerped_inv_y_offset = 128;
	elapsed_time = 0;
}

if (keyboard_check_pressed(ord("I"))) {
	show_inventory = !show_inventory;
	audio_sound_pitch(OpenInv, random_range(0.75, 1.25));
    audio_play_sound(OpenInv, 10, false);
}

if (keyboard_check_pressed(vk_escape)) {
	show_pause_menu = !show_pause_menu;
}

if (mouse_check_button_pressed(mb_left)) {
	mouse_clicked = true;
}

elapsed_time += delta_time / 1000000;