extends CharacterBody2D

var enemy_colided = false
var bullet_damage = 20

func _physics_process(delta):
	position += Vector2(delta * 300, 0)
	
	if position.x > 600 or enemy_colided:
		queue_free()
	
	bullet_damage = (get_parent().points*5) + 10
	if bullet_damage>=50:
		bullet_damage = 50


func _on_area_2d_body_entered(body):
	if body is EnemyMG1:
		enemy_colided = true
		print("bullet damage: ", bullet_damage)
		body.hit(bullet_damage)
