@tool
extends OptionButton


func _ready() -> void:
	for i in Enum.ChordName.keys():
		add_item(i)
	select(0)
