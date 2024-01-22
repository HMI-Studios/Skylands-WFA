extends Camera2D


@export var cam_speed = 500


func _physics_process(delta):
    var diff = %Player.position - position
    position += (diff * 0.1).limit_length(cam_speed * delta)
