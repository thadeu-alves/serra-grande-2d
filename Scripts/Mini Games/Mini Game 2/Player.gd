extends RigidBody2D

@export var player_id = 1
@onready var ray_cast_2d = $RayCast2D

var left_key 
var right_key
var jump_key

func _ready():
	lock_rotation = true
	left_key = "left" if player_id == 1 else "a_left"
	right_key = "right" if player_id == 1 else "a_right"
	jump_key = "up" if player_id == 1 else "a_up"

func _physics_process(delta):
	var direction = Input.get_axis(left_key, right_key)
	linear_velocity.x = direction * 400
	
	if Input.is_action_just_pressed(jump_key): #and ray_cast_2d.is_colliding():
		apply_impulse(Vector2(0, -400))
