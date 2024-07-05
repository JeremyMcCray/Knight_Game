extends Node2D

# exports for editor
@export var fog: Sprite2D
@export var fogWidth = 5000
@export var fogHeight = 5000
@export var LightTexture: CompressedTexture2D
@export var lightWidth = 300
@export var lightHeight = 300
@export var debounce_time = 0.01

# debounce counter helper
var time_since_last_fog_update = 0.0

var fogImage: Image
var lightImage: Image
var light_offset: Vector2
var fogTexture: ImageTexture
var light_rect: Rect2

var knight_list : Array

# here we cache things when Node2D is ready
func _ready():
	get_tree().connect("node_added", Callable(self, "_on_node_added"))
  # get Image from CompressedTexture2D and resize it
	lightImage = LightTexture.get_image()
	lightImage.resize(lightWidth, lightHeight)

  # get center
	light_offset = Vector2(lightWidth/2, lightHeight/2)

  # create black canvas (fog)
	fogImage = Image.create(fogWidth, fogHeight, false, Image.FORMAT_RGBA8)
	fogImage.fill(Color.BLACK)
	fogTexture = ImageTexture.create_from_image(fogImage)
	fog.texture = fogTexture
	fog.modulate.a = 0.5

  # get Rect2 from our Image to use it with .blend_rect() later
	light_rect = Rect2(Vector2.ZERO, lightImage.get_size())
	
# update our fog
func update_fog(pos):
	fogImage.blend_rect(lightImage, light_rect, pos - light_offset)
	fogTexture.update(fogImage)

# main render loop. Here we don't need to call update every iteration.
# So we are using debounce here to execute code each "debounce_time"
# If debounce us ready, now we can check is character moving. And update fog if it's moving.
# Here I don't use single if block for debounce + player input because we don't need to check input
# if debounce is not ready. 
func _process(delta):
	time_since_last_fog_update += delta
	if (time_since_last_fog_update >= debounce_time):
		for knight in knight_list:
			update_fog(knight.global_position)

#on knight spawn add to knight list
#for knight in knight list
# update fog(pos)
func _on_node_added(node):
	if node.is_in_group("knight"):
		knight_list.append(node)
		pass
	#if node is in group loot
