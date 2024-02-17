class_name ScoreManager extends Node

var score_node: Node

var score_dict = {}
var in_score : bool
var score : int = 13
var player_name : String = "test2"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func init():
	score_node = $"Score"
	in_score = true
	load_scores()
	save_score()

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
		


func save_score():
	var file : FileAccess = FileAccess.open("res://save_game.txt", FileAccess.WRITE)
	var to_store : String = ""
	
	if len(score_dict) == 0: #fisrt score to be stored
		to_store = player_name+","+str(score)
	else:
		score_dict[player_name] = score
		for name in score_dict.keys():
			to_store+=name+','+str(score_dict[name])+';'
			print(to_store)
		to_store = to_store.left(to_store.length() -1)
		
	print(to_store)
	file.store_string(to_store)
	file.close()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
