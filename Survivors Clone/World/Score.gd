extends Label

# Reference to the Label node
@onready var score_label = $Score

# Variable to hold the score
var score: int = 0

# Function to update the score
func update_score(value: int):
	score += value
	score_label.text = "Score: " + str(score)

func _on_zombie_zombie_defeted(damage):
	update_score(damage) # Replace with function body.

func _process(delta):
	var labeltext = self.text
	labeltext = score
