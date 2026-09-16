extends Node2D

@onready var tile_map_layer: TileMapLayer = $arena_tiles

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

func _ready() -> void:
	time = 0.0;
	grace_period = .04
	delay = .01
	bpm = 120.0
	duration = 60.0/bpm
	on_beat = false;
	for y in range(MIN_Y, MAX_Y):
		for x in range(MIN_X, MAX_X):
			tile_map_layer.set_cell(Vector2i(x, y), 0, Vector2i(6, 2))

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

	if (time <= grace_period || time >= duration - grace_period):
		on_beat = true
	else:
		on_beat = false

	
