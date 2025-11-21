extends TextureRect
class_name ShapeDisplay

var no_indent_tex : Texture2D = preload("res://images/Fretboard_noindent.png")
var indent_tex : Texture2D = preload("res://images/Fretboard_indent.png")

var _shape: ChordShape
var _shape_dirty := false



##The chord shape of the [ChordDisplay]. 
@export var shape: ChordShape:
	set(value): #TODO: fix the setter
		shape = value
		_shape = value
		print("e")
		_shape_dirty = true



func _ready() -> void:
	if _shape_dirty and _shape:
		_apply_shape()

func _process(_delta: float) -> void:
	if _shape_dirty:
		_apply_shape()

func _apply_shape() -> void:
	print("modified")
	for string in get_node("Strings").get_children():
		string.enabled = false 
		string.visible = true
	for note in $Notes.get_children():
		note.visible = false
	
	var lowest_fret = _shape.lowest_fret
	
	if lowest_fret == 0:
		texture = no_indent_tex
		$LowestFretNum.text = ""
	else:
		texture = indent_tex
		$LowestFretNum.text = "%d" % lowest_fret
		
	for note in _shape.notes:
		if not note:
			push_error("One or more of the notes have not been initialized!")
			break
		#filter out invalid notes
		if note.fret > lowest_fret + 5 or (note.fret != 0 and note.fret - lowest_fret <=0):
			continue
		var string_status_display : StringStatusDisplay = $Strings.get_node("%d" % note.string)
		if string_status_display:
			if note.fret == 0:
				string_status_display.enabled = true 
			else:
				string_status_display.visible = false 
		if note.fret == 0:
			continue
		
		#open-note check

			
		var note_node : NoteDisplay = $Notes.get_node("%d_%d" % [note.string, note.fret - _shape.lowest_fret])
		if note_node:
			note_node.visible = true 
			note_node.finger = note.finger
	_shape_dirty = false
		
