const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const root_path = b.path("src/libinput.zig");

    const tests = b.addTest(.{
        .root_source_file = root_path,
        .target = target,
        .optimize = optimize,
    });

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&tests.step);

    _ = b.addModule("libinput", .{
        .root_source_file = root_path,
    });
}
