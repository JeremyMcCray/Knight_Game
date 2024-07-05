extends State

@export var script_user : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func Enter():
	pass

func Physics_Update(_delta):
	decide_destination()

func get_destination_direction(unit):
#	var destination_path_array =  _path_finder._get_path_Vector2i_as_Vector2D(self.global_position,unit.global_position)
	var direction = script_user.global_position.direction_to(unit.global_position)
	script_user.velocity = direction * script_user.movement_speed
	script_user.move_and_slide()

func decide_destination():
	if script_user.target != null:
		get_destination_direction(script_user.target)
	else:
		transitioned.emit(self,"Choose_enemy")
	return
