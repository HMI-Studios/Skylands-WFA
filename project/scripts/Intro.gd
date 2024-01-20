extends Control


var main_menu = preload("res://ui/MainMenu.tscn")


func _ready():
    if Global.play_music:
        %Music.play()
    else:
        _on_finished()


func _on_finished():
    get_tree().change_scene_to_packed(main_menu)
