extends AudioStreamPlayer


func fade_out(speed):
    %AnimationPlayer.set_speed_scale(speed)
    %AnimationPlayer.play("fadeout")
    await %AnimationPlayer.animation_finished
    stop()
