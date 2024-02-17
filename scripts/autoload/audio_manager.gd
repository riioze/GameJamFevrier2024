extends Node

var sound_r = preload("res://scenes/sound.tscn")
var sounds_node
var music_node
var sound_path = "res://audio/sounds/"

var default_music_volume
var isMute = false

var music_bus
#var music_pitch_effect

var music = preload("res://audio/musics/Ost.wav")

func _ready():
	music_bus = AudioServer.get_bus_index("Music")
	#music_pitch_effect = AudioServer.get_bus_effect(music_bus, 0)
	
	var audio_node = SceneManager.main.get_node("Audio")
	sounds_node = audio_node.get_node("Sounds")
	music_node  = audio_node.get_node("Music")
	default_music_volume = music_node.volume_db
	start_game_music()
	
func play(clip_name, count = 1, time = 0,db = 1):
	var s = sound_r.instantiate()
	sounds_node.add_child(s)
	
	var clip = sound_path + clip_name
	
	if(count > 1):
		var clips = []
		for i in range(count):
			clips.append(clip_name + str(i+1))
		clip = sound_path + clips.pick_random() + ".wav"
		
	s.play_clip(clip, time)
	s.volume_db = db
	
	return s

func mute_music():
	music_node.volume_db = default_music_volume if isMute else -80
#	muteButton.texture = muteSprite if isMute else unMuteSprite
	isMute = !isMute

func start_game_music():
	music_node.stream = music
	#set_music_speed(1)
	music_node.play()
	
#func set_music_speed(speed):
	#music_node.pitch_scale = speed
	#music_pitch_effect.pitch_scale = 1/speed
