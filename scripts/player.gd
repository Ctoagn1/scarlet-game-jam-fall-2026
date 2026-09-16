extends AnimatedSprite2D

var pos = Vector2i(0, 0)


var moved = false;

var t = 0;
var in_motion = false;
var newpos = Vector2i(0, 0)
var oldpos = global_position

func _ready() -> void:
	global_position = Grid.map_to_local(Vector2i(0, 0))

	
func _physics_process(delta: float) -> void:
	if(in_motion):
		t += delta *7.5
		global_position = oldpos.lerp(newpos, t)
		if(t >= 1):
			in_motion = false;
			oldpos = newpos
			t = 0;
		
func _process(_delta: float) -> void:

	if(Grid.is_on_beat() && !moved):
		if Input.is_action_pressed("DownLeft"):
				pos = Grid.move_down_left(pos)
				moved = true
		elif Input.is_action_pressed("UpLeft"):
				pos = Grid.move_up_left(pos)
				moved = true
		elif Input.is_action_pressed("UpRight"):
				pos = Grid.move_up_right(pos)
				moved = true
		elif Input.is_action_pressed("DownRight"):
				pos = Grid.move_down_right(pos)
				moved = true
		elif Input.is_action_pressed("Up"):
				pos = Grid.move_up(pos)
				moved = true
		elif Input.is_action_pressed("Down"):
				pos = Grid.move_down(pos)
				moved = true
		if (moved):	
			in_motion = true;
			oldpos = global_position
			newpos = Grid.map_to_local(pos)
	else:
		if Input.is_action_pressed("Down") || Input.is_action_pressed("UpLeft") || Input.is_action_pressed("DownLeft") || Input.is_action_pressed("UpRight") || Input.is_action_pressed("Up") || Input.is_action_pressed("UpLeft"):
			moved = true
		elif (!Grid.is_on_beat()):
			moved = false
		
