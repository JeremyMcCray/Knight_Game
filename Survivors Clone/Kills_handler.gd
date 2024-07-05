extends Node

#Map of Knight to kill Count
var knight_to_kills = {}
var knights_list

func _ready():
	get_tree().connect("node_added", Callable(self, "_on_node_added"))
	
	knights_list = get_tree().get_nodes_in_group("knight")
	var chest_list = get_tree().get_nodes_in_group("chest")
	
	for knight in knights_list:
		knight_to_kills[StringName(knight.name)] = 0
	
	for chest in chest_list:
		chest.connect("found",Callable(self, "track_chests"))
		chest.connect("searched",Callable(self, "searched_chest"))

func track_kills(killer,killed):
	var knight_name
	knights_list = get_tree().get_nodes_in_group("knight")
	for knight in knights_list:
		knight_name = StringName(knight.name)
		if !knight_to_kills.has(knight_name):
			knight_to_kills[knight_name] = 0
			
	knight_name = StringName(killer.name)
	if !knight_to_kills.has(knight_name):
		knight_to_kills[knight_name] = 0
	else:
		knight_to_kills[knight_name] = knight_to_kills[knight_name] + 1
		killer.got_a_kill(knight_to_kills[knight_name])


func track_loot(looter,loot):
	looter.loot_grabbed(loot)


func track_chests(loot):
	var knight_name
	knights_list = get_tree().get_nodes_in_group("knight")
	for knight in knights_list:
		knight.known_chests[loot] = loot.position

func searched_chest(chest):
	for knight in knights_list:
		knight.known_chests.erase(chest)

func _on_node_added(node):
	if node is Enemy_unit:
		node.connect("_signal_my_killer", Callable(self, "track_kills"))
		pass
	if node.is_in_group("chest"):
		node.connect("searched",Callable(self, "searched_chest"))
		node.connect("found",Callable(self, "track_chests"))

