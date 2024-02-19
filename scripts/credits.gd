class_name Credits extends Node 

func _input(event):
	if event.is_action_pressed("Confirm") or event.is_action_pressed("Back"):
		SceneManager.load_menu()
