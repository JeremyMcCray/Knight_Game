extends Enemy_unit

var rng = 1000
var attack_chance = 100
var knight_list

func _ready():
	knight_list = get_tree().get_nodes_in_group("knight")
	super()

func _physics_process(_delta):
	_process_animation()
	if knight_list.size() > 0:
		if self.target == null:
			var random_target = get_closest_enemy(knight_list)
			self.target = random_target 
		attack_chance = randi_range(0,200)
		if attack_chance == 0:
			basic_attack(target)

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


func _on_hurtbox_body_entered(body):
	if body.is_in_group("knight"):
		body.take_damage(self,5)

#------------------Animation Processing
@onready var _skeleton_sprite = $SkeletonSprite2D
var uninteruptable_animations = ["SwingOne","Death","Full Combo","Hurt"]

func _process_animation():
	if !uninteruptable_animations.has(_animation_player.get_current_animation()):
		if self.velocity == Vector2(0,0):
			_animation_player.play("Idle")
		#walk left
		if self.velocity.x < 0:
			_skeleton_sprite.flip_h = true
			_animation_player.play("Run")
		#walk right
		else:
			_skeleton_sprite.flip_h = false
			_animation_player.play("Run")
