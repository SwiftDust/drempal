class_name MusicPlayer extends AudioStreamPlayer


const gameloop_music = preload("res://Cosmetics/Music/gameloop.wav")


func _play_music(music: AudioStream, volume = 0.0):
	if stream == music: return
	
	stream = music
	volume_db = volume

	play()


func play_gameloop_music():
	_play_music(gameloop_music)
	
