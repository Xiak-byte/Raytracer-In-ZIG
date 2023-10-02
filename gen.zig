const std = @import("std");
const gen = @import("gen.zig");
const def = @import("def.zig");
const col = @import("col.zig");
const scn = @import("scn.zig");
const img = @import("img.zig");
const pop = @import("pop.zig");
const sto = @import("std").io.getStdOut().writer();
const thr = @import("std").Thread;
const alloc = @import("std").heap.page_allocator;

const COLOR = def.P3D{ .X = 123, .Y = 89, .Z = 224 };
const AspectRatio: f32 = 16.0 / 9.0;
const WIDTH: u32 = 900;
pub const ImageProperties: def.IMG = img.PropIMG(WIDTH, AspectRatio);
pub var CAMERA = def.RAY{
    .POS = def.P3D{ .X = 0, .Y = 0, .Z = 10 },
    .DIR = def.P3D{ .X = 0, .Y = 0, .Z = 0 },
};
const PIXEL_GRID_W = def.P3D{ .X = 0, .Y = 1, .Z = 0 };
const PIXEL_GRID_H = def.P3D{ .X = 0, .Y = 0, .Z = -1 };

pub fn CamToPixel(R: *def.P3D, I: def.P3D) def.P3D {
    const Ray = pop.Add(R.*, I);
    const ColorModifier = pop.Div(Ray, 100.0);
    const Color = pop.Mul(COLOR, ColorModifier);
    return Color;
}

pub fn render() void {
    //file head
    sto.print("P3\n{} {}\n255\n", .{ ImageProperties.WIDTH, ImageProperties.HEIGHT }) catch |err| {
        std.debug.print("Oops, there seems to be an error... {}\n", .{err});
    };
    var i: usize = 0;
    var j: usize = 0;
    while (i < ImageProperties.HEIGHT) {
        std.debug.print("ScanLines remaining {}/{}\n", .{ (ImageProperties.HEIGHT - i), ImageProperties.HEIGHT });
        while (j < ImageProperties.WIDTH) {
            col.color(CamToPixel(&CAMERA.DIR, PIXEL_GRID_W));
            j += 1;
        }
        _ = CamToPixel(&CAMERA.DIR, PIXEL_GRID_H);
        j = 0;
        i += 1;
    }
}
