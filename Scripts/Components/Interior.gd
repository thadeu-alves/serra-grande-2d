class_name Interior
extends Node2D

@onready var player = $Player

func _ready():
	player.is_inside = true
