extends Label


	
func _process(_delta) -> void:
	if(Grid.is_on_beat()):
		self.text = "YES!!!"
	else:
		self.text = "NO!!!"
		
	
