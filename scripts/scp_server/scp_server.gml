function svr_initialize_server()
{
	socket_type = network_socket_tcp
	clients_connected = ds_list_create()

	if os_browser != browser_not_a_browser
	{
	   socket_type = network_socket_ws
	}

	network_socket_id = network_create_server(socket_type, DEFAULT_PORT, MAX_PLAYERS);

	if (network_socket_id < 0)
	{
		var _port = DEFAULT_PORT;
		while (_port < 65535)
		{
		    _port++
		    network_socket_id = network_create_server(socket_type, _port, MAX_PLAYERS);
		}
	}
}

function svr_connect_server()
{
	client_socket = -1

	if os_browser == browser_not_a_browser
	{
	    client_socket  = network_create_socket(network_socket_tcp);
		network_socket_id = network_connect(client_socket, URL, DEFAULT_PORT)
	}
	else
	{
	    client_socket  = network_create_socket(network_socket_ws);
		network_socket_id = network_connect_async(client_socket, URL, DEFAULT_PORT)
	}

}

/**
 * @return {Real} The Server Connection
 */
function svr_get_connection()
{		
	return network_socket_id
}

/**
 * @return {Real} The Server Connection
 */
function svr_get_client_socket()
{		
	return client_socket
}

/**
 * @return {Id.DsList<Any>} Connected Clients List
 */
function svr_get_clients()
{		
	return clients_connected
}

function svr_is_connected()
{
	if (!is_undefined(network_socket_id) && network_socket_id >= 0)
		return true
		
	return false
}

/**
 * @param {Id.DsMap} _asyncmap 
 * @param {function} [_callback] 
 */
function svr_on_server_connect(_asyncmap, _callback = undefined)
{
	var _sock = ds_map_find_value(_asyncmap, "socket");
	
	ds_list_add(clients_connected, _sock);
	
	if (_callback != undefined)
		_callback(_sock)
}

function svr_on_server_disconnect(_asyncmap, _callback = undefined)
{
	var _sock = ds_map_find_value(_asyncmap, "socket");
	
	ds_list_delete(clients_connected, _sock);
	
	if (_callback != undefined)
		_callback(_sock)
}

function svr_on_server_listen(_asyncmap, _callback = undefined)
{
	var _buffer = ds_map_find_value(_asyncmap, "buffer");
	var _sock = ds_map_find_value(_asyncmap, "id");
	
	if (_callback != undefined)
		_callback(_buffer, _sock)
}