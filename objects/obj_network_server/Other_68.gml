if svr_is_connected()
{
	var _n_id = ds_map_find_value(async_load, "id");
	var _t = ds_map_find_value(async_load, "type");
	
	// If the socket ID is the server one, then we have a new 
	// client connecting, OR an old client disconnecting
	if _n_id == svr_get_connection() 
    {
	    switch(_t)
	    {
		    case network_type_connect:
				svr_on_server_connect(async_load, m_on_connect)
		        break;
		    case network_type_disconnect:
				svr_on_server_disconnect(async_load, m_on_disconnect)
		        break;	
	    }
    }
	else // Socket ID from clients
	{
	    switch(_t)
	    {
		 	case network_type_data:
				svr_on_server_listen(async_load, m_process_buff)
				break;
		}
	}
}
