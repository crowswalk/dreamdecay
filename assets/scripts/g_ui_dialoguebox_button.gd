extends MarginContainer
export var normalColor : Color
export var selectedColor : Color

func set_button_text(buttontxt):
	$RichTextLabel.text = buttontxt
	$RichTextLabel.set("custom_colors/default_color", normalColor)

func set_highlighted(status):
	if status == true:
		$RichTextLabel.set("custom_colors/default_color", selectedColor)
	else:
		$RichTextLabel.set("custom_colors/default_color", normalColor)
