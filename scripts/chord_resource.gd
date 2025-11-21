extends Resource
class_name ChordResource

enum Finger {INDEX, MIDDLE, RING, PINKY}

@export var chord_name : StringName
@export var shapes : Array[ChordShape] = []

func get_num_shapes() -> int: return shapes.size()

func get_chord_shape(idx : int = 0) -> ChordShape:
	return shapes[idx]
