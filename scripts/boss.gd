extends AnimatedSprite2D

var parent_node
enum BULLET_TYPE {DOWN}
var bullet = preload("res://bullet.tscn")
func _ready() -> void:
	parent_node = get_parent()
	global_position = Grid.map_to_local(Vector2i(0, -5))
	spawn_bullet()

func spawn_bullet() -> void:
	var newbullet = bullet.instantiate()
	newbullet.spawn(BULLET_TYPE.DOWN, Vector2i(0, 0))
	Grid.beat.connect(newbullet.on_beat)
	add_child(newbullet)
