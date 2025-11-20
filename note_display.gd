extends TextureRect
class_name NoteDisplay

@export var finger : Enum.FretFinger : 
	set(value):
		finger_modified(value)
		
func finger_modified(value:Enum.FretFinger):
	match value:
		Enum.FretFinger.INDEX:
			$FingerNumber.text = "1"
		Enum.FretFinger.MIDDLE:
			$FingerNumber.text = "2"
		Enum.FretFinger.RING:
			$FingerNumber.text = "3"
		Enum.FretFinger.PINKY:
			$FingerNumber.text = "4"
