@tool
extends Node3D

var distance = 0

@onready var ground_scene = load('res://scenes/assets/train_terrain.tscn')

@export var player : Node3D
@export var starting_length = 8
@export var spawn_when_within = 5

func _ready():
	make_railroad()
# Called when the node enters the scene tree for the first time.
func make_railroad():
	for each in get_children():
		each.queue_free()
	for x in range(0,starting_length):
		new_piece()
		

func new_piece():
	var new_terrain = ground_scene.instantiate()
	new_terrain.position = Vector3(0,0,distance*35)
	new_terrain.name = 'Ground'+str(distance)
	add_child(new_terrain)
	new_terrain.set_owner(self)
	distance+=1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.position.z > (distance-spawn_when_within)*35:
		new_piece()
		get_child(0).queue_free()
		
