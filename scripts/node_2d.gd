extends Node2D

@onready var tile_map_layer: TileMapLayer = $arena_tiles

func _ready() -> void:
	for y in range(-7, 7):
		for x in range(-15, 14):
			tile_map_layer.set_cell(Vector2i(x, y), 0, Vector2i(6, 2))
