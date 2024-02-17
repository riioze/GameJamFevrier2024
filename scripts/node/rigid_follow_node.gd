class_name RigidFollowNode extends Node

@onready var parent : RigidBody2D = get_parent()
@export var followed : Node2D
@export var speed : float = 1000
@export var active : bool = true
@export var approximation_distance : float = 20
@export_range(0,1) var acceleration : float = 0.5

func _physics_process(delta):
	if active and followed != null:
		_follow(delta)
	
func _follow(delta : float) -> void:
	var pos1 = parent.global_position
	var pos2 = followed.global_position
	var distance = pos1.distance_to(pos2)
	var target_velocity : Vector2 = Vector2.ZERO
	
	if approximation_distance < distance:
		var diretion : Vector2 = pos1.direction_to(pos2)
		target_velocity = diretion * distance * speed * delta
	
	parent.linear_velocity = lerp(parent.linear_velocity, target_velocity, acceleration)
