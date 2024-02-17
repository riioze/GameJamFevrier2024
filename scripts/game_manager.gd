extends Node

@onready var stuff_manager : StuffManager = $stuffs
@onready var sanity_manager : SanityManager = $sanity

var recognition_phase_duration: float = 1
var ordering_phase_duration: float = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	process_round()
	
func loose_condition() -> bool:
	return sanity_manager.sanity < sanity_manager.min_sanity

func process_round():
	stuff_manager.round_setup()
	await TimeManager.sleep(recognition_phase_duration)
	stuff_manager.scramble_stuff(2)
	await TimeManager.sleep(ordering_phase_duration)
	stuff_manager.check_stuff_list_positions()
	
	if loose_condition():
		loose()
		return

func loose():
	print("You loose")
