extends Node2D


@onready var player = get_node("/root/Main/Player")


func door_1_animation_fn(x):
    return -((1 - x) ** 2) + 1


func _ready():
    %Door1.transform_fn = door_1_animation_fn
    %Door1.open()


func _on_exit_body_entered(body):
    pass


func _on_elevator_body_exited(body):
    %Door3.close()
