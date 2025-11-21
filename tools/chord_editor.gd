@tool 
extends Control

var notes_in_string : Array[int] = [0,0,0,0,0,0]

signal string_state_change(string: int, state:Enum.StringState)
signal toggle_string_mute(string:int)

func _ready() -> void:
	for child in $Notes.get_children():
		child.note_toggled.connect(note_changed)
		child.toggle_request.connect(toggle_string_request)
	for child in $Strings.get_children():
		string_state_change.connect(child.set_state)
		toggle_string_mute.connect(child.toggle_mute)
	
func toggle_string_request(string:int) -> void:
	if notes_in_string[string-1] == 0:
		toggle_string_mute.emit(string)

func note_changed(string:int, _fret:int, state:bool) -> void:
	if state == false:
		assert(notes_in_string[string-1] >= 1)
		if notes_in_string[string-1] == 1:
			string_state_change.emit(string, Enum.StringState.OPEN)
		notes_in_string[string-1] -= 1
	if state == true:
		assert(notes_in_string[string-1] <= 4)
		if notes_in_string[string-1] == 0:
			string_state_change.emit(string, Enum.StringState.PRESSED)
		notes_in_string[string-1] += 1
