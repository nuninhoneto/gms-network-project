if (sprite_index > -1)
	draw_self()

draw_text(0, 0, "Server Version")

draw_text(0, 20, "Server Running: " + string(svr_is_connected()))

var _count = ds_list_size(svr_get_clients());

draw_text(0, 40, string("Clients Connected: {0}", _count))

for(var _i=0; _i < _count; _i++)
{
    var _sock = ds_list_find_value(svr_get_clients(), _i);
	var _player = ds_map_find_value(player_list, _sock);
	
	if !is_undefined(_player)
		draw_text(0, (_i+3) * 20, "Button Pressed: " + string(_player.keys[KEY_BUTTON_0]))
}