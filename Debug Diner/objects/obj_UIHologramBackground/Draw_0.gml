shader_set(sh_Hologram);

var t = current_time / 1000;
shader_set_uniform_f(shader_get_uniform(sh_Hologram, "u_time"), t);

draw_self();

shader_reset();