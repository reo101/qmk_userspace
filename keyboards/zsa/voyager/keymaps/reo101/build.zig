const std = @import("std");

// NOTE: derived from `compile_commands.json`
const incluceDirs = [_][:0]const u8{
    ".",
    "./lib/chibios/os/common/ext/ARM/CMSIS/Core/Include",
    "./lib/chibios/os/common/ext/ST/STM32F3xx",
    "./lib/chibios/os/common/portability/GCC",
    "./lib/chibios/os/common/ports/ARM-common",
    "./lib/chibios/os/common/ports/ARMv7-M",
    "./lib/chibios/os/common/startup/ARMCMx/compilers/GCC",
    "./lib/chibios/os/common/startup/ARMCMx/devices/STM32F3xx",
    "./lib/chibios/os/hal/boards/ST_STM32F3_DISCOVERY",
    "./lib/chibios/os/hal/include",
    "./lib/chibios/os/hal/lib/streams",
    "./lib/chibios/os/hal/osal/rt-nil",
    "./lib/chibios/os/hal/ports/STM32/LLD/ADCv3",
    "./lib/chibios/os/hal/ports/STM32/LLD/CANv1",
    "./lib/chibios/os/hal/ports/STM32/LLD/DACv1",
    "./lib/chibios/os/hal/ports/STM32/LLD/DMAv1",
    "./lib/chibios/os/hal/ports/STM32/LLD/EXTIv1",
    "./lib/chibios/os/hal/ports/STM32/LLD/GPIOv2",
    "./lib/chibios/os/hal/ports/STM32/LLD/I2Cv2",
    "./lib/chibios/os/hal/ports/STM32/LLD/RTCv2",
    "./lib/chibios/os/hal/ports/STM32/LLD/SPIv2",
    "./lib/chibios/os/hal/ports/STM32/LLD/SYSTICKv1",
    "./lib/chibios/os/hal/ports/STM32/LLD/TIMv1",
    "./lib/chibios/os/hal/ports/STM32/LLD/USART",
    "./lib/chibios/os/hal/ports/STM32/LLD/USARTv2",
    "./lib/chibios/os/hal/ports/STM32/LLD/USBv1",
    "./lib/chibios/os/hal/ports/STM32/LLD/xWDGv1",
    "./lib/chibios/os/hal/ports/STM32/STM32F3xx",
    "./lib/chibios/os/hal/ports/common/ARMCMx",
    "./lib/chibios/os/license",
    "./lib/chibios/os/oslib/include",
    "./lib/chibios/os/rt/include",
    "./lib/chibios/os/various",
    "./platforms/chibios/boards/GENERIC_STM32_F303XC/configs",
    "./platforms/chibios/boards/common/configs",
    ".build/obj_zsa_voyager_reo101/src",
    "drivers",
    "drivers/eeprom",
    "drivers/gpio",
    "drivers/led/issi",
    "drivers/wear_leveling",
    "keyboards/.",
    "keyboards/zsa",
    "keyboards/zsa/voyager",
    "keyboards/zsa/voyager/keymaps/reo101",
    "lib/fnv",
    "lib/printf/src",
    "lib/printf/src/printf",
    "platforms",
    "platforms/chibios",
    "platforms/chibios/drivers",
    "platforms/chibios/drivers/eeprom",
    "platforms/chibios/drivers/wear_leveling",
    "quantum",
    "quantum/bootmagic/",
    "quantum/keymap_extras",
    "quantum/logging",
    "quantum/process_keycode",
    "quantum/rgb_matrix",
    "quantum/rgb_matrix/animations",
    "quantum/rgb_matrix/animations/runners",
    "quantum/send_string/",
    "quantum/sequencer",
    "quantum/wear_leveling",
    "tmk_core",
    "tmk_core/protocol",
    "tmk_core/protocol/chibios",
    "tmk_core/protocol/chibios/lufa_utils",
    "users/reo101",
    ".",
};

fn addQMKIncludePaths(b: *std.Build.Step.Compile) void {
    inline for (incluceDirs) |dir| {
        // TODO: `qmk` ivocation to see where home is
        b.addIncludePath(.{ .cwd_relative = "../../../../../../qmk_firmware/" ++ dir });
    }
}

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{
        .default_target = .{
            .cpu_arch = .thumb,
            .cpu_model = .{
                .explicit = &std.Target.arm.cpu.cortex_m4,
            },
            .os_tag = .freestanding,
            .abi = .gnueabihf,
            .ofmt = .c,
        },
    });

    const optimize = b.standardOptimizeOption(.{
        .preferred_optimize_mode = .ReleaseSmall,
    });

    // const keymap = b.addTranslateC(.{
    //     .root_source_file = .{
    //         .cwd_relative  = "./keymap.zig",
    //     },
    //     .target = target,
    //     .optimize = optimize,
    // });
    const keymap = b.addStaticLibrary(.{
        .name = "keymap.c",
        .root_source_file = .{ .cwd_relative = "./keymap.zig" },
        .target = target,
        .optimize = optimize,
    });
    keymap.linkLibC();
    addQMKIncludePaths(keymap);

    const emit_c = b.addInstallBinFile(keymap.getEmittedBin(), "keymap_generated.c");

    const keymap_step = b.step("keymap", "Create keymap.c");
    keymap_step.dependOn(&keymap.step);
    keymap_step.dependOn(&emit_c.step);
}
