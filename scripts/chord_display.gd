extends Control
class_name ChordDisplay

@export var chord : ChordResource
var shape_index : int = 0

func _ready() -> void:
	$Name.text = chord.chord_name
	$ShapeDisplay.shape = chord.get_chord_shape(shape_index)

func request_next_shape() -> void:
	shape_index = shape_index + 1
	if shape_index >= chord.get_num_shapes():
		shape_index = 0
	$ShapeDisplay.shape = chord.get_chord_shape(shape_index)

func request_prev_shape() -> void:
	shape_index = (shape_index - 1) % chord.get_num_shapes()
	if shape_index < 0:
		shape_index = chord.get_num_shapes()-1
	$ShapeDisplay.shape = chord.get_chord_shape(shape_index)
