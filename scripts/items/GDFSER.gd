extends Sprite2D


var Bullet = preload("res://scenes/items/GDFSERBullet.tscn")
var cooldown = 0


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if cooldown > 0:
        cooldown = max(cooldown - delta, 0)
    
    
func shoot(vec):
    if cooldown == 0:
        cooldown = 0.33
        var bullet = Bullet.instantiate()
        bullet.apply_impulse(vec * 1000)
        bullet.position = global_position + (vec*15)
        bullet.rotation = global_rotation
        get_node('/root/Main/World').add_child(bullet)
