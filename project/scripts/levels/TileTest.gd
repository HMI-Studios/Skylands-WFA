extends Node2D


var player


func door_1_animation_fn(x):
    return -((1 - x) ** 2) + 1


func _ready():
    player = get_node("/root/Main/Player")
    %Door1.transform_fn = door_1_animation_fn
    %Door2.transform_fn = door_1_animation_fn
    
    $Entities/Shoaldier3.pathfinder.set_path([Vector2(-614, 47), Vector2(-156, 47)])


func _on_door_1_opener_body_entered(body):
    if body == player:
        %Door1.open()


func _on_door_1_opener_body_exited(body):
    if body == player:
        %Door1.close()


func _on_door_2_opener_body_entered(body):
    if body == player:
        %Door2.open()


func _on_door_2_opener_body_exited(body):
    if body == player:
        %Door2.close()


func _on_exit_body_entered(body):
    print(body)
    if body == player:
        get_node("/root/Main/World").set_level("TileTest2", %Exit.position)
