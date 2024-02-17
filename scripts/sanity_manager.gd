class_name SanityManager extends Node

@export var max_sanity : float = 100
@export_range(0,100) var sanity : float = 50 
@export_range(0,100) var min_sanity : float = 20

@export var grade_list : Array[Grade] = []

@export var full_bar_size : float = 1000
@onready var bar : Node2D = $Bar

func _ready():
	var stuff_manager : StuffManager = SceneManager.game.get_node("stuffs")
	stuff_manager.incr_sanity_signal.connect(incr_sanity)
	
func incr_sanity(grade : Grade):
	sanity += grade.sanity_value
	sanity = clamp(sanity,0,max_sanity)
	update_bar()
	
func update_bar():
	bar.scale.x = full_bar_size * sanity / max_sanity
