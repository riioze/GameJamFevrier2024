extends Node2D

@export var joints : Array[Node2D]

func _process(delta):
	var pos1 : Vector2 = joints[0].global_position
	var pos2 : Vector2 = joints[1].global_position
	
	global_position = (pos1 + pos2) * (0.5)
	#var direction : Vector2 = pos1.global_position.direction_to(pos2)
	rotation = pos1.angle_to(pos2)
