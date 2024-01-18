extends RigidBody2D


@onready var level = get_node('/root/Main/World/Level')
@onready var world = get_node('/root/Main/World/Level')
var start_speed = 0


func _ready():
    pass # Replace with function body.
    
    
func remove():
    world.remove_child(self)
    queue_free()
    

#func _process(delta):
#    var speed = linear_velocity.length()
#    if start_speed == 0 and speed > 0:
#        start_speed = speed
#    if speed < (start_speed * 0.9):
#        remove()


func _on_body_entered(body):
    if level.is_ancestor_of(body):
        remove()
