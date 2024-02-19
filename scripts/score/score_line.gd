class_name ScoreLine extends Node2D

@onready var nameLabel: Label = $NameLabel
@onready var scoreLabel: Label = $ScoreLabel


var score: int
var player_name: String

func set_score(score_to_set:int):
	score = score_to_set
	#print(score)

func _set_name(name_to_set:String):
	player_name = name_to_set
	#print(name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	nameLabel.text = player_name
	scoreLabel.text = str(score)
