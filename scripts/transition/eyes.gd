class_name Eyes extends AnimatedSprite2D

var closed_duration = 1

func close() -> bool:
	visible = true
	play("close")
	await TimeManager.sleep(1.5)
	return true

func open() -> bool:
	play("open")
	await TimeManager.sleep(1.5)
	visible = false
	return true
