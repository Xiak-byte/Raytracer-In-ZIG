const std = @import("std");

pub const IMG = struct {
    WIDTH: u32,
    HEIGHT: u32,
};

pub const P3D = struct {
    X: f32,
    Y: f32,
    Z: f32,
};

pub const RAY = struct {
    POS: P3D,
    DIR: P3D,
};

pub const SPR = struct {
    POS: P3D,
    RAD: f32,
    COL: P3D,
};
