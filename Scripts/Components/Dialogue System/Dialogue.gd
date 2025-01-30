extends Node2D

@onready var label = $Camera2D/Control/Label
var text

func _physics_process(delta):
	if Input.is_action_just_pressed("esc"):
		queue_free()
	label.text = text
