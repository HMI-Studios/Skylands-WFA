extends Control


func _ready():
    print('hi')


func _on_credits_pressed():
    print('Credits!')


func _on_exit_pressed():
    get_tree().quit()


func _on_new_game_pressed():
    var game = preload("res://scenes/Main.tscn")
    Transition.set_color(Color(0, 0, 0))
    MenuMusic.fade_out(1)
    Transition.fade(1, game)


func _on_settings_pressed():
    get_tree().change_scene_to_file("res://ui/ControlsMenu.tscn")
