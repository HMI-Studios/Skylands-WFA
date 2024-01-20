extends RigidBody2D


@export var dmg = 2


@onready var world = get_node('/root/Main/World')
@onready var level = get_node('/root/Main/World/Level')
@onready var hitboxes = get_node('/root/Main/World/Level/Hitboxes')
@onready var entities = get_node('/root/Main/World/Level/Entities')
@onready var player = get_node('/root/Main/Player')
var start_speed = 0


func _ready():
    pass # Replace with function body.
    
    
func remove():
    world.remove_child(self)
    call_deferred("queue_free")
    

#func _process(delta):
#    var speed = linear_velocity.length()
#    if start_speed == 0 and speed > 0:
#        start_speed = speed
#    if speed < (start_speed * 0.9):
#        remove()


func _on_body_entered(body):
    if level == null:
        return
    if body == hitboxes:
        remove()
    elif entities.is_ancestor_of(body):
        body.hurt(dmg)
        remove()
    elif body == player:
        player.hurt(dmg)
        remove()
