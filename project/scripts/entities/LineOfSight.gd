extends RayCast2D


@onready var player = get_node('/root/Main/Player')


func _process(delta):
    target_position = (player.global_position - global_position) * 2


func is_player_in_sight() -> bool:
    force_raycast_update()

    if is_colliding():
        var collider = get_collider()
        return collider == player
    return false
