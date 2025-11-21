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

func export() -> void:
	var shape : ChordShape = ChordShape.new()
	var chord_name : Enum.ChordName
	var chord_type : Enum.ChordType
	
	var chord_name_container = $ChordSettings/ChordName/ChordName
	var chord_type_container = $ChordSettings/ChordType/ChordType
	
	var lowest_fret = $LowestFretNum.text.to_int()
	shape.lowest_fret = lowest_fret
	
	for note in $Notes.get_children():
		if note is NoteEditor:
			if note.value != Enum.FretFinger.NONE:
				shape.notes.append(Note.new(note.fret, note.string, note.value))
	for string in $Strings.get_children():
		if string.state == Enum.StringState.OPEN:
			shape.notes.append(Note.new(0, string.string, Enum.FretFinger.NONE)) 
			
	chord_name = Enum.ChordName[chord_name_container.get_item_text(chord_name_container.get_selected_id())]
	chord_type = Enum.ChordType[chord_type_container.get_item_text(chord_type_container.get_selected_id())]
	
	var file_path = "res://scenes/chords/%s/%s.tres" % [
		Enum.enum_to_string(chord_name, Enum.ChordName), 
		Enum.enum_to_string(chord_name, Enum.ChordName) + Enum.enum_to_string(chord_type, Enum.ChordType)
	]
	
	if FileAccess.file_exists(file_path):
		var chord_res : ChordResource = ResourceLoader.load(file_path) as ChordResource
		if chord_res == null:
			push_error("Failed to load chord resource at %s" % file_path)
			return
		var shapes := chord_res.shapes.duplicate()
		shapes.append(shape)
		chord_res.shapes = shapes
		var err := ResourceSaver.save(chord_res, file_path)
		if err != OK:
			push_error("Error saving chord %s: %s" % [name, error_string(err)])
	else:
		var chord_res : ChordResource = ChordResource.new()
		chord_res.chord_name = chord_name
		chord_res.chord_type = chord_type
		chord_res.shapes.append(shape)
		var global_file_path = ProjectSettings.globalize_path(file_path).get_base_dir()
		if not DirAccess.dir_exists_absolute(global_file_path):
			DirAccess.make_dir_recursive_absolute(global_file_path)
		ResourceSaver.save(chord_res, file_path)
