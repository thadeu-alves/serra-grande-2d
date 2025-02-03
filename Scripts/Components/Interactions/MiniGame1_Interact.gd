extends Node2D

@onready var interaction_area = $InteractionArea
@onready var player = get_parent().get_node("Player")
@onready var label = $Label

var can_interact = false

func _ready():
	label.hide()

func _physics_process(delta):
	if Input.is_action_just_pressed("interact") and can_interact:
		interact()

func interact():
	print("DIALOGO")
	var new_dialogue = ResourceLoader.load("res://Scenes/Components/Dialogue System/Dialogue.tscn")
	if new_dialogue:
		var dialogue = new_dialogue.instantiate()
		dialogue.text = "preciso de ajuda"
		player.is_dialogue = true
		get_tree().root.add_child(dialogue)
		var response = await dialogue.get_response() 
		if response:
			print("MUDANDO DE CENA")
			
			player.is_transition = true
			FadeTransition.transition()
			await FadeTransition._transition_finished
			#await get_tree().create_timer(2).timeout
			
			
			ScenesManager.change_scene("res://Scenes/Mini Games/Mini Game 1/world.tscn")
			player.is_dialogue = false
			player.is_gaming = true 
		else:
			player.is_dialogue = false
	else:
		return

func display_label():
	label.global_position.y = global_position.y
	label.global_position.y -= 35
	label.show()

func undisplay_label():
	label.hide()

func _on_interaction_area_body_entered(body):
	if body is Player:
		display_label()
		can_interact = true


func _on_interaction_area_body_exited(body):
	can_interact = false
	undisplay_label()
