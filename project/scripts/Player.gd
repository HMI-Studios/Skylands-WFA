extends CharacterBody2D

@export var speed = 60
@export var max_speed = 140
@export var jump_height = -266

@export var HP = 20

var screen_size # Size of the game window.
var animation_player : AnimationPlayer

@onready var world = get_node("/root/Main/World")

@onready var rig = get_node("CharacterRig")
@onready var near_arm = rig.get_node("Hips/Torso/RemoteNearArm")
@onready var near_hand = rig.get_node("Hips/Torso/RemoteNearArm/RemoteNearHand")
@onready var near_gun = rig.get_node("Near Hand/NearGunSlot")
@onready var far_arm = rig.get_node("Hips/Torso/RemoteFarArm")
@onready var far_hand = rig.get_node("Hips/Torso/RemoteFarArm/RemoteFarHand")
@onready var far_gun = rig.get_node("Far Hand/FarGunSlot")
var aim_angle
var facing_angle

var is_gun_in_right_hand
var gun = preload("res://scenes/items/GDFSER.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
    Background.get_node('Darkness').show()
    screen_size = get_viewport_rect().size
    # var character_rig_scene = load("res://CharacterRig.tscn")
    animation_player = get_node("CharacterRig/AnimationPlayer")
    # animation_player.connect("animation_finished", self._on_animation_finished)
    is_gun_in_right_hand = true
    near_gun.add_child(gun)
#    gun.position = Vector2(0, 65)
    gun.rotation = PI/2


func _physics_process(delta):
    velocity += Global.gravity * delta
    horizontal_movement(delta)
    move_and_slide()
    
    if !Global.can_wall_jump and is_on_floor():
        Global.can_wall_jump = true
        
    handle_gun()
        
func handle_gun():
    var mouse_pos = get_global_mouse_position()
    var look_vec = mouse_pos - position
    facing_angle = look_vec.angle()
    aim_angle = facing_angle
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
            far_gun.remove_child(gun)
            is_gun_in_right_hand = true
            near_gun.add_child(gun)
    else:
        if look_vec.length() > 22:
            aim_vec = (mouse_pos - far_hand.global_position).normalized()
            aim_angle = aim_vec.angle()
        rig.scale.x = -1
        near_arm.rotation = 0
        far_arm.rotation = -aim_angle + PI/2
        far_hand.rotation = 0.1
        if is_gun_in_right_hand:
            near_gun.remove_child(gun)
            is_gun_in_right_hand = false
            far_gun.add_child(gun)
            
    if Input.is_action_pressed("shoot"):
        %GunRay.target_position = (gun.global_position - %GunRay.global_position) / scale
        %GunRay.force_raycast_update()
        if not %GunRay.is_colliding():
            gun.shoot(aim_vec)

    
func horizontal_movement(delta):
    var horizontal_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
    if horizontal_input != 0:
        if abs(velocity.x) < max_speed:
            velocity.x += horizontal_input * speed
        else:
            velocity.x = horizontal_input * max_speed
    else:
        if is_on_floor():
            velocity.x *= 0.6
        else:
            velocity.x *= 0.925
            
    if Input.is_action_pressed("jump"):
        if is_on_floor():
            velocity.y = jump_height
        elif Global.can_wall_jump and is_on_wall_only():
            velocity.y = jump_height
            velocity += get_last_slide_collision().get_normal() * speed
            Global.can_wall_jump = false

    if abs(velocity.x) > 10:
        play_walk_animation()
    else:
        stop_walk_animation()


func hurt(dmg):
    HP -= dmg
    if HP <= 0:
        position = world.get_spawn_pos()
        HP = 20
        world.reset()
    
    
func play_walk_animation():
    var direction_sign
    if rad_to_deg(abs(facing_angle)) <= 90:
        direction_sign = 1
    else:
        direction_sign = -1
    var animation_speed = abs(velocity.x) * 0.014 * (sign(velocity.x) * direction_sign)
    print(velocity.x, ' ', direction_sign, ' ', velocity.x, ' ', animation_speed)
    if not animation_player.is_playing():
        animation_player.play("Walk")
    animation_player.set_speed_scale(animation_speed)

func stop_walk_animation():
    if animation_player.is_playing():
        animation_player.stop()
