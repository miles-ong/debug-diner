if (tutorial_highlight_active)
{
    var t = current_time / 120;
    var pulse = 0.45 + 0.20 * sin(t);
    var ring_r = 30 + 3 * sin(t);
    var arrow_offset = 3 * sin(t);

    // 1) 更柔和的外发光，不要盖住角色
    gpu_set_blendmode(bm_add);

    draw_sprite_ext(
        sprite_index,
        image_index,
        x, y,
        1.28, 1.28,
        0,
        c_white,
        0.08 + pulse * 0.08
    );

    draw_sprite_ext(
        sprite_index,
        image_index,
        x, y,
        1.16, 1.16,
        0,
        c_yellow,
        0.06 + pulse * 0.07
    );

    gpu_set_blendmode(bm_normal);



    // 3) 更大的头顶箭头
    draw_set_color(c_yellow);
    draw_triangle(
        x - 14, y - 50 + arrow_offset,
        x + 14, y - 50 + arrow_offset,
        x,      y - 28 + arrow_offset,
        false
    );

    draw_set_alpha(1);
    draw_set_color(c_white);
}