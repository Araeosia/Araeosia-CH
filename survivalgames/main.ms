bind(player_death, null, null, @death
	if(get_value('games_active'),
		cancel()
		runas(~op, concat("/pex user ", @death[player], "add vanishnopacket.vanish"))
		run("/vanish")
		runas(~op, concat("/pex user ", @death[player], "remove vanishnopacket.vanish"))
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