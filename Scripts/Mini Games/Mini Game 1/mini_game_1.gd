extends Node2D

@onready var label = $Control/Label
@onready var label_2 = $Control/Label2
@onready var sfx_dead = $sfx_dead
@onready var sfx_enemy_dead = $sfx_enemy_dead

var enemy = preload("res://Scenes/Mini Games/Mini Game 1/enemy_plane.tscn")
var world = preload("res://Scenes/world.tscn")
var can_spawn = true
var points
var time_spawn
var enemy_speed = 200

func _ready():
	points = 0
	print("MINI GAME INICIADO")
	time_spawn = 0

func _physics_process(delta):
	if can_spawn:
		spawn_enemy() 
	
	label.text = str("Points: ", points)
	
	if Input.is_action_just_pressed("esc"):
		queue_free()
	
	if points == 0:
		time_spawn = 5
	elif time_spawn<=0.5:
		time_spawn = 0.5
	
	label_2.text = str(time_spawn)

func spawn_enemy():
	can_spawn = false
	
	await get_tree().create_timer(time_spawn).timeout
	var new_enemy = enemy.instantiate()
	new_enemy.position = Vector2(600, randi_range(40, 250))
	add_child(new_enemy.duplicate())
	can_spawn = true

func set_timer():
	time_spawn-=1

func player_dead():
	sfx_dead.play()

func enemy_dead():
	sfx_enemy_dead.play()
