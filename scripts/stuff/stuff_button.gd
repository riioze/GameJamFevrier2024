class_name StuffButton extends Stuff

@export var action_node : Node2D
@export var action_type : action = action.Play

enum action {Play, Quit, Mute, Credit}
var min_action_distance : float = 150

func let_go_bis():
	var distance = action_node.global_position.distance_to(global_position)
	if distance < min_action_distance:
		global_position = action_node.position
		await TimeManager.sleep(0.5)
		exec_action()
		
func exec_action():
	match action_type:
		action.Quit : get_tree().quit()
		_ : SceneManager.load_game()
