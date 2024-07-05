extends State

@export var script_user : CharacterBody2D
var map_size : CollisionShape2D
var map_rect2 : Rect2
var searching : bool

func _ready():
	var area2d : Area2D = find_node_in_group_upwards("Map_Size")
	var shape = area2d.get_child(0).get_shape()
	map_rect2 = shape.get_rect()
	map_rect2.position = Vector2(560,400)
	pass

func Enter():
	await get_tree().create_timer(2).timeout
	searching = true
	pass

func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_Update(_delta):
	if searching:
		script_user.current_destination = get_random_point_in_rect(map_rect2)
		searching = false
	else:
		script_user.velocity = script_user.global_position.direction_to(script_user.current_destination) * 20
		script_user.move_and_slide()
		if script_user.global_position.distance_to(script_user.current_destination) < 10.0:
			transitioned.emit(self,"Healing_self")
			searching = true

func get_random_point_in_rect(rect: Rect2) -> Vector2:
	var x = randf_range(rect.position.x / 2, (rect.position.x + rect.size.x)/2)
	var y = randf_range(rect.position.y / 2, (rect.position.y+ rect.size.y)/2)
	return Vector2(x, y)

func find_node_in_group_upwards(group_name: String) -> Node:
	var current_node = get_parent()
	while current_node:
		if !current_node.get_tree().get_nodes_in_group(group_name).is_empty():
			return current_node.get_tree().get_first_node_in_group(group_name)
		current_node = current_node.get_parent()
	return null
