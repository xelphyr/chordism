class_name Enum

enum StringState {OPEN, MUTE, PRESSED}
enum FretFinger {NONE, INDEX, MIDDLE, RING, PINKY}
enum ChordName {C, Cs, D, Ds, E, F, Fs, G, Gs, A, As, B}
enum ChordType {MAJOR, MINOR, SEVEN, FIVE, AUG, DIM, }

static func enum_to_string(value: int, enum_dict:Dictionary)->String:
	for k in enum_dict.keys():
		if enum_dict[k] == value:
			return k
	assert(false)
	return ""
