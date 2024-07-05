extends Node

#var rng = RandomNumberGenerator.new()

#@onready var player = get_tree().get_first_node_in_group("player")
#@onready var zombie_scene = load("res://zombie/zombie.tscn")
#@export var spawn_distance = 200

#func _on_timer_timeout():
#	spawn_a_zombie()

#func spawn_a_zombie():
#	var zombie = zombie_scene.instantiate()
#	
#	var randRad = rng.randf_range(0, 2)
#	var zombie_x = spawn_distance * sin(3.14 * randRad)
#	var zombie_y = spawn_distance * cos(3.14 * randRad)
#	var zombie_spawn_pos = Vector2(zombie_x, zombie_y) + player.global_position
#	
#	zombie.position = zombie_spawn_pos
#	
#	add_child(zombie)
#	zombie.add_to_group("enemy")
