extends CharacterBody2D

@onready var entities = get_node('/root/Main/World/Level/Entities')

@export var HP = 1

func test():
    print('test')
    
func hurt(dmg):
    HP -= dmg
    if HP <= 0:
        die()
        
func die():
    entities.remove_child(self)
    call_deferred("queue_free")
        

func _physics_process(delta):
    # Add the gravity.
    if not is_on_floor():
        velocity += Global.gravity * delta
        
    move_and_slide()
