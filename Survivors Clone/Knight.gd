extends CharacterBody2D


@export var movement_speed = 20.0
@export var base_movement_speed = 20.0
@export var health_points = 200

@onready var _state_machine

var current_destination : Vector2
var moving : bool
var target = null
var potential_target_list = []
var attack_chance
var loot_value = 0
var known_chests : Dictionary

func _ready():
	var machine = load("res://State Machines/knight_state_machine.tscn")
	_state_machine = machine.instantiate()
	add_child(_state_machine)
	_state_machine.initial_state = _state_machine.states.get("Searching_room")

func _physics_process(_delta):
	_process_animation_()
	
	#Change this to potential targets
	var enemy_list = get_tree().get_nodes_in_group("enemy")
	if enemy_list.size() > 0:
		if target == null:
			var random_target = get_closest_enemy(enemy_list)
			target = random_target 
		attack_chance = randi_range(0,50)
		if attack_chance == 0:
			attack(target)

func get_closest_enemy(units: Array):
	# Initialize the closest unit and the smallest distance
	var closest_unit = null
	var smallest_distance = INF
	
	# Iterate through each unit in the list
	for unit in units:
		var distance = unit.global_position.distance_to(self.global_position)
		if distance < smallest_distance:
			smallest_distance = distance
			closest_unit = unit
	return closest_unit

func got_a_kill(killcount):
	_kill_counter_label.text = "Kill Count: %s" % killcount
	await get_tree().create_timer(1.5).timeout
	_kill_counter_label.text = "Loot Count: %s" % loot_value
	await get_tree().create_timer(1.5).timeout
	_kill_counter_label.text = ''

func _on_hurtbox_body_entered(body):
	if body.is_in_group("enemy"):
		body.take_damage(self,5)

func loot_grabbed(loot):
	loot_value += loot.value

func take_damage(enemy,damage):
	_knight_sprite.modulate = Color.RED
	slow_from_damage()
	await get_tree().create_timer(0.1).timeout
	_knight_sprite.modulate = Color.WHITE

	health_points -= damage
	if health_points <= 0:
		print("Dat's a Spizy MeetBoil")
	pass
	
func slow_from_damage():
	movement_speed = movement_speed/2
	for i in base_movement_speed/2:
		movement_speed += 1

#------------------Animation Processing
@onready var _kill_counter_label = $Knight_Sprite2D/KillCounterLabel
@onready var _knight_sprite = $Knight_Sprite2D
@onready var _animation_player = $AnimationPlayer
var uninteruptable_animations = ["Swing_one","Death","Full Combo","Hurt"]
	
enum Direction {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

func _process_animation_():
	if !uninteruptable_animations.has(_animation_player.get_current_animation()):
		if self.velocity == Vector2(0,0):
			_animation_player.play("Idle")
		#walk left
		if self.velocity.x < 0:
			_knight_sprite.flip_h = true
			_animation_player.play("Run")
		#walk right
		else:
			_knight_sprite.flip_h = false
			_animation_player.play("Run")


func attack(enemy):
	#add different attacks
	_animation_player.play("Swing_one")


func get_attack_direction(player_position, enemy_position):
	var direction_vector = enemy_position - player_position
	if abs(direction_vector.x) > abs(direction_vector.y):
		if direction_vector.x > 0:
			return Direction.RIGHT
		else:
			return Direction.LEFT
	else:
		if direction_vector.y > 0:
			return Direction.DOWN
		else:
			return Direction.UP
