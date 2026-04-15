if(highlight) {
	shader_set(sh_Highlight);
	var u_time = shader_get_uniform(sh_Highlight, "u_time");
	shader_set_uniform_f(u_time, current_time / 1000);
}