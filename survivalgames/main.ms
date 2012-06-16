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
		foreach(all_players, @player,
			if(array_contains(sk_current_regions(@player)), "SurvivalGamesGame",
				if(not(array_contains(@deadplayers))
					array_push(@playersleft, @player)
				)
			)
		)
		ifelse(lte(array_size(@playersleft), 3),
			assign(@left, array_implode(@playersleft, ", ")),
			assign(@left, concat( array_size(@playersleft), " players"))
		)
		broadcast(concat("§4", @death[player], " has died, leaving only ", @left, " are left.))
		store_value('dead_players', @deadplayers)
	)
)
bind(block_break, null, null, @blockbreak,
	assign(@allowedblocks, array('Leaves', 'Mushrooms', 'Vines'))
	if(not(array_contains_ic(@allowedblocks, @blockbreak[type])),
		cancel()
		die('§4You are not allowed to break blocks in The Survival Games 2.')
	)
)