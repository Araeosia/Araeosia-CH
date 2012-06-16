bind(player_death, null, null, @death
	cancel()
	runas(~op, concat("/pex user ", @death[player], "add vanishnopacket.vanish"))
	run("/vanish")
	runas(~op, concat("/pex user ", @death[player], "remove vanishnopacket.vanish"))
	foreach(all_players, @player,
		if(array_contains(sk_current_regions(@player)), "")
	)
	broadcast(concat("§4", @death[player], " has died, leaving only ", @left".))
)