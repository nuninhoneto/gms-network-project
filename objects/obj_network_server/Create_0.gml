svr_initialize_server()

player_list = ds_map_create()

function joystick() constructor
{
	keys = ds_list_create()
	
	for(var _i = 0; _i < 3; ++_i;)
	{
		keys[_i] = false;
	}
}

m_on_connect = function(_sock)
{
	ds_map_add(player_list, _sock, new joystick());
}

m_on_disconnect = function(_sock)
{
	ds_map_delete(player_list, _sock);
}

m_process_buff = function(_buff, _sock)
{
	var _cmd = buffer_read(_buff, buffer_s16); // read the command 

	var _player_instance = ds_map_find_value(player_list, _sock); // Look up the client details

	if _cmd == CMD_KEY // Is this a KEY command?   
	{
		// Read the key that was sent
		var _key = buffer_read(_buff, buffer_s16);

		// And it's up/down state
		var _updown = buffer_read(_buff, buffer_s16);
         
		// translate updown into a bool for the player array       
		if _updown == 0
		{
			_player_instance.keys[_key] = false;
		}
		else
		{
			_player_instance.keys[_key] = true;
		}
	}
	else if _cmd == CMD_PING
	{
		// keep alive - ignore it
	}
}