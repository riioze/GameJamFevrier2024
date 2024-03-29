class_name ScoreBoard extends Node2D

@export var MAX_SCORES : int = 5
var score_line
@onready var input_ignored : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	score_line= preload("res://scenes/score/score_line.tscn") # Replace with function body.


func _set_visible():
	visible = true
	TimeManager.sleep(1.0)
	input_ignored = false
	

func set_score_board(scores : Dictionary):
	for score_n in range(MAX_SCORES):
		if scores.is_empty():
			return
		var best_player: String = get_best(scores)
		var best_score: int = int(scores[best_player])
		scores.erase(best_player)
		var line : ScoreLine = score_line.instantiate()
		line.set_score(best_score)
		line._set_name(best_player)
		add_child(line)
		line.position = Vector2(0,score_n*100-200)

func get_best(scores : Dictionary) -> String:
	var best_index:String
	var best_score:int = 0
	
	for index:String in scores:
		if int(scores[index])>best_score:
			best_score = int(scores[index])
			best_index = index
	
	return best_index

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	if input_ignored:
		return
	if event.is_action_pressed("Confirm"):
		SceneManager.load_game()
	elif event.is_action("Back"):
		SceneManager.load_menu()
