class_name LampLight extends Sprite2D

var alpha : float = 0 # between 0 and 1

@export_range(0,1) var alpha_min : float = 0.2
@export_range(0,1) var alpha_max : float = 0.7

@export var flicker_time_min : float = 0.7
@export var flicker_time_max : float = 1.5
var flicker_timer : float = 0

func _process(delta):
	if(flicker_timer < 0):
		flicker_timer = randf_range(flicker_time_min,flicker_time_max)
		set_alpha(randf_range(alpha_min,alpha_max))
	else: flicker_timer-=delta
	
func set_alpha(value: float):
	modulate.a = value
