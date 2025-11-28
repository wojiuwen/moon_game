// fn add_frog(pos :@math.Vec2D) ->Unit{
//   let entity:@system.Entity =@system.Entity::new()
//   @position.positions[entity]=pos
//   let animation: @sprite.Animation = @sprite.Animation::new(
//       "./Free/frog/frog_idle.png",
//       max_frame=1,
//       height=64,
//       width=64,
//     )
//     let sprite:@sprite.Sprite =@sprite.Sprite::new_animation(animation,10)
//     @sprite.sprites[entity]=sprite

// }

// fn add_frog_i()->Unit{
//   let tilemap :@tilemap.TileMap =@tilemap.TileMap::from_json(tilemap)
//   let frog_pos:@tilemap.Tile =tilemap.get_tiles_leftcorner("frog")[0]
//   add_frog(@math.Vec2D::new(frog_pos.x.to_double() * tilemap.tile_size.to_double(),frog_pos.y.to_double() * tilemap.tile_size.to_double()))
// }