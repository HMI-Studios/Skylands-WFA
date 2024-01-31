extends Control


func _on_button_pressed():
    Global.save_config()
    get_tree().change_scene_to_file("res://ui/PlayMenu.tscn")
    

func _on_reset_pressed():
    InputMap.load_from_project_settings()
    get_tree().change_scene_to_file("res://ui/ControlsMenu.tscn")
