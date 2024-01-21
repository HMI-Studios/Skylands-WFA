extends Node2D


@onready var player = get_node('/root/Main/Player')


func _ready():
    pass


func _on_door_1_opener_body_entered(body):
    if body == player:
        %Door1.open()


func _on_door_1_opener_body_exited(body):
    if body == player:
        %Door1.close()
