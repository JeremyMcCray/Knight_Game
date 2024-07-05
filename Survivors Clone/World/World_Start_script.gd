extends Node2D


# exports for editor
@export var fog: Sprite2D
@export var fogWidth = 1000
@export var fogHeight = 1000
@export var LightTexture: CompressedTexture2D
@export var lightWidth = 300
@export var lightHeight = 300
@export var debounce_time = 0.3

# debounce counter helper
var time_since_last_fog_update = 0.0

var fogImage: Image
var lightImage: Image
var light_offset: Vector2
var fogTexture: ImageTexture
var light_rect: Rect2
var trans_rect: Rect2
var transImage
var knight_list : Array
var trans_blend_count = 0

@onready var kill_handler_scene = load("res://Scripts/kill_handler.tscn")
var kill_handler

func get_kill_handler():
	return kill_handler

# here we cache things when Node2D is ready
func _ready():
	kill_handler = kill_handler_scene.instantiate()
	add_to_group("world")
	# get Image from CompressedTexture2D and resize it
	lightImage = LightTexture.get_image()
	lightImage.resize(lightWidth, lightHeight)
	
	# get center
	light_offset = Vector2(lightWidth/2, lightHeight/2)
	
	# create black canvas (fog)
	fogImage = Image.create(fogWidth, fogHeight, false, Image.FORMAT_RGBA8)
	transImage = Image.create(fogWidth, fogHeight, false, Image.FORMAT_RGBA8)
	var color_trans = Color(1,1,1,0.1)
	var color_black = Color(Color.BLACK)
	fogImage.fill(color_black)
	transImage.fill(color_trans)
	
	fogTexture = ImageTexture.create_from_image(fogImage)
	fog.texture = fogTexture
	
	light_rect = Rect2(Vector2.ZERO, lightImage.get_size())
	trans_rect = Rect2(Vector2.ZERO, fogImage.get_size())
	
	for i in 7:
		fogImage.blend_rect(transImage, trans_rect ,Vector2(0,0))
	
	fogTexture.update(fogImage)

func update_fog(pos):
	fogImage.blend_rect(lightImage, light_rect, pos - light_offset)
	fogTexture.update(fogImage)

func _process(delta):
	time_since_last_fog_update += delta
	if (time_since_last_fog_update >= debounce_time):
		for knight in knight_list:
			update_fog(knight.global_position)

func _on_knight_spawner_child_entered_tree(node):
	if node.is_in_group("knight"):
		knight_list.append(node)
		pass
