extends CharacterBody2D
class_name EnemyMG1

@export var health := 100

func _physics_process(delta):
	position.x -= get_parent().enemy_speed * delta
	rotation += 2 * delta  # Gira suavemente no próprio eixo
	
	if position.x < 0:
		queue_free()
	
	if health <= 0:
		get_parent().enemy_dead()
		get_parent().enemy_speed = get_parent().enemy_speed + 5
		print("new speed: ", get_parent().enemy_speed)
		get_parent().points += 1
		get_parent().set_timer()
		queue_free()
	

func hit(damage):
	health -= damage
