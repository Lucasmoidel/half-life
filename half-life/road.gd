@tool
extends Path3D

func _ready():
	var points = curve.get_baked_length()
	
	var tween = create_tween()
	for each in range(0,points,int(points/10)):
		print(each)
		tween.tween_property(get_node("follower"),'progress',each,points/1000)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#curve.get_point_position(1)
