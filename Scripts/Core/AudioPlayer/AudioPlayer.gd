extends AudioStreamPlayer


onready var music_pack = {"calm": [load("res://Resources/Sounds/Music/calm_1.mp3")]}
var current_theme = "calm"
var current_track = 0


func _ready():
	self.stream = music_pack.get(current_theme)[current_track]


func set_track_to(theme: String, index: int) -> void:
	self.stop()
	self.stream = music_pack.get(theme)[index]


func next_track() -> void:
	self.stop()
	var theme_tracks = music_pack.get(current_theme)
	if len(theme_tracks) - 1 < current_track + 1:
		current_track = 0
	else:
		current_track += 1
	self.stream = music_pack.get(current_theme)[current_track]


func set_theme_to(theme) -> void:
	self.stop()
	current_theme = theme
	self.stream_paused = music_pack.get(current_theme)[current_track]


func _on_AudioPlayer_finished() -> void:
	next_track()
	play()
