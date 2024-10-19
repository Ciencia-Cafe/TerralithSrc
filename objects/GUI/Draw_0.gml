var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);

var view_w = camera_get_view_width(view_camera[0]);
var view_h = camera_get_view_height(view_camera[0]);

var current_selected = 0;

var inv_x = (_cam_x + (view_w * 0.5) - 160) + 11;

//spr da mira
draw_sprite_stretched(HealthBar, -100, _cam_x + (view_w * 0.25) - 31, _cam_y + (view_h * 0.25) - 8, 64, 16);
draw_sprite(OuterHealthBar, -101, _cam_x + (view_w * 0.25), _cam_y + (view_h * 0.25));
draw_sprite(BlockBreakSelect, -100, floor(mouse_x / 16) * 16, floor(mouse_y / 16) * 16);
draw_sprite(Gui_Inventario_spr, -100, _cam_x + ((view_w * 0.5) - 160), _cam_y + (view_h * 0.75));
draw_sprite(Gui_Selected, -101, inv_x + (50 * obj_Player.current_inv_index), _cam_y + (view_h * 0.75));

/*

player_inventory = ["None", "Axe", "Sword", "Fork", "Shovel", "Rod"];

*/


for (var i = 0; i < 6; i++) {
	var item_x = inv_x + (50 * i) + 24;
	var item_y = _cam_y + (view_h * 0.75) + 26;
	
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