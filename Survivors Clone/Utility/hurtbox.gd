extends Area2D

signal hurt(damage)

# Called when the node enters the scene tree for the first time
func _ready():
	$Hurtbox.connect("area_entered", Callable(self, "_on_Hurtbox_area_entered")
