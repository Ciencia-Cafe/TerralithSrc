draw_set_font(MainMenuFont);

padding_size = 20;

menu_options = [
	"Jogar",
	"Config",
	"Dar o cu",
	"Sair"
]

selected = 0;

biggest = 0;

function change_selected(new_index) {
	if (new_index >= array_length(menu_options)) selected = 0;
	else if (new_index < 0) selected = array_length(menu_options) - 1;
	else {
		selected = new_index;
	}
}

for (var i = 0; i < array_length(menu_options); i++) {
	var current_length = string_length(menu_options[i]);
	if (current_length > biggest) biggest = current_length;
}