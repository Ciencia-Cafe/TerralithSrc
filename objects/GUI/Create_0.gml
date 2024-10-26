inv_y_offset = 0.0;
unlerped_inv_y_offset = 0.0;

window_mouse_set_locked(true);

_cam_x = camera_get_view_x(view_camera[0]);
_cam_y = camera_get_view_y(view_camera[0]);

view_w = camera_get_view_width(view_camera[0]);
view_h = camera_get_view_height(view_camera[0]);

elapsed_time = 0;

current_mouse_pos = new vector(obj_Player.x, obj_Player.y);

mouse_position = new vector((floor(current_mouse_pos.x / 16) * 16) - 8, (floor(current_mouse_pos.y / 16) * 16) - 8);

old_mouse_pos = new vector(mouse_x, mouse_y);

mouse_pos = new vector(window_mouse_get_delta_x(), window_mouse_get_delta_y());