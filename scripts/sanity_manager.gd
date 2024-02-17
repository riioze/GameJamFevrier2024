class_name SanityManager extends Node

@export_range(0,100) var sanity : float = 50 
@export_range(0,100) var min_sanity : float = 20

@export var grade_list : Array[Grade] = []

func _ready():
	var stuff_manager : StuffManager = SceneManager.game.get_node("stuffs")
	stuff_manager.incr_sanity_signal.connect(incr_sanity)
	
func incr_sanity(grade : Grade):
	sanity += grade.sanity_value
	print(grade.name, sanity)
	
