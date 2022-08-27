tool
extends Position2D



func _process(_delta):
	self.set_position(self.get_parent().decayposition)
	pass # Replace with function body.


