class_name RoundManager extends Node

var round : int = 0
@onready var game_manager : GameManager = SceneManager.game

func new_round():
	round += 1
	game_manager.stuff_manager.round_setup()
	game_manager.process_round()
