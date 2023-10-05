const std = @import("std");
const def = @import("def.zig");
const ray = @import("ray.zig");
const sto = @import("std").io.getStdOut().writer();
const thr = @import("std").Thread;
const alloc = @import("std").heap.page_allocator;

const COLOR = def.P3D{ .X = 123, .Y = 89, .Z = 224 };
const COLOR_SPHERE = def.P3D{ .X = 255, .Y = 255, .Z = 0 };
const AspectRatio: f32 = 16.0 / 9.0;
const WIDTH: u32 = 256;

fn PropIMG(W: u32, ASPECT_RATIO: f32) def.IMG {
    var HEIGHT: u32 = @intFromFloat(@as(f32, W) / ASPECT_RATIO);
    var ImgPropreties = def.IMG{ .WIDTH = W, .HEIGHT = HEIGHT };
    return ImgPropreties;
}

const ImageProperties: def.IMG = PropIMG(WIDTH, AspectRatio);
pub var CAMERA = def.RAY{
    .POS = def.P3D{ .X = 0, .Y = 10, .Z = 0 },
    .DIR = def.P3D{ .X = 0, .Y = 0, .Z = 0 },
};
const SPHERE_POS = def.P3D{ .X = 0, .Y = 10, .Z = 2 };
const SPHERE = def.SPR{ .COL = COLOR_SPHERE, .POS = SPHERE_POS, .RAD = 2 };

fn color(Color: def.P3D) void {
    var R: usize = @intFromFloat(Color.X);
    var G: usize = @intFromFloat(Color.Y);
    var B: usize = @intFromFloat(Color.Z);
    sto.print("{d} {d} {d}\n", .{ R, G, B }) catch |err| {
        std.debug.print("Oops, there seems to be an error... {}\n", .{err});
    };
}

pub fn render() void {
    //file head
    sto.print("P3\n{} {}\n255\n", .{ ImageProperties.WIDTH, ImageProperties.HEIGHT }) catch |err| {
        std.debug.print("Oops, there seems to be an error... {}\n", .{err});
    };
    var i: u32 = 0;
    var j: u32 = 0;
    while (i < ImageProperties.HEIGHT) {
        std.debug.print("ScanLines remaining {}/{}\n", .{ (ImageProperties.HEIGHT - i), ImageProperties.HEIGHT });
        while (j < ImageProperties.WIDTH) {
            var R: def.RAY = CAMERA;
            R.DIR.X += @floatFromInt(j);
            R.DIR.Y += @floatFromInt(i);
            if (ray.SphereIntersectionRay(SPHERE, R)) {
                color(COLOR_SPHERE);
            } else {
                color(COLOR);
            }
            j += 1;
        }
        j = 0;
        i += 1;
    }
}
