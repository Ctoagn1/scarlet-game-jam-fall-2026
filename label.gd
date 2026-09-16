extends Label

var parent

func _ready() -> void:
	parent = get_parent()
	
func _process(delta) -> void:
	if(parent.is_on_beat()):
		self.text = "YES!!!"
	else:
		self.text = "NO!!!"
		
	
