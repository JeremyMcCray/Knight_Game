extends CharacterBody2D

@export var movement_speed = 20.0
@export var base_movement_speed = 20.0
@export var health_points = 20
@onready var _sprite = $JuggernautSprite
var target = null

func _physics_process(_delta):
	var direction = global_position.direction_to(decide_destination())
	velocity = direction * movement_speed
	move_and_slide()
		#Change this to potential targets
	var enemy_list = get_tree().get_nodes_in_group("knight")
	if enemy_list.size() > 0:
		#var random_target = get_closest_enemy(enemy_list)
		var random_target = get_tree().get_first_node_in_group("knight")
		target = random_target 

func _on_hurt(body,damage):
	if body == self:
		movement_speed = 0
		health_points -= damage  # Reduce health by damage amount
		slow_from_damage()

			
func take_damage(damage_dealer,damage):
	_sprite.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	_sprite.modulate = Color.WHITE
	self.health_points -= damage
	if health_points <= 0:
		queue_free()  # Remove zombie if health is depleted

func slow_from_damage():
	await get_tree().create_timer(0.1).timeout
	for i in base_movement_speed:
		movement_speed += 1

func get_destination_direction(unit):
	return unit.global_position

func decide_destination():
	if target != null:
		#pick target
		return get_destination_direction(target)
	return Vector2(0,0)
