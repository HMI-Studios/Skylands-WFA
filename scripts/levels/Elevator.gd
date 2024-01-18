extends Area2D

var bodies = {}
@export var speed = 200
@export var force = 1.5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    for body in bodies:
        body.velocity += -Global.gravity * force * delta
        body.velocity = body.velocity.clamp(
            Vector2(-100, -speed),
            Vector2(100, speed),
        )


func _on_body_entered(body):
    if is_instance_of(body, CharacterBody2D):
        bodies[body] = true


func _on_body_exited(body):
    if is_instance_of(body, CharacterBody2D):
        bodies.erase(body)
