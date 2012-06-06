bind(player_chat, NULL, NULL, @chat,
	#Cancel the event
	cancel()
	#See if the player is muted
	assign(@muted, sql_query("SELECT * FROM Mutes WHERE name='@chat[player]'"))
	assign(@muted, mysql_fetch_array(@muted))
	if(@muted[name]==@chat[player],
		if(array_contains(pgroup(player()),"Tutorial"),
			die('§cYou are in the tutorial and cannot speak. /motd for info.')
		)
		die('§4You are muted.')
	)
	#Determine the chat prefix
	if(array_contains(pgroup(player()),"Admin"), assign(@prefix, "4"))
	if(array_contains(pgroup(player()),"Moderator"), assign(@prefix, "c"))
	if(array_contains(pgroup(player()),"1"), assign(@prefix, "b"))
	#Figure out which channel the player is in
	assign(@channel, sql_query("SELECT * FROM ChannelsIn WHERE name='@chat[player]'"))
	assign(@channel, mysql_fetch_array(@channel))
	#Build the output
	assign(@output, concat("CHAT§"@chat[player], '§', @channel[channel], '§', @prefix, '§', @chat[message]))
	assign(@localout, concat("[", @channel[channel], "] §", @prefix, @chat[player], "§f: ", @chat[message]))
	#Send the IRC message
	irc_message("ServerABot", "#servercomm", @output)
	#Send the messages
	foreach(all_players, @player,
		if(array_contains(pgroup(player()),"Tutorial"), die())
		tmsg(@player, @localout)
	)
)
bind(player_join, NULL, NULL, @join,
	#Cancel the event
	modify_event(join_message, null)
	#Send the IRC message
	assign(@output, concat("JOIN§", @join[player], "§ServerA"))
	#irc_message("ServerABot", "#servercomm", @output)
	#Decide who should recieve the join (both quiet and tutorial)
	foreach(all_players, @player,
		if(array_contains(pgroup(player()),"Tutorial"), die())
		tmsg(@player, @localout)
	)
)
bind(player_death, NULL, NULL, @death,
	#Kill the death message
	#Send the IRC message
	#Decide who should recieve the death (who's in their group?)
	#Echo back to players
)
bind(player_quit, NULL, NULL, @quit,
	#Cancel the event
	#Send the IRC message
	#Decide who should recieve the leave (both quiet and tutorial)
	#Echo back to players
)