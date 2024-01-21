extends "Entity.gd"


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var Bullet = preload("res://scenes/items/GDFSERBullet.tscn")
var cooldown = 1

@onready var rig = get_node("Rig")
@onready var animation_player = get_node("Rig/AnimationPlayer")
var near_arm
var near_hand
var near_hand_remote
var far_arm
var far_hand
var far_hand_remote
var gun_hand

var is_gun_in_right_hand

func _ready():
    near_arm = rig.get_node("Torso/RemoteNearArm")
    near_hand_remote = rig.get_node("Torso/RemoteNearArm/RemoteNearHand")
    near_hand = rig.get_node("Near Hand")
    far_arm = rig.get_node("Torso/RemoteFarArm")
    far_hand_remote = rig.get_node("Torso/RemoteFarArm/RemoteFarHand")
    far_hand = rig.get_node("Far Hand")
    gun_hand = rig.get_node('Gun Hand')

    HP = 10
    rig.remove_child(gun_hand)
    near_arm.get_node(near_arm.remote_path).add_child(gun_hand)
    near_hand.hide()
    near_hand_remote.remote_path = gun_hand.get_path()
    gun_hand.show()
    is_gun_in_right_hand = true


func _physics_process(delta):
    
    if cooldown > 0:
        cooldown = max(cooldown - delta, 0)

    # Handle Jump.
#    if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#        velocity.y = JUMP_VELOCITY

    # Get the input direction and handle the movement/deceleration.
    # As good practice, you should replace UI actions with custom gameplay actions.
#    var direction = Input.get_axis("ui_left", "ui_right")
#    if direction:
#        velocity.x = direction * SPEED
#    else:
#        velocity.x = move_toward(velocity.x, 0, SPEED)

    if %LineOfSight.is_player_in_sight():
        if animation_player.is_playing():
            animation_player.stop()
        handle_gun()
    else:
        if not animation_player.is_playing():
            animation_player.play("Idle")

    super._physics_process(delta)
    
    
func shoot(vec):
    if cooldown == 0:
        cooldown = 0.75
        var bullet = Bullet.instantiate()
        bullet.apply_impulse(vec * 750)
        bullet.modulate = Color(2, 0.5, 0)
        bullet.position = gun_hand.global_position + (vec*30)
        bullet.rotation = gun_hand.global_rotation
        get_node('/root/Main/World').add_child(bullet)
    

func handle_gun():
    var mouse_pos = player.global_position
    var look_vec = mouse_pos - global_position
    var facing_angle = look_vec.angle()
    var aim_angle = facing_angle
    var aim_vec = look_vec.normalized()
    var facing_right = rad_to_deg(abs(facing_angle)) <= 90
    if facing_right:
        if look_vec.length() > 22:
            aim_vec = (mouse_pos - near_hand.global_position).normalized()
            aim_angle = aim_vec.angle()
        rig.scale.x = 1
        far_arm.rotation = 0
        near_arm.rotation = aim_angle - PI/2
        near_hand.rotation = 0.1
        if !is_gun_in_right_hand:
            far_arm.get_node(far_arm.remote_path).remove_child(gun_hand)
            near_arm.get_node(near_arm.remote_path).add_child(gun_hand)
            far_hand_remote.remote_path = far_hand.get_path()
            far_hand.show()
            near_hand.hide()
            near_hand_remote.remote_path = gun_hand.get_path()
            is_gun_in_right_hand = true
    else:
        if look_vec.length() > 22:
            aim_vec = (mouse_pos - far_hand.global_position).normalized()
            aim_angle = aim_vec.angle()
        rig.scale.x = -1
        near_arm.rotation = 0
        far_arm.rotation = -aim_angle + PI/2
        far_hand.rotation = 0.1
        if is_gun_in_right_hand:
            near_arm.get_node(near_arm.remote_path).remove_child(gun_hand)
            far_arm.get_node(far_arm.remote_path).add_child(gun_hand)
            near_hand_remote.remote_path = near_hand.get_path()
            near_hand.show()
            far_hand.hide()
            far_hand_remote.remote_path = gun_hand.get_path()
            is_gun_in_right_hand = false
            
    shoot(aim_vec)
