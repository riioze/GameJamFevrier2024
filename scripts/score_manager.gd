class_name ScoreManager extends Node

@onready var score_node: Node2D = $SettingName/Score
@onready var score_board_node: ScoreBoard = $ScoreBoard

var score_dict = {}
var in_score : bool
var name_set : bool
var score : int = 0
var player_name : String = "test2"


# Called when the node enters the scene tree for the first time.
func _ready():
	in_score = true
	name_set = false
	score_board_node.visible = false
	display_score()

	load_scores()

func display_score():
	var score_label: Label = $SettingName/Score/ScoreLabel
	score_label.set_text("Score : " + str(score))

func load_scores():
	var file : FileAccess = FileAccess.open("res://save_game.txt",FileAccess.READ)
	var content : String = file.get_as_text().replace('\n','')
	file.close()
	if content == "":
		
		return
	var scores = content.split(";")
	for s in scores:
		var name = s.split(',')[0]
		var score = s.split(',')[1]
		score_dict[name] = score
		

func set_score(score_to_set : int):
	score = score_to_set
	
	
func _set_name(name_to_set: String):
	player_name = name_to_set
	name_set = true
	var name_setting : Node = $SettingName
	name_setting.queue_free()
	score_board_node._set_visible()


func save_scores():
	var file : FileAccess = FileAccess.open("res://save_game.txt", FileAccess.WRITE)
	var to_store : String = ""
	
	if len(score_dict) == 0: #fisrt score to be stored
		to_store = player_name+","+str(score)
	else:
		score_dict[player_name] = score
		for name in score_dict.keys():
			to_store+=name+','+str(score_dict[name])+';'
		to_store = to_store.left(to_store.length() -1)
	score_board_node.set_score_board(score_dict)
	
	file.store_string(to_store)
	file.close()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
