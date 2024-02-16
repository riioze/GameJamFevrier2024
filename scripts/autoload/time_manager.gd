extends Node

func sleep(s: float) -> bool: # s is seconds
	await get_tree().create_timer(s).timeout
	return true
