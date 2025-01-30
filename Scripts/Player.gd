extends CharacterBody2D
class_name Player

@onready var animated_sprite_2d = $AnimatedSprite2D
@export var SPEED = 100
@onready var sfx_walking = $sfx_walking
@onready var camera_2d = $Camera2D

var is_walking = false
var is_transition = false
var is_gaming = false
var is_dialogue = false

func _physics_process(delta):
	var direction = Vector2.ZERO
	if not is_transition and not is_gaming and not is_dialogue:
		direction = Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up"))
	
	if direction == Vector2.ZERO:
		animated_sprite_2d.play("Idle")
	else:
		if direction.x != 0:
			animated_sprite_2d.play("walk_side")
			animated_sprite_2d.flip_h = direction.x < 0
		elif direction.y > 0:
			animated_sprite_2d.play("walk_down")
		elif direction.y < 0:
			animated_sprite_2d.play("walk_up")
	
	if direction != Vector2.ZERO:
		if not is_walking:
			sfx_walking.play()
			is_walking = true
	else:
		if is_walking:
			sfx_walking.stop()
			is_walking = false
	
	if is_transition:
		is_transition = true
		velocity = Vector2.ZERO
		animated_sprite_2d.play("Idle")
		await get_tree().create_timer(2).timeout
		is_transition = false
	
	if is_gaming or is_dialogue:
		velocity = Vector2.ZERO
		animated_sprite_2d.play("Idle")
		camera_2d.enabled = false
		$CollisionShape2D.disabled = true
	else:
		camera_2d.enabled = true
		$CollisionShape2D.disabled = false
	
	
	

	velocity = direction.normalized() * SPEED
	move_and_slide()
