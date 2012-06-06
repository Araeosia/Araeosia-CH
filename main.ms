bind(player_chat, NULL, NULL, @chat,
	#Cancel the event
	#Implode the array
	#Send the IRC message
	#Echo back to players
)
bind(player_join, NULL, NULL, @join,
	#Cancel the event
	#Send the IRC message
	#Decide who should recieve the join (both quiet and tutorial)
	#Echo back to players
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