class_name Bite extends AnimatedSprite2D

var closed_duration = 1
var disolve: bool = false
var transparency : float = 1.0

func _process(delta):
	if disolve:
		transparency = lerp(transparency,0.0,0.2)
		modulate.a = int(255 * transparency)
	
func close() -> bool:
	modulate.a = 255
	visible = true
	play("close")
	await TimeManager.sleep(3)
	SceneManager.game.hands_manager.activate(false)
	disolve = true
	await TimeManager.sleep(1)
	visible = false
	return true
