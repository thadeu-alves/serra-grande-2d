extends Node2D

@onready var interaction_area = $InteractionArea
@onready var dialogue = preload("res://Scenes/Mini Games/Mini Game 1/mini_game_1.tscn")
@onready var player = get_parent().get_node("Player")
@export var text : String = "Teste de Dialogo"
var current_dialogue

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	

func _physics_process(delta):
	if Input.is_action_just_pressed("esc"):
		player.is_dialogue = false

func _on_interact():
	print("INICIANDO DIALOGO")
	var new_dialogue = ResourceLoader.load("res://Scenes/Components/Dialogue System/Dialogue.tscn")
	if new_dialogue:
		current_dialogue = new_dialogue.instantiate()
		current_dialogue.text = text
		player.is_dialogue = true
		get_tree().root.add_child(current_dialogue) 
	else:
		print("Falha ao carregar a cena")
