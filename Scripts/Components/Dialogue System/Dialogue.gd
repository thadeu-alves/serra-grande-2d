extends Node2D

@onready var label = $Camera2D/Control/Label
var text
signal response_received

func _ready():
	label.text = text

func _physics_process(delta):
	if Input.is_action_just_pressed("esc"):
		response_received.emit(false)
		queue_free()
	elif Input.is_action_just_pressed("space"):
		response_received.emit(true)
		queue_free()

func get_response():
	return await response_received
