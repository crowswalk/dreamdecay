tool
extends Line2D


func _process(_delta):
	self.set_position(Vector2(self.get_parent().decayX, self.get_parent().decayY))

	pass # Replace with function body.


