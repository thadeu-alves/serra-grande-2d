extends Node2D

@onready var player = $Player
@onready var walls = $Grounds/Walls
@onready var canvas_modulate = $CanvasModulate
@export var show = false

var last_is_gaming = null  

func _ready():
	ScenesManager.current_scene = self

func _physics_process(delta):
	if Input.is_action_just_pressed("esc"):
		player.is_gaming = false
	
	if player.is_gaming != last_is_gaming:
		walls.set_layer_enabled(0, not player.is_gaming)
		visible = not player.is_gaming
		last_is_gaming = player.is_gaming  # Atualiza o último estado
