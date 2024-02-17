extends Node

var root
var main : Node
var game : Node :
	get : return main.get_node("game")
var score : Node :
	get : return main.get_node("score")
	
var web : bool = false

func _ready() -> void:
	if(OS.get_distribution_name() == ""): web = true
	root = get_tree().root
	main = root.get_node("main")
