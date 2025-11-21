@tool
extends TextureRect

var open_string_tex : Texture2D = preload("res://images/open.png")
var mute_string_tex : Texture2D = preload("res://images/mute.png")

var state : Enum.StringState = Enum.StringState.MUTE
@export var string : int = 1

func set_state(strng : int, new_state: Enum.StringState) -> void:
	if strng == string:
		match new_state:
			Enum.StringState.PRESSED:
				visible = false
				texture = open_string_tex
			Enum.StringState.OPEN:
				visible = true
				texture = open_string_tex
			Enum.StringState.MUTE:
				visible = true
				texture = mute_string_tex
		state = new_state

func toggle_mute(strng:int) -> void:
	if strng == string:
		assert(state != Enum.StringState.PRESSED)
		match state:
			Enum.StringState.OPEN:
				set_state(string, Enum.StringState.MUTE)
			Enum.StringState.MUTE:
				set_state(string, Enum.StringState.OPEN)
