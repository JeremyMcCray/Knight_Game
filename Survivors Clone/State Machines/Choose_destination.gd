extends State

@export var script_user : CharacterBody2D
var destination_score_map = {
"Searching around the map": 100,

"Move to Chest": 0,
#if a chest is found this should get medium priority +150

"Move to Shrine": 0,
#health should be 100% once health under 75 heal self should be triggered

"Move to Ally": 0,
#if health is under 50% protect should be emitted, sets destination to emitter
 
"Move to exit": 0
#when exit is found, emit and this should be slightly lower priority than move to chest

}

# Called when the node enters the scene tree for the first time.
func _ready():
	#get top scoring destination
	#if move to chest
	#user dest = chest.dest where is this chest tho? On chest spawn emit and join group chests()
	#if exit
	#user dest = exit.global_position on exit found emit and join group exit()
	#if
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
