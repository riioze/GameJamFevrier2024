class_name Bite extends AnimatedSprite2D

var closed_duration = 1
var disolve: bool = false
var transparency : float = 1.0
@onready var day_label : Label = $Day

func _process(delta):
	if disolve:
		transparency = lerp(transparency,0.0,0.2)
		modulate.a = int(255 * transparency)
	
func close() -> bool:
	modulate.a = 255
	visible = true
	play("close")
	AudioManager.play("BiteSound.mp3")
	await TimeManager.sleep(2)
	day_label.visible = true
	day_label.text = str(SceneManager.game.round_manager.day + 1)
	
	SceneManager.unload_scene(SceneManager.menu)
	SceneManager.game.round_manager.new_round()
	#disolve = true
	await TimeManager.sleep(1)
	day_label.visible = false
	visible = false
	return true
