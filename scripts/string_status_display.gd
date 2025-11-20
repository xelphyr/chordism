extends TextureRect
class_name StringStatusDisplay

var open_string_tex : Texture2D = preload("res://images/open.png")
var mute_string_tex : Texture2D = preload("res://images/mute.png")

@export var enabled : bool :
	set = _set_enabled

func _set_enabled(v : bool) :
	if v:
		texture = open_string_tex
	else:
		texture = mute_string_tex
