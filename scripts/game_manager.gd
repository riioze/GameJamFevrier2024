class_name GameManager extends Node

@onready var stuff_manager : StuffManager = $stuffs
@onready var sanity_manager : SanityManager = $sanity
@onready var round_manager : RoundManager = $rounds
@onready var score_manager : ScoreManager = SceneManager.score
@onready var hands_manager : HandsManager = $hands

@onready var clock : Clock = $hands/RightArm/Hand/HandSprite/Clock
@onready var eyes : Eyes = $Transitions/Eyes
@onready var bite : Bite = $Transitions/Bite

func _ready():
	round_manager.new_round()
	
func loose_condition() -> bool:
	return sanity_manager.sanity < sanity_manager.min_sanity

func process_round():
	hands_manager.activate(false)
	await TimeManager.sleep(round_manager.recognition_duration)
	await eyes.close()
	stuff_manager.scramble_stuff(round_manager.moving_stuff_count)
	clock.reset()
	hands_manager.activate(true)
	await eyes.open()
	await clock.run_clock(round_manager.recognition_duration)
	stuff_manager.check_stuff_list_positions()
	
	if loose_condition():
		loose()
		return
	
	await bite.close()
	round_manager.new_round()

func loose():
	print("You loose")
	SceneManager.load_score()
	
