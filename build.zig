const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const mode = b.standardReleaseOptions();
    const exe = b.addExecutable("sdl-zig-demo", "src/main.zig");
    exe.setBuildMode(mode);
    exe.linkSystemLibrary("SDL2");
    exe.linkSystemLibrary("c");

    b.default_step.dependOn(&exe.step);
    b.installArtifact(exe);


    const run = b.step("run", "Run the demo");
    const run_cmd = b.addCommand(".", b.env_map,
        [][]const u8{exe.getOutputPath(), });
    run.dependOn(&run_cmd.step);
    run_cmd.step.dependOn(&exe.step);
}
