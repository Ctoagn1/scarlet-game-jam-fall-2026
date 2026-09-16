extends Node

const MIN_Y = -7;
const MAX_Y = 7;
const MIN_X = -15;
const MAX_X = 14;

var time;
var grace_period;
var bpm;
var duration;
var delay;
var on_beat;
var tile_map: TileMapLayer


signal beat

func _ready() -> void:
	tile_map = get_tree().current_scene.get_node("TileMapLayer")
	time = 0.0;
	print_debug(tile_map)
	grace_period = .04
	delay = .01
	bpm = 120.0
	duration = 60.0/bpm
	on_beat = false;
	for y in range(MIN_Y, MAX_Y):
		for x in range(MIN_X, MAX_X):
			tile_map.set_cell(Vector2i(x, y), 0, Vector2i(6, 2))

func map_to_local(pos: Vector2i) -> Vector2i: 
	return tile_map.map_to_local(pos)

func in_bounds(vec: Vector2i) -> bool:
	if (vec.x <= MAX_X && vec.x >= MIN_X && vec.y <= MAX_Y && vec.y >= MIN_Y):
		return true
	else:
		return false

func is_on_beat() -> bool:
	return on_beat
	
func _process(delta):
	time += delta;
	if (time > duration):
		time = 0.0;
		beat.emit()

	if (time <= grace_period || time >= duration - grace_period):
		on_beat = true
	else:
		on_beat = false
		
func move_down(pos: Vector2i) -> Vector2i:
	if Grid.in_bounds(pos + Vector2i(0, 1)):
		return pos + Vector2i(0, 1)
	else:
		return pos
		
func move_down_left(pos: Vector2i) -> Vector2i:
	if self.in_bounds(pos + (Vector2i(-1, 1) if (pos.x % 2 == 0) else Vector2i(-1, 0))):
		return pos + (Vector2i(-1, 1)  if (pos.x % 2 == 0) else Vector2i(-1, 0))
	else:
		return pos
		
func move_down_right(pos: Vector2i) -> Vector2i:
	if self.in_bounds(pos + (Vector2i(1, 1) if (pos.x % 2 == 0) else Vector2i(1, 0))):
		return pos + (Vector2i(1, 1)  if (pos.x % 2 == 0) else Vector2i(1, 0))
	else:
		return pos
		
func move_up(pos: Vector2i) -> Vector2i:
	if Grid.in_bounds(pos + Vector2i(0, -1)):
		return pos + Vector2i(0, -1)
	else:
		return pos
func move_up_right(pos: Vector2i) -> Vector2i:
	if self.in_bounds(pos + (Vector2i(1, 0) if (pos.x % 2 == 0) else Vector2i(1, -1))):
		return pos + (Vector2i(1, 0)  if (pos.x % 2 == 0) else Vector2i(1, -1))
	else:
		return pos
func move_up_left(pos: Vector2i) -> Vector2i:
	if self.in_bounds(pos + (Vector2i(-1, 0) if (pos.x % 2 == 0) else Vector2i(-1, -1))):
		return pos + (Vector2i(-1, 0)  if (pos.x % 2 == 0) else Vector2i(-1, -1))
	else:
		return pos
