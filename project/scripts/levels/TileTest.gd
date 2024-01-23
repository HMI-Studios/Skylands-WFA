extends Node2D


@onready var player = get_node("/root/Main/Player")


func door_1_animation_fn(x):
    return -((1 - x) ** 2) + 1


func _ready():
    %Door1.transform_fn = door_1_animation_fn
    %Door2.transform_fn = door_1_animation_fn


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
