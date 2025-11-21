extends Resource
class_name Note

func _init(_fret: int, _string:int, _finger:Enum.FretFinger) -> void:
	fret = _fret
	string = _string
	finger = _finger
	

@export_range(1, 6) var string: int = 1
@export var fret: int
@export var finger: Enum.FretFinger
