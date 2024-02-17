extends Node2D

@onready var label : Label = $NameLabel
var player_name : String

# Called when the node enters the scene tree for the first time.
func _ready():
	
	player_name = ""


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_name == "":
		label.set_text("Your name")
	else:
		label.set_text(player_name)

func _input(event):
	
	if event is InputEventKey and event.is_pressed():
		var key_text : String = OS.get_keycode_string(event.keycode)
		if key_text == "Enter" and player_name.length()>=3:
			var score_manager : ScoreManager = SceneManager.score
			score_manager._set_name(player_name)
			score_manager.save_scores()
		elif player_name.length()<3 and key_text.length() == 1:
			player_name+=key_text
			
