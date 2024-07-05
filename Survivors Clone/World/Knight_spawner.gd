extends Node

var rng = RandomNumberGenerator.new()

@onready var player = get_tree().get_first_node_in_group("player")
@onready var knight_scene = load("res://player/knight.tscn")
@export var spawn_distance = 200

@onready var first_knight = spawn_a_knight()

func _on_timer_timeout():
	spawn_a_knight()

func spawn_a_knight():
	var knight = knight_scene.instantiate()
	
	var randRad = rng.randf_range(0, 2)
	var knight_x = spawn_distance * sin(3.14 * randRad)
	var knight_y = spawn_distance * cos(3.14 * randRad)
	var knight_spawn_pos = Vector2(knight_x, knight_y) + player.global_position
	
	knight.position = knight_spawn_pos
	knight.add_to_group("knight")
	
	add_child(knight)
	
