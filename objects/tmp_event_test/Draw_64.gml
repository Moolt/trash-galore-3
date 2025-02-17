draw_sprite_ext(spr_moo_knob_large_base, -1, 594, 89, 1, 1, 0 , c_white, 1);
draw_sprite_ext(spr_moo_knob_large_handle, -1, 594, 89, 1, 1, -rotation , c_white, 1);

draw_sprite_ext(spr_moo_knob_small_base, -1, 581, 264, 1, 1, 0 , c_white, 1);
draw_sprite_ext(spr_moo_knob_small_handle, -1, 581, 264, 1, 1, -rotation , c_white, 1);

draw_sprite_ext(spr_moo_knob_small_base, -1, 609, 264, 1, 1, 0 , c_white, 1);
draw_sprite_ext(spr_moo_knob_small_handle, -1, 609, 264, 1, 1, -rotation , c_white, 1);

draw_sprite_ext(spr_moo_knob_small_base, -1, 581, 293, 1, 1, 0 , c_white, 1);
draw_sprite_ext(spr_moo_knob_small_handle, -1, 581, 293, 1, 1, -rotation , c_white, 1);

draw_sprite_ext(spr_moo_knob_small_base, -1, 609, 293, 1, 1, 0 , c_white, 1);
draw_sprite_ext(spr_moo_knob_small_handle, -1, 609, 293, 1, 1, -rotation , c_white, 1);

draw_set_alpha(0.5);
draw_sprite(spr_moo_seven_segment_base, 0, 574, 23);
draw_set_alpha(1);

draw_sprite(spr_moo_seven_segment, MOO_GAMES.get_selected_index() + 1, 574, 23);
