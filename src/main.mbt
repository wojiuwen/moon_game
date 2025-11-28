///|

const WORLD_WIDTH :Double =560.0

const WORLD_HEIGHT:Double=432.0

fn main {
  @system.App::new(@canvas.CanvasBackend::new())
  .with_canvas_height(WORLD_HEIGHT)
  .with_canvas_width(WORLD_WIDTH)
  .with_fps(120)
  .add_plugin(@plugins.default_plugin)
  .add_system(player_input_system)
  .add_initializer(game_start)
  .run()
}


let item_collision_layer:@collision.CollisionLayer =@collision.CollisionLayer::new()
fn game_start(_backend :&@system.Backend) -> Unit{
  add_volume_botton()
  add_information_box()
  view() 
  add_player_1()
  // add_item_apple(_backend)
  add_map()
  // add_bee_i()
  // add_frog_i()
  add_door_i()
  }