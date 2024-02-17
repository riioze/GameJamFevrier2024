class_name NodeFollowNode extends Node

@onready var parent : Node2D = get_parent()
@export var followed : Node2D
#@export var speed : float = 1000
@export var active : bool = true
@export var approximation_distance : float = 20
@export_range(0,1) var speed : float = 0.5

func _physics_process(delta):
	if active and followed != null:
		_follow(delta)
	
func _follow(delta : float) -> void:
	var distance : float = parent.position.distance_to(followed.position)
	if(distance > approximation_distance):
		parent.position = lerp(parent.position, followed.position, speed)
