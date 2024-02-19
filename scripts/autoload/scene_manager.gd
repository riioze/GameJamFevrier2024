extends Node

var root
var main : Node
var menu : MenuManager
var game : GameManager
var score : ScoreManager
var credits : Credits
	
var web : bool = false

var game_scene = preload("res://scenes/game.tscn")
var menu_scene = preload("res://scenes/menu.tscn")
var score_scene = preload("res://scenes/score.tscn")
var credits_scene = preload("res://scenes/credits.tscn")

func _ready() -> void:
	if(OS.get_distribution_name() == ""): web = true
	root = get_tree().root
	main = root.get_node("main")
	
	load_menu()
	
func unload_scene(scene) -> void:
	if (scene != null):
		scene.queue_free()
		
func load_menu():
	unload_scene(score)
	unload_scene(credits)
	unload_scene(game)
	
	menu = menu_scene.instantiate()
	add_child(menu)
	
func load_credit():
	unload_scene(menu)

	credits = credits_scene.instantiate()
	add_child(credits)
	
func load_game():
	#unload_scene(menu)
	unload_scene(score)
	
	game = game_scene.instantiate()
	add_child(game)
	
func load_score():
	score = score_scene.instantiate()
	score.set_score(game.score)
	unload_scene(game)
	add_child(score)
