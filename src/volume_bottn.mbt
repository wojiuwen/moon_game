fn add_volume_botton() -> Unit{
  let entity:@system.Entity =@system.Entity::new()
  let animation: @sprite.Animation = @sprite.Animation::new(
      "./Free/Menu/Buttons/Volume.png",
      max_frame=1,
      height=21,
      width=22,
    )

  let animation_off: @sprite.Animation = @sprite.Animation::new(
      "./Free/Menu/Buttons/VolumeOff.png",
      max_frame=1,
      height=21,
      width=22,
    )

    let sprite:@sprite.Sprite =@sprite.Sprite::new_animation(animation,100)
    let sprite_off:@sprite.Sprite =@sprite.Sprite::new_animation(animation_off,100)
    @sprite.sprites[entity]=sprite
    let area:@collision.Area=@collision.Area::new(
    Rect(
      size=@math.Vec2D::new(21.0,22.0),
      offset=@math.Vec2D::new(0.0,0.0),
    ),
    @collision.CollisionLayer::new(),
    @collision.CollisionMask::empty(),
    monitoring_mouse=true
  )
  @collision.areas[entity]=area
  @position.positions[entity]=@math.Vec2D::new(WORLD_WIDTH-30.0,10.0)
  @camera.uis[entity] =@camera.Ui::new()
 
  area.on_just_pressed(fn(button:@system.MouseButton){
      if(button==Left){
        game_state.volume_1 = 1-game_state.volume_1
        if game_state.volume_1 !=0 {
          @sprite.sprites[entity]=sprite
        }else{
          @sprite.sprites[entity]=sprite_off
        }
      }
  }
  )
}