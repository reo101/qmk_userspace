const std = @import("std");
const c = @cImport({
    // @cDefine("MATRIX_ROWS", "12");
    // @cDefine("MATRIX_COLS", "7");
    // @cDefine("MOON_LED_LEVEL", "LED_LEVEL");
    // @cInclude("config.h");
    @cInclude("keycode.h");
    @cInclude("quantum_keycodes.h");
    // @cInclude("keymap.h");
    // @cInclude("version.h");
    // @cInclude("features/achordion.h");
    // FIXME: `inttypes.h`
    // @cInclude("/Users/pavelatanasov/Projects/Home/Keyboards/qmk_firmware/.build/obj_zsa_voyager_reo101/src/default_keyboard.h");
    // @cInclude("voyager.h");
    // @cInclude("quantum.h");
    @cDefine("MOON_LED_LEVEL", "LED_LEVEL");
    // @cInclude("features/achordion.h");
    // @cDefine("ACHORDION_STREAK", "");
});
const layouts = @import("layouts.zig");

const custom_keycodes = enum(u32) {
    RGB_SLD = c.SAFE_RANGE,
};

// zig fmt: off
const layers = enum(u3) {
    BASE    = 0,
    LOWER   = 1,
    UPPER   = 2,
    SPECIAL = 3,
    GAMING  = 4,
};
// zig fmt: on

pub const keycode_t: type = c_int;

// zig fmt: off

// Left HRM
pub const BR_A   : keycode_t = c.MT(c.MOD_LSFT, c.KC_A);
pub const BR_S   : keycode_t = c.MT(c.MOD_LCTL, c.KC_S);
pub const BR_D   : keycode_t = c.MT(c.MOD_LGUI, c.KC_D);
pub const BR_F   : keycode_t = c.MT(c.MOD_LALT, c.KC_F);

// Right HRM
pub const BR_J   : keycode_t = c.MT(c.MOD_RALT, c.KC_J);
pub const BR_K   : keycode_t = c.MT(c.MOD_RGUI, c.KC_K);
pub const BR_L   : keycode_t = c.MT(c.MOD_RCTL, c.KC_L);
pub const BR_SCLN: keycode_t = c.MT(c.MOD_RSFT, c.KC_SCLN);

// Layer toggles
pub const BR_BSPC: keycode_t = c.LT(@intFromEnum(layers.LOWER), c.KC_BSPC);
pub const BR_SPC : keycode_t = c.LT(@intFromEnum(layers.UPPER), c.KC_SPACE);
pub const BR_SPEC: keycode_t = c.MO(@intFromEnum(layers.SPECIAL));

// zig fmt: on

pub export const keymaps = std.enums.directEnumArray(layers, [12][7]keycode_t, 0, .{
    // zig fmt: off
    .BASE = layouts.layout_voyager(keycode_t, c.XXXXXXX, .{
        c.XXXXXXX, c.XXXXXXX, c.XXXXXXX, c.XXXXXXX, c.XXXXXXX, c.XXXXXXX,            c.XXXXXXX, c.XXXXXXX, c.XXXXXXX, c.XXXXXXX, c.XXXXXXX, c.XXXXXXX,
        c.XXXXXXX, c.KC_Q   , c.KC_W   , c.KC_E   , c.KC_R   , c.KC_T   ,            c.KC_Y   , c.KC_U   , c.KC_I   , c.KC_O   , c.KC_P   , c.XXXXXXX,
        c.XXXXXXX,   BR_A   ,   BR_S   ,   BR_D   ,   BR_F   , c.KC_G   ,            c.KC_H   ,   BR_J   ,   BR_K   ,   BR_L   ,   BR_SCLN, c.KC_QUOT,
        c.XXXXXXX, c.KC_Z   , c.KC_X   , c.KC_C   , c.KC_V   , c.KC_B   ,            c.KC_N   , c.KC_M   , c.KC_COMM, c.KC_DOT , c.KC_SLSH, c.XXXXXXX,
                                                      BR_BSPC, c.KC_TAB ,            c.KC_ENT ,   BR_SPC ,
    }),
    // zig fmt: on
    // zig fmt: off
    .LOWER = layouts.layout_voyager(keycode_t, c.XXXXXXX, .{
        c._______, c._______, c._______, c._______, c._______, c._______,            c._______, c._______, c._______, c._______, c._______, c._______,
        c.KC_TILD, c.KC_EXLM, c.KC_AT  , c.KC_HASH, c.KC_DLR , c.KC_PERC,            c.KC_CIRC, c.KC_AMPR, c.KC_ASTR, c.KC_MINS, c.KC_EQL , c._______,
        c._______, c.KC_LABK, c.KC_LCBR, c.KC_LBRC, c.KC_LPRN, c.KC_BSLS,            c.KC_SLSH, c.KC_RPRN, c.KC_RBRC, c.KC_RCBR, c.KC_RABK, c._______,
        c._______, c._______, c._______, c._______, c.KC_UNDS, c.KC_MINS,            c.KC_EQL , c.KC_PLUS, c.KC_MNXT, c.KC_VOLD, c.KC_VOLU, c.KC_MPLY,
                                                    c._______, c._______,            c._______,   BR_SPEC,
    }),
    // zig fmt: on
    // zig fmt: off
    .UPPER = layouts.layout_voyager(keycode_t, c.XXXXXXX, .{
        c._______, c._______, c._______, c._______, c._______, c._______,            c._______, c._______, c._______, c._______, c._______, c._______,
        c.KC_NUBS, c.KC_1   , c.KC_2   , c.KC_3   , c.KC_4   , c.KC_5   ,            c.KC_6   , c.KC_7   , c.KC_8   , c.KC_9   , c.KC_0   , c._______,
        c.KC_DEL , c._______, c._______, c.KC_BTN2, c.KC_BTN1, c._______,            c.KC_LEFT, c.KC_DOWN, c.KC_UP  , c.KC_RGHT, c._______, c._______,
        c._______, c.KC_PGDN, c.KC_PGUP, c.KC_END , c.KC_HOME, c._______,            c._______, c._______, c._______, c._______, c._______, c._______,
                                                      BR_SPEC, c._______,            c._______, c._______,
    }),
    // zig fmt: on
    // zig fmt: off
    .SPECIAL = layouts.layout_voyager(keycode_t, c.XXXXXXX, .{
        c.DM_RSTP, c.RGB_TOG, c.RGB_MOD, c._______, c._______, c._______,            c._______, c.RGB_SPD, c.RGB_SPI, c._______, c._______, c._______,
        c._______, c.DM_REC1, c.DM_REC2, c._______, c._______, c._______,            c._______, c.RGB_HUD, c.RGB_HUI, c._______, c._______, c._______,
        c._______, c.DM_PLY1, c.DM_PLY2, c._______, c._______, c._______,            c._______, c.RGB_VAD, c.RGB_VAI, c._______, c._______, c._______,
        c._______, c.CM_TOGG, c._______, c._______, c._______, c._______,            c._______, c.RGB_SAD, c.RGB_SAI, c._______, c._______, c._______,
                                                    c._______, c._______,            c._______, c._______,
    }),
    // zig fmt: on
    // zig fmt: off
    .GAMING = layouts.layout_voyager(keycode_t, c.XXXXXXX, .{
        c.KC_NUBS, c.KC_1   , c.KC_2   , c.KC_3   , c.KC_4   , c.KC_5   ,            c.KC_6   , c.KC_7   , c.KC_8   , c.KC_9   , c.KC_0   , c._______,
        c.KC_TAB , c.KC_Q   , c.KC_W   , c.KC_E   , c.KC_R   , c.KC_T   ,            c.KC_Y   , c.KC_U   , c.KC_I   , c.KC_P   , c.KC_LBRC, c._______,
        c.KC_LSFT, c.KC_A   , c.KC_S   , c.KC_D   , c.KC_F   , c.KC_G   ,            c.KC_H   , c.KC_J   , c.KC_K   , c.KC_L   , c.KC_SCLN, c._______,
        c.KC_LCTL, c.KC_Z   , c.KC_X   , c.KC_C   , c.KC_V   , c.KC_B   ,            c.KC_N   , c.KC_M   , c.KC_COMM, c.KC_DOT , c.KC_SLSH, c._______,
                                                    c._______, c._______,            c._______, c._______,
    }),
    // zig fmt: on
});

////////////////
//// COMBOS ////
////////////////

// pub const combos: type = enum {
//     JK_ESCAPE,
// };
//
// pub const jk_combo: []keycode_t = .{
//     BR_J,
//     BR_K,
//     c.COMBO_END,
// };
//
// pub export const key_combos = std.enums.directEnumArray(combos, c.combo_t, 0, .{
//   .JK_ESCAPE = c.COMBO(jk_combo, c.KC_ESCAPE),
// });

///////////////////
//// ACHORDION ////
///////////////////

// pub export fn process_record_user(keycode: keycode_t, record: ?*c.keyrecord_t) bool {
//     if (!c.process_achordion(keycode_t, record)) {
//         return false;
//     }
//
//     switch (keycode) {
//         c.RGB_SLD => {
//             if (record.?.*.event.pressed) {
//                 c.rgblight_mode(1);
//             }
//             return false;
//         },
//         else => {},
//     }
//
//     return true;
// }
//
// pub export fn matrix_scan_user() void {
//     c.achordion_task();
// }
//
// pub export fn achordion_chord(
//     tap_hold_keycode: keycode_t,
//     tap_hold_record: ?*c.keyrecord_t,
//     other_keycode: keycode_t,
//     other_record: ?*c.keyrecord_t,
// ) bool {
//     switch (tap_hold_keycode) {
//         // Bypass Achordion for right-hand mod+enter
//         BR_K => {
//             if (other_keycode == c.KC_ENTER) {
//                 return true;
//             }
//         },
//         else => {},
//     }
//
//     return c.achordion_opposite_hands(tap_hold_record, other_record);
// }
//
// pub export fn achordion_timeout(tap_hold_keycode: keycode_t) u16 {
//     switch (tap_hold_keycode) {
//         // Bypass Achordion for these keys
//         BR_BSPC,
//         BR_SPC,
//         BR_SPEC => {
//             return 0;
//         },
//         else => {},
//     }
//
//     return 500;
// }
//
// pub export fn achordion_streak_timeout(tap_hold_keycode: keycode_t) u16 {
//     _ = tap_hold_keycode;
//
//     return 100;
// }
