extends Node2D

@export var cycle_time: float = 1

@export_category("Timing in seconds (halved)")
@export var perfect_timing: float = 0.04 # they would have a 0.08 second window 
@export var good_timing: float = 0.08 # cumulative so its from 0.08 to 0.24
@export var okay_timing: float = 0.08
@export var bad_timing: float = 0.08

@onready var cycle_timer: Timer = $cycle_timer
@onready var boss_image: Sprite2D = $boss_image


func _ready() -> void:
	cycle_timer.wait_time = cycle_time
	cycle_timer.timeout.connect(_on_cycle_timeout)
	
func _process(_delta: float) -> void:
	# to calculate the time before/after the beat when you clicked
	var time_to_beat = cycle_timer.time_left
	var time_since_beat = cycle_timer.wait_time - cycle_timer.time_left
	var distance_from_beat = min(time_to_beat, time_since_beat)
	
	if distance_from_beat <= perfect_timing:
		boss_image.self_modulate = Color(0.0, 0.0, 0.793, 1.0)
		boss_image.scale = Vector2(1.2, 1.2)
	elif distance_from_beat <= perfect_timing + good_timing:
		boss_image.self_modulate = Color(0.2, 0.8, 0.2, 1.0)
		boss_image.scale = Vector2(1, 1)
		
	elif distance_from_beat <= perfect_timing + good_timing + okay_timing:
		boss_image.self_modulate = Color(0.645, 0.645, 0.0, 1.0) 
		
	elif distance_from_beat <= perfect_timing + good_timing + okay_timing + bad_timing:
		boss_image.self_modulate = Color(0.617, 0.355, 0.0, 1.0)
		
	else:
		boss_image.self_modulate = Color(0.527, 0.0, 0.0, 1.0)
	
# its space bar to click for now
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Temp click"):
		var time_to_beat = cycle_timer.time_left
		var time_since_beat = cycle_timer.wait_time - cycle_timer.time_left
		var distance_from_beat = min(time_to_beat, time_since_beat)
		
		var rating: String
		
		if distance_from_beat <= perfect_timing:
			rating = "Perfect"
		elif distance_from_beat <= perfect_timing + good_timing:
			rating = "Good"
		elif distance_from_beat <= perfect_timing + good_timing + okay_timing:
			rating = "Okay"
		elif distance_from_beat <= perfect_timing + good_timing + okay_timing + bad_timing:
			rating = "Bad"
		else:
			rating = "Miss"
			
		print("Hit rating: ", rating, " (timing: ", distance_from_beat, ")")
		
		EventBus.timing_evalution.emit(rating)

func _on_cycle_timeout() -> void:
	EventBus.world_tick.emit()
