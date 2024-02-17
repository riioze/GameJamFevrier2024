extends Node

var root
var main : Node
var menu : MenuManager
var game : GameManager
var score : ScoreManager
	
var web : bool = false

var game_scene = preload("res://scenes/game.tscn")
var menu_scene = preload("res://scenes/menu.tscn")
var score_scene = preload("res://scenes/score.tscn")

func _ready() -> void:
	if(OS.get_distribution_name() == ""): web = true
	root = get_tree().root
	main = root.get_node("main")
	
	load_menu()
	
func load_menu():
	menu = menu_scene.instantiate()
	add_child(menu)
	
func load_game():
	menu.queue_free()
	game = game_scene.instantiate()
	add_child(game)
	
func load_score():
	score = score_scene.instantiate()
	score.set_score(10)
	game.queue_free()
	add_child(score)
