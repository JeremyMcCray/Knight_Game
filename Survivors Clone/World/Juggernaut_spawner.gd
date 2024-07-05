extends Node

var rng = RandomNumberGenerator.new()

@onready var skeleton_scene = load("res://Enemies/skeleton.tscn")
@onready var player = get_tree().get_first_node_in_group("player")
@export var spawn_distance = 400

@onready var first_skeleton = spawn_a_skeleton()

func _on_timer_timeout():
	spawn_a_skeleton()

func spawn_a_skeleton():
	var skeleton = skeleton_scene.instantiate()
	
	var randRad = rng.randf_range(0, 2)
	var skeleton_x = spawn_distance * sin(3.14 * randRad)
	var skeleton_y = spawn_distance * cos(3.14 * randRad)
	var skeleton_spawn_pos = Vector2(skeleton_x, skeleton_y) + player.global_position
	
	skeleton.position = skeleton_spawn_pos
	
	add_child(skeleton)
	skeleton.add_to_group("skeleton")
