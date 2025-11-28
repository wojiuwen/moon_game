// fn add_apple(backend:&@system.Backend,pos :@math.Vec2D) ->Unit{
//   let entity:@system.Entity =@system.Entity::new()
//   @position.positions[entity]=pos
//   let animation: @sprite.Animation = @sprite.Animation::new(
//       "./Free/Items/Fruits/Bananas.png",
//       max_frame=17,
//       height=32,
//       width=32,
//     )
//     let sprite:@sprite.Sprite =@sprite.Sprite::new_animation(animation,20)
//     @sprite.sprites[entity]=sprite

//     let area:@collision.Area=@collision.Area::new(
//     @collision.CollisionShape::Rect(
//       size=@math.Vec2D::new(32.0,32.0),
//       offset=@math.Vec2D::new(0.0,0.0),
//     ),
//     item_collision_layer,
//     @collision.CollisionMask::new([player_collision_layer]),
//   )

//   @collision.areas[entity]=area
//   area.on_enter(fn(e: @system.Entity) {
//      if e==game_state.player_entity{
//       backend.play_audio("./brackeys_platformer_assets/sounds/coin.wav",volume=game_state.volume_1,loop_=false)
//       set_score(game_state.score+10)
//       @system.Entity::destroy(entity)
//      }
//   })
// }

// fn add_item_apple(_backend :&@system.Backend) ->Unit{
//   let tilemap :@tilemap.TileMap =@tilemap.TileMap::from_json(tilemap)
//   let apples:Array[@tilemap.Tile] =tilemap.get_tiles_leftcorner("Layer_2")
//   for apple in apples{
//       add_apple(_backend,
//         @math.Vec2D::new(
//           apple.x.to_double() *tilemap.tile_size.to_double(),
//           apple.y.to_double() *tilemap.tile_size.to_double()
//         )
//       )
//   }

// }
