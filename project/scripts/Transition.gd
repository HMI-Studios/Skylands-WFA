extends CanvasLayer


signal fade_complete()


func _ready():
    %Fade.hide()
    

func set_color(color):
    %Fade.set_color(color)
    
    
func fade(speed, next_scene):
    fade_out(speed)
    await fade_complete
    get_tree().change_scene_to_packed(next_scene)
    fade_in(speed)


func fade_out(speed):
    print(speed)
    %Fade.show()
    %AnimationPlayer.set_speed_scale(speed)
    %AnimationPlayer.play("fade")
    await %AnimationPlayer.animation_finished
    fade_complete.emit()


func fade_in(speed):
    %Fade.show()
    %AnimationPlayer.set_speed_scale(speed)
    %AnimationPlayer.play_backwards("fade")
    await %AnimationPlayer.animation_finished
    fade_complete.emit()
    %Fade.hide()
