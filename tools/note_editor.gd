@tool
extends Button

signal note_toggled(string:int, fret:int, state:bool)
signal toggle_request(string:int)

@export_range(1,5) var fret : int
@export_range(1,6) var string : int

@export var value : Enum.FretFinger

func set_value(v: Enum.FretFinger):
	if not is_node_ready():
		await ready
	value = v
	match v:
		Enum.FretFinger.NONE:
			$NoteTexture.visible = false 
			$FingerNumber.text = ""
		Enum.FretFinger.INDEX:
			$NoteTexture.visible = true
			$FingerNumber.text = "1"
		Enum.FretFinger.MIDDLE:
			$NoteTexture.visible = true
			$FingerNumber.text = "2"
		Enum.FretFinger.RING:
			$NoteTexture.visible = true
			$FingerNumber.text = "3"
		Enum.FretFinger.PINKY:
			$NoteTexture.visible = true
			$FingerNumber.text = "4"
	

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				print("Left click on button")
				match value:
					Enum.FretFinger.NONE:
						set_value(Enum.FretFinger.INDEX)
						note_toggled.emit(string, fret, true)
					Enum.FretFinger.INDEX:
						set_value(Enum.FretFinger.MIDDLE)
					Enum.FretFinger.MIDDLE:
						set_value(Enum.FretFinger.RING)
					Enum.FretFinger.RING:
						set_value(Enum.FretFinger.PINKY)
					Enum.FretFinger.PINKY:
						set_value(Enum.FretFinger.NONE)
						note_toggled.emit(string, fret, false)
			MOUSE_BUTTON_RIGHT:
				if value == Enum.FretFinger.NONE:
					toggle_request.emit(string)
				else:
					set_value(Enum.FretFinger.NONE)
					note_toggled.emit(string, fret, false)
