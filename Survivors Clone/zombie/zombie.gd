extends CharacterBody2D
class_name Enemy_unit

@export var movement_speed = 30.0
@export var base_movement_speed = 30.0
@export var health_points = 10
@export var _sprite : Sprite2D
@export var collision_shape : CollisionShape2D
@export var target_name : String
@export var _animation_player : AnimationPlayer

@onready var _state_machine

var killer = null
var kill_handler
var target = null

signal _signal_my_killer(killer)

func _ready():
	add_to_group("enemy")
	var machine = load("res://State Machines/basic_choose_and_follow_enemy_state_machine.tscn")
	_state_machine =  machine.instantiate()
	_state_machine.target_name = target_name
	add_child(_state_machine)
	_state_machine.initial_state = _state_machine.states.get("Choose_enemy")

func take_damage(damage_dealer,damage):
	_sprite.modulate = Color.RED
	slow_from_damage()
	await get_tree().create_timer(0.1).timeout
	_sprite.modulate = Color.WHITE
	health_points -= damage
	if health_points <= 0:
		spawn_a_gold_bag()
		killer = damage_dealer
		_signal_my_killer.emit(killer,self)
		queue_free()  # Remove zombie if health is depleted


func basic_attack(enemy):
	movement_speed = base_movement_speed/4
	for i in base_movement_speed/4:
		movement_speed += 1
		#TODO: change this to basic attack
	_animation_player.play("SwingOne")

func slow_from_damage():
	movement_speed = movement_speed/2
	for i in base_movement_speed/2:
		movement_speed += 1

func spawn_a_gold_bag():
	var gold_bag_scene = load("res://Props/gold_bag.tscn")
	var gold_bag = gold_bag_scene.instantiate()
	gold_bag.position = self.global_position
	get_tree().root.add_child(gold_bag)
	gold_bag.add_to_group("gold")
