extends AnimatableBody2D


@onready var origin = position
#@onready var height = %Sprite.texture.get_size().y
@onready var height = ($Collider.shape.get_rect().size * scale).y
@export var state = 0
@export var target_state = 0
@export var speed = 1.0
@export var transform_fn = identity


func open():
    target_state = 1
    
    
func close():
    target_state = 0
    
    
func identity(x):
    return x


func _process(delta):
    if state > target_state:
        state -= min(speed * delta, state - target_state)
    elif state < target_state:
        state += min(speed * delta, target_state - state)
    else:
        return
        
    position = origin + Vector2(0, -height * transform_fn.call(state)).rotated(rotation)
