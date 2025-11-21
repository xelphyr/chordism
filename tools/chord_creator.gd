@tool     
extends EditorScript
class_name ChordCreator

var window : Window
var gui : PackedScene = preload("uid://ct7jrx4odbeid")

func _run() -> void:
	window = Window.new()
	EditorInterface.popup_dialog(window, Rect2(Vector2(100, 100), Vector2(1280, 720)))
	
	var gui_scene := gui.instantiate()
	window.add_child(gui_scene)
	
	window.close_requested.connect(func():
		window.queue_free()
	)
