extends CharacterBody2D
class_name PlanePlayer

@export var SPEED := 200
@onready var animated_sprite_2d = $AnimatedSprite2D
var bullet = preload("res://Scenes/Mini Games/Mini Game 1/bullet.tscn")
@onready var sfx_shot = $sfx_shot

func _physics_process(delta):
	var direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up"))
	
	if direction.y > 0:
		animated_sprite_2d.play("Down")
	elif direction.y < 0:
		animated_sprite_2d.play("Up")
	elif direction.x == 0:
		animated_sprite_2d.play("Idle")
	
	velocity = direction.normalized() * SPEED
	move_and_slide()
	
	if Input.is_action_just_pressed("space"):
		var new_bullet = bullet.instantiate()
		new_bullet.position = global_position + Vector2(15, 0)
		get_parent().add_child(new_bullet.duplicate())
		sfx_shot.play()


func _on_area_2d_body_entered(body):
	if body is EnemyMG1:
		get_parent().player_dead()
		queue_free()
