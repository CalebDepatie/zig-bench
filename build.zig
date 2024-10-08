// SPDX-FileCopyrightText: 2024 Caleb Depatie
//
// SPDX-License-Identifier: 0BSD

const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    _ = b.addModule("bench", .{
        .root_source_file = .{
            .path = "bench.zig",
        },
        .target = target,
        .optimize = optimize,
    });

    const tests = b.addTest(.{
        .name = "test",
        .root_source_file = .{ .path = "bench.zig" },
        .target = target,
        .optimize = optimize,
    });

    const test_install = b.addRunArtifact(tests);

    const test_step = b.step("test", "Run the libraries tests");
    test_step.dependOn(&test_install.step);
}
