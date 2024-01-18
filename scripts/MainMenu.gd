extends Control


var play_text_pulse_freq = 2
var t = -(PI / 2) / play_text_pulse_freq
var play_text_opacity


func _ready():
    if Global.play_music:
        %Music.play()


func _process(delta):
    t += delta
    play_text_opacity = (sin(t * play_text_pulse_freq) + 1) / 2
    %PlayText.set_modulate(Color(1, 1, 1, play_text_opacity))


func _on_music_finished():
    if Global.play_music:
        %Music.play()
