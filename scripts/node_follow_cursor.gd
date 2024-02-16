class_name NodeFollowCursor extends Node2D

@export var active : bool = true
@export_range(0,1) var follow_speed : float = 0.5

@onready var parent: Node = get_parent()
	
func _process(delta) -> void:
	if active : _follow_cursor()

func _follow_cursor() -> void:
	parent.global_position = lerp(parent.global_position,get_global_mouse_position(),follow_speed)
