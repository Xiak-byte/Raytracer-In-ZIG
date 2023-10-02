const std = @import("std");
const def = @import("def.zig");
const alloc = @import("std").heap.page_allocator;

pub fn New(X: f32, Y: f32, Z: f32) *def.P3D {
    var NewP: *def.P3D = alloc.create(def.P3D) catch |err| {
        std.debug.print("EROOR ALLOCATING NEW VECTOR => {}\n", .{err});
        var PERR = def.P3D{ .X = 0, .Y = 0, .Z = 0 };
        return &PERR;
    };
    NewP.*.X = X;
    NewP.*.Y = Y;
    NewP.*.Z = Z;
    return NewP;
}

pub fn Add(P: def.P3D, I: anytype) def.P3D {
    var ReturnP = New(0, 0, 0).*;
    switch (@TypeOf(I)) {
        f32 => {
            ReturnP.X = P.X + I;
            ReturnP.Y = P.Y + I;
            ReturnP.Z = P.Z + I;
        },
        def.P3D => {
            ReturnP.X = P.X + I.X;
            ReturnP.Y = P.Y + I.Y;
            ReturnP.Z = P.Z + I.Z;
        },
        else => {
            std.debug.print("Not a compatible type\n", .{});
        },
    }
    return ReturnP;
}

pub fn Sub(P: def.P3D, I: anytype) def.P3D {
    var ReturnP = New(0, 0, 0).*;
    switch (@TypeOf(I)) {
        f32 => {
            ReturnP.X = P.X - I;
            ReturnP.Y = P.Y - I;
            ReturnP.Z = P.Z - I;
        },
        def.P3D => {
            ReturnP.X = P.X - I.X;
            ReturnP.Y = P.Y - I.Y;
            ReturnP.Z = P.Z - I.Z;
        },
        else => {
            std.debug.print("Not a compatible type\n", .{});
        },
    }
    return ReturnP;
}

pub fn Mul(P: def.P3D, I: anytype) def.P3D {
    var ReturnP = New(0, 0, 0).*;
    switch (@TypeOf(I)) {
        f32 => {
            ReturnP.X = P.X * I;
            ReturnP.Y = P.Y * I;
            ReturnP.Z = P.Z * I;
        },
        def.P3D => {
            ReturnP.X = P.X * I.X;
            ReturnP.Y = P.Y * I.Y;
            ReturnP.Z = P.Z * I.Z;
        },
        else => {
            std.debug.print("Not a compatible type\n", .{});
        },
    }
    return ReturnP;
}

pub fn Div(P: def.P3D, I: anytype) def.P3D {
    var ReturnP = New(0, 0, 0).*;
    switch (@TypeOf(I)) {
        f32 => {
            ReturnP.X = P.X / I;
            ReturnP.Y = P.Y / I;
            ReturnP.Z = P.Z / I;
        },
        def.P3D => {
            ReturnP.X = P.X / I.X;
            ReturnP.Y = P.Y / I.Y;
            ReturnP.Z = P.Z / I.Z;
        },
        else => {
            std.debug.print("Not a compatible type\n", .{});
        },
    }
    return ReturnP;
}

pub fn Dot(P1: def.P3D, P2: def.P3D) f32 {
    return P1.X * P2.X + P1.Y * P2.Y + P1.Z * P2.Z;
}

pub fn Length(P: def.P3D) f32 {
    return std.math.sqrt(Dot(P, P));
}

pub fn UnitVector(P: def.P3D) def.P3D {
    return Div(P, Length(P));
}

pub fn Cross(P1: def.P3D, P2: def.P3D) def.P3D {
    var X: f32 = P1.Y * P2.Z - P1.Z * P2.Y;
    var Y: f32 = P1.Z * P2.X - P1.X * P2.Z;
    var Z: f32 = P1.X * P2.Y - P1.Y * P2.X;
    return New(X, Y, Z);
}
