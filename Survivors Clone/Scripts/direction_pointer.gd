extends Sprite2D

var current_destination = Vector2() # Set this to your actual destination position
var knight
var moving
func _ready():
	moving = true
	self.texture = load("res://.godot/imported/04.png-69bf24cab0852bc780a631961fa4f6b2.ctex")
	knight = get_parent()
	current_destination = knight.current_destination
	pass
	
	

func _process(delta):
	if moving:
		var direction = knight.current_destination - self.global_position 
		var angle = direction.angle() + 45
		self.rotation = angle


func _on_knight_state_machine_thinking():
	moving = false
	self.scale = Vector2(.25,.25)
	#turn texture to thinking
	self.texture = load("res://Textures/Tiny Swords (Update 010)/UI/Pointers/question_mark_2.png")
	self.rotation = 0
	pass # Replace with function body.


func _on_knight_state_machine_moving():
	moving = true
	self.scale = Vector2(.65,.65)
	self.rotation = 45
	self.texture = load("res://.godot/imported/04.png-69bf24cab0852bc780a631961fa4f6b2.ctex")
	pass # Replace with function body.
