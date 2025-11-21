@tool
extends OptionButton


func _ready() -> void:
	for i in Enum.ChordType.keys():
		add_item(i)
	select(0)
