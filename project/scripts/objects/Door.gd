extends AnimatableBody2D


@onready var origin = position
@onready var height = %Sprite.texture.get_size().y
var state = 0
var target_state = 0
@export var speed = 1


func open():
    target_state = 1
    
    
func close():
    target_state = 0


func _process(delta):
    if state > target_state:
        state -= speed * delta
    elif state < target_state:
        state += speed * delta
    else:
        return
        
    position = origin + Vector2(0, -height * state)
