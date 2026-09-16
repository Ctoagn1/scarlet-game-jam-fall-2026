extends AnimatedSprite2D

@export var tile_map_layer: TileMapLayer
enum BULLET_TYPE {DOWN}

var pos: Vector2i
var type: BULLET_TYPE

	


func spawn(type: BULLET_TYPE, start_pos: Vector2i):
	pos = start_pos
	global_position = pos
	type = type
	
func on_beat():
	if type == BULLET_TYPE.DOWN:
		var oldpos = pos
		pos = Grid.move_down(pos)
		print_debug(pos)
		global_position = Grid.map_to_local(pos)
		print_debug(global_position)
		print_debug("moved!")
		if(oldpos == pos):
			print_debug("despawned")
			self.queue_free()
