extends Control


onready var transitions: AnimationPlayer = get_node("TransitionPlayer")
onready var left_bar_container: VBoxContainer = get_node("Left Side Bar/Left Bar Container")
onready var button_click_sfx: AudioStreamPlayer = left_bar_container.get_node("ButtonClickSFX")
onready var ui_select_sfx: AudioStreamPlayer = left_bar_container.get_node("UISelectSFX")


func _ready():
	for button in left_bar_container.get_children():
		if button is Button:
			button.connect("mouse_entered", self, "on_button_mouse_entered", [button])
			button.connect("mouse_exited", self, "on_button_mouse_exited", [button])
			button.connect("button_down", self, "on_button_down", [button])
			button.connect("button_up", self, "on_button_up", [button])
	yield(get_tree().create_timer(1.5), "timeout")
	transitions.play_backwards("Transition")
	AudioPlayer.play()


func on_button_mouse_entered(button: Button) -> void:
	ui_select_sfx.play()
	var animations: AnimationPlayer = button.get_node("Animations") as AnimationPlayer
	animations.play("Hover")


func on_button_mouse_exited(button: Button) -> void:
	var animations: AnimationPlayer = button.get_node("Animations") as AnimationPlayer
	animations.play_backwards("Hover")


func on_button_down(button: Button) -> void:
	var tween: Tween = button.get_node("Tween") as Tween
	tween.interpolate_property(button.get_node("ButtonBackground"), "self_modulate",
	 Color.white, Color.darkgray, 0.2)
	tween.start()


func on_button_up(button: Button) -> void:
	var tween: Tween = button.get_node("Tween") as Tween
	var button_background = button.get_node("ButtonBackground")
	var circle_animations: AnimationPlayer = button.get_node("CircleAnimations") as AnimationPlayer
	tween.interpolate_property(button_background, "self_modulate",
	 Color.darkgray, Color.white, 0.2)
	tween.start()
	if button.is_hovered():
		button_click_sfx.play()
		button_background.get_node("Circle").global_position = get_global_mouse_position()
		circle_animations.play("CircleClick")


func _on_QuitButton_pressed() -> void:
	get_tree().quit()


func _on_StartButton_pressed() -> void:
	yield(get_tree().create_timer(0.2), "timeout")
	transitions.play("Transition")
	yield(transitions, "animation_finished")
	AudioPlayer.stream_paused = true
	get_tree().change_scene("res://Scenes/Core/StartGame.tscn")
