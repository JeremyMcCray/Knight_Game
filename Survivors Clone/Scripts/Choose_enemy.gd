extends State

@export var script_user : CharacterBody2D
@export var target_name : String
var targets_left : Array
# get the list of knights
# if randknight isn't current target
# script user target = knight

func _ready():
	target_name = get_parent().target_name
	pass

func Enter():
	choose_enemy_or_wait()

func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	choose_enemy_or_wait()
	pass

func choose_enemy_or_wait():
	if script_user.target == null:
		await get_tree().create_timer(0.1).timeout
	targets_left = find_node_in_group_upwards(target_name)

	for new_target in targets_left:
		if script_user.target != new_target:
			script_user.target = new_target
			transitioned.emit(self,"Follow_enemy")


func find_node_in_group_upwards(group_name: String) -> Array:
	var current_node = get_parent()
	while current_node:
		if !current_node.get_tree().get_nodes_in_group(group_name).is_empty():
			return current_node.get_tree().get_nodes_in_group(group_name)
		current_node = current_node.get_parent()
	return []
