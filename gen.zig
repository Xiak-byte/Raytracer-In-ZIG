const std = @import("std");
const def = @import("def.zig");
const ray = @import("ray.zig");
const pop = @import("pop.zig");
const sto = @import("std").io.getStdOut().writer();

//some important variable
const BLACK = def.P3D{ .X = 0, .Y = 0, .Z = 0 };
var COLOR = def.P3D{ .X = 92, .Y = 252, .Z = 0 };
const SHADOW: f32 = 3.0;
const COLOR_SPHERE = def.P3D{ .X = 252, .Y = 134, .Z = 0 };
const COLOR_SPHERE2 = def.P3D{ .X = 255, .Y = 0, .Z = 255 };
const AspectRatio: f32 = 16.0 / 9.0;
const WIDTH: i64 = 512;

//image properties, height, width
fn PropIMG(W: i64, ASPECT_RATIO: f32) def.IMG {
    var HEIGHT: i64 = @intFromFloat(@as(f32, W) / ASPECT_RATIO);
    var ImgPropreties = def.IMG{ .WIDTH = W, .HEIGHT = HEIGHT };
    return ImgPropreties;
}

const ImageProperties: def.IMG = PropIMG(WIDTH, AspectRatio);

//camera position and direction
pub var CAMERA = def.RAY{
    .POS = def.P3D{ .X = 0, .Y = 0, .Z = 0 },
    .DIR = def.P3D{ .X = 0, .Y = 0, .Z = 100 },
};

//sphere position, radius and color
const SPHERE_POS = def.P3D{ .X = 0, .Y = 0, .Z = 2 };
const SPHERE = def.SPR{ .COL = COLOR_SPHERE, .POS = SPHERE_POS, .RAD = 40 };

const SPHERE_POS2 = def.P3D{ .X = -3, .Y = 2, .Z = 3 };
const SPHERE2 = def.SPR{ .COL = COLOR_SPHERE2, .POS = SPHERE_POS2, .RAD = 22 };

const LIGHT = def.P3D{ .X = 10, .Y = 23, .Z = 10 };

//function to print the current pixel color
fn color(Color: def.P3D) void {
    var R: usize = @intFromFloat(Color.X);
    var G: usize = @intFromFloat(Color.Y);
    var B: usize = @intFromFloat(Color.Z);
    sto.print("{d} {d} {d}\n", .{ R, G, B }) catch |err| {
        std.debug.print("Oops, there seems to be an error... {}\n", .{err});
    };
}

//function to render the ppm file
pub fn render() void {
    //file header
    sto.print("P3\n{} {}\n255\n", .{ ImageProperties.WIDTH, ImageProperties.HEIGHT }) catch |err| {
        std.debug.print("Oops, there seems to be an error... {}\n", .{err});
    };
    //loop to iterate over each pixels
    var i: i64 = 0;
    var j: i64 = 0;
    while (i < ImageProperties.HEIGHT) {
        std.debug.print("ScanLines remaining {}/{}\n", .{ (ImageProperties.HEIGHT - i), ImageProperties.HEIGHT });
        while (j < ImageProperties.WIDTH) {
            var R: def.RAY = CAMERA;
            R.POS.X += @floatFromInt(j - (ImageProperties.WIDTH / 2));
            R.POS.Y += @floatFromInt((ImageProperties.HEIGHT / 2) - i);
            //check for intersection
            const IntersectionPosition = def.P3D{ .X = R.DIR.X, .Y = R.DIR.Y, .Z = ray.SphereIntersectionRay(SPHERE, R) };
            const IntersectionPositionSmall = def.P3D{ .X = R.DIR.X, .Y = R.DIR.Y, .Z = ray.SphereIntersectionRay(SPHERE2, R) };
            if (IntersectionPositionSmall.Z >= 0) {
                //const ShadowRay = def.RAY{ .POS = pop.Add(IntersectionPosition, pop.Sub(LIGHT, IntersectionPosition)), .DIR = LIGHT };
                const ShadowRay = def.RAY{ .POS = IntersectionPositionSmall, .DIR = LIGHT };
                if (ray.Shadow(ShadowRay, SPHERE2)) {
                    color(pop.Div(COLOR_SPHERE2, SHADOW));
                } else {
                    color(SPHERE2.COL);
                }
            } else if (IntersectionPosition.Z >= 0) {
                //const ShadowRay = def.RAY{ .POS = pop.Add(IntersectionPosition, pop.Sub(LIGHT, IntersectionPosition)), .DIR = LIGHT };
                const ShadowRay = def.RAY{ .POS = IntersectionPosition, .DIR = LIGHT };
                if (ray.Shadow(ShadowRay, SPHERE)) {
                    color(pop.Div(COLOR_SPHERE, SHADOW));
                } else {
                    color(SPHERE.COL);
                }
            } else {
                color(COLOR);
            }
            j += 1;
            R = CAMERA;
        }
        j = 0;
        i += 1;
    }
}
