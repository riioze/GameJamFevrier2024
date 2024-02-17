class_name MenuManager extends Node

func _input(event):
	if event.is_action_pressed("Confirm"):
		SceneManager.load_game()
