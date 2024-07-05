extends State

@export var script_user : CharacterBody2D
var animation_duration = 0.6
var old_move_speed
var old_attack_chance

func _ready():
	pass

func Enter():
	old_move_speed = script_user.movement_speed
	old_attack_chance = script_user.attack_chance
	await get_tree().create_timer(5).timeout
	transitioned.emit(self,"Search_room")
	pass

func Exit():
	script_user.attack_chance = old_attack_chance
	script_user.movement_speed = old_move_speed
	pass

func Physics_Update(_delta: float):
	script_user.get_node("AnimationPlayer").play("Idle")
	script_user.movement_speed = 0
	script_user.velocity = Vector2.ZERO
	pass
