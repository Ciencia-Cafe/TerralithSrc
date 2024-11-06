draw_set_font(MainMenuFont);

padding_size = 18;

menu_options = [
	"Resumir o jogo",
	"Recomeçar o jogo",
	"Voltar ao Menu",
	"Sair do jogo"
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

function start_room() {
	room_id = WorldTest;
	
	switch(selected) {
		case 0:
			room_id = WorldTest;
			break;
		case 1:
			room_id = WorldTest;
			break;
		case 2:
			room_id = Menu;
			break;
	}
	room_goto(room_id);
}

for (var i = 0; i < array_length(menu_options); i++) {
	var current_length = string_length(menu_options[i]);
	if (current_length > biggest) biggest = current_length;
}