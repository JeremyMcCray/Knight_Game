extends Area2D
@onready var _sprite = $Sprite2D
@onready var _collision = $CollisionShape2D
var value = 100
var looted = false
signal found(loot)
signal searched(loot)

func _on_body_entered(body):
	if body.is_in_group("knight") and looted == false:
		looted = true
		body.loot_grabbed(self)
		emit_signal("searched",self)
		_collision.set_deferred("disabled",true)
		_sprite.frame = 8
		
	pass # Replace with function body.


func _on_area_entered(area):
	emit_signal("found",self)
	#Destination map needs to subscribe to all chests
	pass # Replace with function body.
