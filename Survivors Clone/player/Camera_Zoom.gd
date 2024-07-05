extends Camera2D


var zoom_speed = 200
var zoom_margin = 0.5

var zoom_min = .01
var zoom_max = 2

var zoom_factor = 1.0

var scrolling = false

func _physics_process(delta):
	zoom.x = lerp(zoom.x,zoom.x * zoom_factor, zoom_speed * delta)
	zoom.y = lerp(zoom.y,zoom.y * zoom_factor, zoom_speed * delta)
	
	zoom.x = clamp(zoom.x, zoom_min, zoom_max)
	zoom.y = clamp(zoom.y, zoom_min, zoom_max)
	
	scale = Vector2(1 / zoom.x, 1 / zoom.y)
	if !scrolling:
		zoom_factor = 1.0

func _input(event):
	if event.is_pressed():
		if !scrolling:
			if event.as_text() == "Mouse Wheel Up":
				zoom_factor += .01
				scrolling = true
				await get_tree().create_timer(.05).timeout
				scrolling = false
			if event.as_text() == "Mouse Wheel Down":
				zoom_factor -= .01
				scrolling = true
				await get_tree().create_timer(.05).timeout
				scrolling = false
