bind(player_death, null, null, @death,
	if(get_value('games_active'),
#Keep them alive, right where they are at.
		cancel()
#Make them invisible to everyone, and stop them from interacting with anything.
		runas(~op, concat("/pex user ", @death[player], "add vanishnopacket.vanish"))
		run("/vanish")
		runas(~op, concat("/pex user ", @death[player], "remove vanishnopacket.vanish"))
#Don't let them chat in the "Living" channel, but allow them access to the dead players channel.
		runas(~op, concat("/pex user ", @death[player], "add herochat.join.deadplayers"))
		runas(~op, concat("/pex user ", @death[player], "remove herochat.speak.hungergames"))
		run("/ch DeadPlayers")
#Build the deadplayers array, containing all dead players.
		assign(@deadplayers, get_value('dead_players'))
		array_push(@deadplayers, @death[player])
		assign(@playersleft, array())
		assign(@playersleft, get_value('playersin'))
		array_remove(@playersleft, player())
		ifelse(lte(array_size(@playersleft), 3),
			assign(@left, array_implode(@playersleft, ", ")),
			assign(@left, concat( array_size(@playersleft), " players"))
		)
		broadcast(concat("§4", @death[player], " has died, leaving only ", @left, " are left.))
		store_value('dead_players', @deadplayers)
		store_value('playersin', @playersleft)
	)
)
bind(block_break, null, null, @blockbreak,
	assign(@allowedblocks, array('Leaves', 'Mushrooms', 'Vines'))
	if(not(array_contains_ic(@allowedblocks, @blockbreak[type])),
		cancel()
		die('§4You are not allowed to break blocks in The Survival Games 2.')
	)
)
bind(player_quit, null, null, @quit,
	if(not(get_value('games_active')), die())
	assign(@playersleft, get_value('playersin'))
	if(in_array(@playersleft, @quit[player]),
		modify_event(message, concat('§4', @quit[player], ' has left the Hunger Games 2!'))
		array_remove(@playersleft, @quit[player])
		store_value('playersin', @playersleft)
	)
)
bind(player_chat, null, null, @chat,
	assign(@channel, get_value(currentchannels, @chat[player]))
	if(array_contains_ic(@groups, 'Veteran'), assign(@prefix, '§2'))
	if(array_contains_ic(@groups, 'VIP'), assign(@prefix, '§3'))
	if(array_contains_ic(@groups, 'Moderator'), assign(@prefix, '§a'))
	if(array_contains_ic(@groups, 'Admin'), assign(@prefix, '§4'))
	if(array_contains_ic(@groups, 'Head-Admin'), assign(@prefix, '§4'))
	if(equals(@channel, "A") assign(@channelcolor, "e"))
	if(equals(@channel, "Staff") assign(@channelcolor, "a"))
	if(equals(@channel, "SG1A") assign(@channelcolor, "2"))
	if(equals(@channel, "SG1B") assign(@channelcolor, "2"))
	if(equals(@channel, "SG1C") assign(@channelcolor, "2"))
	if(equals(@channel, "SG2A") assign(@channelcolor, "2"))
	if(equals(@channel, "SG2B") assign(@channelcolor, "2"))
	if(equals(@channel, "SG2C") assign(@channelcolor, "2"))
	foreach(all_players(), @player,
		if(equals(get_value(currentchannels, @player), @channel), tmsg(@player, concat("§", @channelcolor, "[", @channel, "]", @prefix, @chat[player], "§f: ", @chat[message])))
	)
)