extends Camera2D


@export var cam_speed = 500
var is_scoping = false


func _physics_process(delta):
    #var diff = %Player.position - position
    #position += (diff * 0.1).limit_length(cam_speed * delta)
    if %Player.is_scoping:
        is_scoping = true
        var diff = (%Player.position + Vector2(180 * %Player.last_movement_direction, 0)) - position
        position += (diff * 0.1).limit_length(cam_speed * delta)
    elif is_scoping:
        var diff = %Player.position - position
        position += (diff * 0.25).limit_length(cam_speed * delta)
        if diff.length() < 1:
            is_scoping = false
    else:
        position = %Player.position
