@tool
extends Node3D

var distance = 0

@onready var ground_scene = load('res://scenes/assets/train_terrain.tscn')
@onready var rail_scene = load('res://scenes/assets/rail_scene.tscn')
@export var player : Node3D

@export var starting_length: int = 8
@export var spawn_when_within: int = 5
@export var space_between_parts: int = 35

@export var random_rotation: bool = false

@export var reset : bool = true

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
	var new_rail = rail_scene.instantiate()
	new_terrain.position = Vector3(0,0,distance*space_between_parts)
	new_rail.position = Vector3(0,0,distance*35)
	new_terrain.name = 'Ground'+str(distance)
	new_rail.name = 'Ground'+str(distance)
	if randi_range(0,1) == 1 and random_rotation:
		new_terrain.rotation_degrees.y = 180
	add_child(new_terrain)
	add_child(new_rail)
	new_terrain.set_owner(self)
	new_rail.set_owner(self)
	distance+=1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.position.z > (distance-spawn_when_within)*space_between_parts:
		new_piece()
		if distance > spawn_when_within*2:
			get_child(0).queue_free()
	if Engine.is_editor_hint() and reset == true:
		reset = false
		distance = 0
		make_railroad()
