extends Node2D

@onready var floor = $Floor
@onready var ball = $ball
var newBall = preload("res://Scenes/Mini Games/Mini Game 2/ball.tscn")

func _physics_process(delta):
	if Input.is_action_just_pressed("esc"):
		queue_free()

func _on_floor_body_entered(body):
	if body is ball_MG2:
		reset_ball()

func reset_ball():
	if ball:
		ball.call_deferred("queue_free")
	
	var newOne = newBall.instantiate()
	call_deferred("add_child", newOne)
	ball = newOne
	ball.position = Vector2(300, 0)
