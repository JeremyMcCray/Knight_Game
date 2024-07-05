extends State_Machine

signal thinking
signal moving

func _ready():
	for child in get_children():
		if child is State:
			child.script_user = get_parent()
			states[child.name] = child
			child.transitioned.connect(on_child_transition)
	if initial_state:
		current_state = initial_state
		initial_state.Enter()

func _process(delta):
	super(delta)

func _physics_process(delta):
	super(delta)

func on_child_transition(state,new_state_name):
	super(state,new_state_name)
	if new_state_name == "Healing_self":
		thinking.emit()
	if new_state_name == "Search_room":
		moving.emit()
