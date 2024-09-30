function is_on_floor() {
	return place_meeting(x, y + 2, tilemap);
}

if (not is_on_floor()) self.y += 3;