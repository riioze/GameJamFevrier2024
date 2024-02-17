class_name Eyes extends Sprite2D

var closed_duration = 1

func close() -> bool:
	visible = true
	await TimeManager.sleep(closed_duration)
	return true

func open() -> bool:
	await TimeManager.sleep(closed_duration)
	visible = false
	return true
