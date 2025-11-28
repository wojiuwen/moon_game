fn add_door(pos :@math.Vec2D) ->Unit{
  let entity:@system.Entity =@system.Entity::new()
  @position.positions[entity]=pos
  let animation: @sprite.Animation = @sprite.Animation::new(
      "./Free/door/door_open_top.png",
      max_frame=1,
      height=64,
      width=64,
    )
    let sprite:@sprite.Sprite =@sprite.Sprite::new_animation(animation,10)
    @sprite.sprites[entity]=sprite
   let area:@collision.Area=@collision.Area::new(
    @collision.CollisionShape::Rect(
      size=@math.Vec2D::new(64.0,64.0),
      offset=@math.Vec2D::new(0.0,0.0),
    ),
    item_collision_layer,
    @collision.CollisionMask::new([player_collision_layer]),
  )

  @collision.areas[entity]=area
  area.on_enter(fn(e: @system.Entity) {
     if e==game_state.player_entity{
      let tilemap :@tilemap.TileMap =@tilemap.TileMap::from_json(tilemap)
       let player_pos:@tilemap.Tile =tilemap.get_tiles_leftcorner("player")[0]
       let pos =@math.Vec2D::new(player_pos.x.to_double() * tilemap.tile_size.to_double(),player_pos.y.to_double() * tilemap.tile_size.to_double()-32)
       @position.positions[game_state.player_entity]=pos
     }
  })
   
  
}


fn add_door_i()->Unit{
  let tilemap :@tilemap.TileMap =@tilemap.TileMap::from_json(tilemap)
  let bee_pos:@tilemap.Tile =tilemap.get_tiles_leftcorner("door")[0]
  add_door(@math.Vec2D::new(bee_pos.x.to_double() * tilemap.tile_size.to_double(),bee_pos.y.to_double() * tilemap.tile_size.to_double()))
  
   
}