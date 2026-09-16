extends AnimatedSprite2D

@export var TILEMAP: TileMapLayer
var pos = Vector2i(0, 0)
var parent_node

var moved = false;

func _ready() -> void:
	global_position = TILEMAP.map_to_local(Vector2i(0, 0))
	parent_node = get_parent()
	
func _process(_delta: float) -> void:

	if(parent_node.is_on_beat() && !moved):
		if Input.is_action_pressed("DownLeft"):
			if parent_node.in_bounds(pos + (Vector2i(-1, 1) if (pos.x % 2 == 0) else Vector2i(-1, 0))):
				pos = pos + (Vector2i(-1, 1)  if (pos.x % 2 == 0) else Vector2i(-1, 0))
				moved = true
		elif Input.is_action_pressed("UpLeft"):
			if parent_node.in_bounds(pos + (Vector2i(-1, 0) if (pos.x % 2 == 0) else Vector2i(-1, -1))):
				pos = pos + (Vector2i(-1, 0) if (pos.x % 2 == 0) else Vector2i(-1, -1))
				moved = true
		elif Input.is_action_pressed("UpRight"):
			if parent_node.in_bounds(pos + (Vector2i(1, 0) if (pos.x % 2 == 0) else Vector2i(1, -1))):
				pos = pos + (Vector2i(1, 0) if (pos.x % 2 == 0) else Vector2i(1, -1))
				moved = true
		elif Input.is_action_pressed("DownRight"):
			if parent_node.in_bounds(pos + (Vector2i(1, 1) if (pos.x % 2 == 0) else Vector2i(1, 0))):
				pos = pos + (Vector2i(1, 1) if (pos.x % 2 == 0) else Vector2i(1, 0))
				moved = true
		elif Input.is_action_pressed("Up"):
			if parent_node.in_bounds(pos + (Vector2i(0, -1))):
				pos = pos + (Vector2i(0, -1))
				moved = true
		elif Input.is_action_pressed("Down"):
			if parent_node.in_bounds(pos + Vector2i(0, 1)):
				pos = pos + Vector2i(0, 1)
				moved = true
		global_position = TILEMAP.map_to_local(pos)
	else:
		if Input.is_action_pressed("Down") || Input.is_action_pressed("Up") || Input.is_action_pressed("Left") || Input.is_action_pressed("Right"):
			print_debug("boo you suck at timing")
		if (!parent_node.is_on_beat()):
			print_debug("can move again")
			moved = false
		
