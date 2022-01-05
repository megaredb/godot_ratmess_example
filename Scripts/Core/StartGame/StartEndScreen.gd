extends Control


onready var video_player: VideoPlayer = get_node("VideoPlayer")
onready var animations: AnimationPlayer = get_node("Animations")

var starting_video = preload("res://Resources/Videos/Starting.ogv")
var ending_video = preload("res://Resources/Videos/Ending.ogv")

var starting = true

func _ready():
	yield(get_tree().create_timer(2), "timeout")
	if starting:
		play_start()
	else:
		play_ending()


func play_start() -> void:
	if video_player.is_playing():
		video_player.stop()
	animations.play("Opening")
	video_player.stream = starting_video
	video_player.play()

func play_ending() -> void:
	if video_player.is_playing():
		video_player.stop()
	animations.play("Opening")
	video_player.stream = ending_video
	video_player.play()
