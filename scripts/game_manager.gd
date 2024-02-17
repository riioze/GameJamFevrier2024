class_name GameManager extends Node

@onready var stuff_manager : StuffManager = $stuffs
@onready var sanity_manager : SanityManager = $sanity
@onready var eyes : Eyes = $Eyes
@onready var round_manager : RoundManager = $rounds
@onready var score_manager : ScoreManager = SceneManager.score
@onready var clock : Clock = $hands/LeftArm/Hand/HandSprite/Clock

#var recognition_phase_duration: float = 3
#var ordering_phase_duration: float = 3
#var black_screen_duration: float = 0.5

func _ready():
	round_manager.new_round()
	
func loose_condition() -> bool:
	return sanity_manager.sanity < sanity_manager.min_sanity

func process_round():
	await TimeManager.sleep(round_manager.recognition_duration)
	await eyes.close()
	stuff_manager.scramble_stuff(round_manager.moving_stuff_count)
	await eyes.open()
	await clock.run_clock(round_manager.recognition_duration)
	stuff_manager.check_stuff_list_positions()
	
	if loose_condition():
		loose()
		return
		
	round_manager.new_round()

func loose():
	print("You loose")
	SceneManager.load_score()
	
