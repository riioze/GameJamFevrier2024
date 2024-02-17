extends Node

@onready var stuff_manager : StuffManager = $stuffs
@onready var sanity_manager : SanityManager = $sanity
@onready var eyes : Eyes = $Eyes

var recognition_phase_duration: float = 3
var ordering_phase_duration: float = 1
var black_screen_duration: float = 1

func _ready():
	process_round()
	
func loose_condition() -> bool:
	return sanity_manager.sanity < sanity_manager.min_sanity

func process_round():
	stuff_manager.round_setup()
	await TimeManager.sleep(recognition_phase_duration)
	await eyes.close()
	stuff_manager.scramble_stuff(2)
	await eyes.open()
	await TimeManager.sleep(ordering_phase_duration)
	stuff_manager.check_stuff_list_positions()
	
	if loose_condition():
		loose()
		return

func loose():
	print("You loose")
