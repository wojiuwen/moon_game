// fn add_bee(pos :@math.Vec2D) ->Unit{
//   let entity:@system.Entity =@system.Entity::new()
//   @position.positions[entity]=pos
//   let animation: @sprite.Animation = @sprite.Animation::new(
//       "./Free/bee/bee_a.png",
//       max_frame=1,
//       height=64,
//       width=64,
//     )
//     let sprite:@sprite.Sprite =@sprite.Sprite::new_animation(animation,10)
//     @sprite.sprites[entity]=sprite

    
// }


// fn add_bee_i()->Unit{
//   let tilemap :@tilemap.TileMap =@tilemap.TileMap::from_json(tilemap)
//   let bee_pos:@tilemap.Tile =tilemap.get_tiles_leftcorner("bee")[1]
//   add_bee(@math.Vec2D::new(bee_pos.x.to_double() * tilemap.tile_size.to_double(),bee_pos.y.to_double() * tilemap.tile_size.to_double()-50))
// }