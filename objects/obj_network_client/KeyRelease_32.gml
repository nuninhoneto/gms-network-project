if svr_is_connected()
{
	buffer_seek(buffer, buffer_seek_start, 0);
	buffer_write(buffer, buffer_u16, CMD_KEY);
	buffer_write(buffer, buffer_u16, KEY_BUTTON_0);
	buffer_write(buffer, buffer_u16, 0);
	network_send_packet(svr_get_client_socket(), buffer, buffer_tell(buffer));
}
