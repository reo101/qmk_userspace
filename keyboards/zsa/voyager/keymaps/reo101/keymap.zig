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
});
const layouts = @import("layouts.zig");

const custom_keycodes = enum(u32) {
    RGB_SLD = c.SAFE_RANGE,
};

const layers = enum(u3) {
    BASE = 0,
    LOWER = 1,
    UPPER = 2,
    SPECIAL = 3,
    GAMING = 4,
};

pub export const keymaps = std.enums.directEnumArray(layers, [12][7]u16, 0, .{
    // zig fmt: off
    .BASE = layouts.layout_voyager(u16,  c.KC_NO,.{
        c.KC_NO,          c.KC_NO,          c.KC_NO,          c.KC_NO,          c.KC_NO,          c.KC_NO,                                          c.KC_NO,          c.KC_NO,          c.KC_NO,          c.KC_NO,          c.KC_NO,          c.KC_NO,
        c.KC_NO,          c.KC_Q,           c.KC_W,           c.KC_E,           c.KC_R,           c.KC_T,                                           c.KC_Y,           c.KC_U,           c.KC_I,           c.KC_O,           c.KC_P,           c.KC_NO,
        c.KC_NO,          c.MT(c.MOD_LSFT, c.KC_A), c.MT(c.MOD_LCTL, c.KC_S), c.MT(c.MOD_LGUI, c.KC_D), c.MT(c.MOD_LALT, c.KC_F),c.KC_G,                                           c.KC_H,           c.MT(c.MOD_RALT, c.KC_J),c.MT(c.MOD_RGUI, c.KC_K),c.MT(c.MOD_RCTL, c.KC_L),c.MT(c.MOD_RSFT, c.KC_SCLN),c.KC_QUOTE,
        c.KC_NO,          c.KC_Z,           c.KC_X,           c.KC_C,           c.KC_V,           c.KC_B,                                           c.KC_N,           c.KC_M,           c.KC_COMMA,       c.KC_DOT,         c.KC_SLASH,       c.KC_NO,
                                                        c.LT(1,c.KC_BSPC),  c.KC_TAB,                                         c.KC_ENTER,       c.LT(2,c.KC_SPACE)
    }),
    // zig fmt: on
    // zig fmt: off
    .LOWER = layouts.layout_voyager(u16, c.KC_NO, .{
        c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT,                                 c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT,
        c.KC_TRANSPARENT, c.KC_EXLM,        c.KC_AT,          c.KC_HASH,        c.KC_DLR,         c.KC_PERC,                                        c.KC_CIRC,        c.KC_AMPR,        c.KC_ASTR,        c.KC_MINUS,       c.KC_EQUAL,       c.KC_TRANSPARENT,
        c.KC_TRANSPARENT, c.KC_LABK,        c.KC_LCBR,        c.KC_LBRC,        c.KC_LPRN,        c.KC_BSLS,                                        c.KC_SLASH,       c.KC_RPRN,        c.KC_RBRC,        c.KC_RCBR,        c.KC_RABK,        c.KC_TRANSPARENT,
        c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_UNDS,        c.KC_MINUS,                                       c.KC_EQUAL,       c.KC_PLUS,        c.KC_MEDIA_NEXT_TRACK,c.KC_AUDIO_VOL_DOWN,c.KC_AUDIO_VOL_UP,c.KC_MEDIA_PLAY_PAUSE,
                                                        c.KC_TRANSPARENT, c.KC_TRANSPARENT,                                 c.KC_TRANSPARENT, c.MO(3)
    }),
    // zig fmt: on
    // zig fmt: off
    .UPPER = layouts.layout_voyager(u16, c.KC_NO, .{
        c.KC_NUBS,        c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT,                                 c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT,
        c.KC_TRANSPARENT, c.KC_1,           c.KC_2,           c.KC_3,           c.KC_4,           c.KC_5,                                           c.KC_6,           c.KC_7,           c.KC_8,           c.KC_9,           c.KC_0,           c.KC_TRANSPARENT,
        c.KC_DELETE,      c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_MS_BTN2,     c.KC_MS_BTN1,     c.KC_TRANSPARENT,                                 c.KC_LEFT,        c.KC_DOWN,        c.KC_UP,          c.KC_RIGHT,       c.KC_TRANSPARENT, c.KC_TRANSPARENT,
        c.KC_TRANSPARENT, c.KC_PGDN,        c.KC_PAGE_UP,     c.KC_END,         c.KC_HOME,        c.KC_TRANSPARENT,                                 c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT,
                                                        c.MO(3),          c.KC_TRANSPARENT,                                 c.KC_TRANSPARENT, c.KC_TRANSPARENT
    }),
    // zig fmt: on
    // zig fmt: off
    .SPECIAL = layouts.layout_voyager(u16, c.KC_NO, .{
        c.DM_RSTP,        c.RGB_TOG,        c.RGB_MODE_FORWARD,c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT,                                 c.KC_TRANSPARENT, c.RGB_SPD,        c.RGB_SPI,        c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT,
        c.KC_TRANSPARENT, c.DM_REC1,        c.DM_REC2,        c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT,                                 c.KC_TRANSPARENT, c.RGB_HUD,        c.RGB_HUI,        c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT,
        c.KC_TRANSPARENT, c.DM_PLY1,        c.DM_PLY2,        c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT,                                 c.KC_TRANSPARENT, c.RGB_VAD,        c.RGB_VAI,        c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT,
        c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT,                                 c.KC_TRANSPARENT, c.RGB_SAD,        c.RGB_SAI,        c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT,
                                                        c.KC_TRANSPARENT, c.KC_TRANSPARENT,                                 c.KC_TRANSPARENT, c.KC_TRANSPARENT
    }),
    // zig fmt: on
    // zig fmt: off
    .GAMING = layouts.layout_voyager(u16, c.KC_NO, .{
        c.KC_NUBS,        c.KC_1,           c.KC_2,           c.KC_3,           c.KC_4,           c.KC_5,                                           c.KC_6,           c.KC_7,           c.KC_8,           c.KC_9,           c.KC_0,           c.KC_TRANSPARENT,
        c.KC_TAB,         c.KC_Q,           c.KC_W,           c.KC_E,           c.KC_R,           c.KC_T,                                           c.KC_Y,           c.KC_U,           c.KC_I,           c.KC_P,           c.KC_LBRC,        c.KC_TRANSPARENT,
        c.KC_LEFT_SHIFT,  c.KC_A,           c.KC_S,           c.KC_D,           c.KC_F,           c.KC_G,                                           c.KC_H,           c.KC_J,           c.KC_K,           c.KC_L,           c.KC_SCLN,        c.KC_TRANSPARENT,
        c.KC_LEFT_CTRL,   c.KC_Z,           c.KC_X,           c.KC_C,           c.KC_V,           c.KC_B,                                           c.KC_N,           c.KC_M,           c.KC_COMMA,       c.KC_DOT,         c.KC_SLASH,       c.KC_TRANSPARENT,
                                                      c.KC_TRANSPARENT, c.KC_TRANSPARENT,                                 c.KC_TRANSPARENT, c.KC_TRANSPARENT
    }),
    // zig fmt: on
});

// pub export const keymaps = keymaps: {
//     // var result: [_][c.MATRIX_COLS][c.MATRIX_ROWS]u16 = .{undefined} ** @typeInfo(layers).;
//     var result = std.enums.directEnumArray(layers, [c.MATRIX_COLS][c.MATRIX_ROWS]u16, 0, .{
// const segments = 2;
// const rows = 4;
// const cols = 6;

//     // zig fmt: off
//     result[layers.BASE] = layouts.layout_voyager(u16,  c.KC_NO,.{
//         c.KC_NO,          c.KC_NO,          c.KC_NO,          c.KC_NO,          c.KC_NO,          c.KC_NO,                                          c.KC_NO,          c.KC_NO,          c.KC_NO,          c.KC_NO,          c.KC_NO,          c.KC_NO,
//         c.KC_NO,          c.KC_Q,           c.KC_W,           c.KC_E,           c.KC_R,           c.KC_T,                                           c.KC_Y,           c.KC_U,           c.KC_I,           c.KC_O,           c.KC_P,           c.KC_NO,
//         c.KC_NO,          c.MT(c.MOD_LSFT, c.KC_A), c.MT(c.MOD_LCTL, c.KC_S), c.MT(c.MOD_LGUI, c.KC_D), c.MT(c.MOD_LALT, c.KC_F),c.KC_G,                                           c.KC_H,           c.MT(c.MOD_RALT, c.KC_J),c.MT(c.MOD_RGUI, c.KC_K),c.MT(c.MOD_RCTL, c.KC_L),c.MT(c.MOD_RSFT, c.KC_SCLN),c.KC_QUOTE,
//         c.KC_NO,          c.KC_Z,           c.KC_X,           c.KC_C,           c.KC_V,           c.KC_B,                                           c.KC_N,           c.KC_M,           c.KC_COMMA,       c.KC_DOT,         c.KC_SLASH,       c.KC_NO,
//                                                         c.LT(1,c.KC_BSPC),  c.KC_TAB,                                         c.KC_ENTER,       c.LT(2,c.KC_SPACE)
//     });
//     result[layers.LOWER] = layouts.layout_voyager(u16, c.KC_NO, .{
//         c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT,                                 c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT,
//         c.KC_TRANSPARENT, c.KC_EXLM,        c.KC_AT,          c.KC_HASH,        c.KC_DLR,         c.KC_PERC,                                        c.KC_CIRC,        c.KC_AMPR,        c.KC_ASTR,        c.KC_MINUS,       c.KC_EQUAL,       c.KC_TRANSPARENT,
//         c.KC_TRANSPARENT, c.KC_LABK,        c.KC_LCBR,        c.KC_LBRC,        c.KC_LPRN,        c.KC_BSLS,                                        c.KC_SLASH,       c.KC_RPRN,        c.KC_RBRC,        c.KC_RCBR,        c.KC_RABK,        c.KC_TRANSPARENT,
//         c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_UNDS,        c.KC_MINUS,                                       c.KC_EQUAL,       c.KC_PLUS,        c.KC_MEDIA_NEXT_TRACK,c.KC_AUDIO_VOL_DOWN,c.KC_AUDIO_VOL_UP,c.KC_MEDIA_PLAY_PAUSE,
//                                                         c.KC_TRANSPARENT, c.KC_TRANSPARENT,                                 c.KC_TRANSPARENT, c.MO(3)
//     });
//     result[layers.UPPER] = layouts.layout_voyager(u16, c.KC_NO, .{
//         c.KC_NUBS,        c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT,                                 c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT,
//         c.KC_TRANSPARENT, c.KC_1,           c.KC_2,           c.KC_3,           c.KC_4,           c.KC_5,                                           c.KC_6,           c.KC_7,           c.KC_8,           c.KC_9,           c.KC_0,           c.KC_TRANSPARENT,
//         c.KC_DELETE,      c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_MS_BTN2,     c.KC_MS_BTN1,     c.KC_TRANSPARENT,                                 c.KC_LEFT,        c.KC_DOWN,        c.KC_UP,          c.KC_RIGHT,       c.KC_TRANSPARENT, c.KC_TRANSPARENT,
//         c.KC_TRANSPARENT, c.KC_PGDN,        c.KC_PAGE_UP,     c.KC_END,         c.KC_HOME,        c.KC_TRANSPARENT,                                 c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT,
//                                                         c.MO(3),          c.KC_TRANSPARENT,                                 c.KC_TRANSPARENT, c.KC_TRANSPARENT
//     });
//     result[layers.SPECIAL] = layouts.layout_voyager(u16, c.KC_NO, .{
//         c.DM_RSTP,        c.RGB_TOG,        c.RGB_MODE_FORWARD,c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT,                                 c.KC_TRANSPARENT, c.RGB_SPD,        c.RGB_SPI,        c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT,
//         c.KC_TRANSPARENT, c.DM_REC1,        c.DM_REC2,        c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT,                                 c.KC_TRANSPARENT, c.RGB_HUD,        c.RGB_HUI,        c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT,
//         c.KC_TRANSPARENT, c.DM_PLY1,        c.DM_PLY2,        c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT,                                 c.KC_TRANSPARENT, c.RGB_VAD,        c.RGB_VAI,        c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT,
//         c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT,                                 c.KC_TRANSPARENT, c.RGB_SAD,        c.RGB_SAI,        c.KC_TRANSPARENT, c.KC_TRANSPARENT, c.KC_TRANSPARENT,
//                                                         c.KC_TRANSPARENT, c.KC_TRANSPARENT,                                 c.KC_TRANSPARENT, c.KC_TRANSPARENT
//     });
//     result[layers.GAMING] = layouts.layout_voyager(u16, c.KC_NO, .{
//       c.KC_NUBS,        c.KC_1,           c.KC_2,           c.KC_3,           c.KC_4,           c.KC_5,                                           c.KC_6,           c.KC_7,           c.KC_8,           c.KC_9,           c.KC_0,           c.KC_TRANSPARENT,
//       c.KC_TAB,         c.KC_Q,           c.KC_W,           c.KC_E,           c.KC_R,           c.KC_T,                                           c.KC_Y,           c.KC_U,           c.KC_I,           c.KC_P,           c.KC_LBRC,        c.KC_TRANSPARENT,
//       c.KC_LEFT_SHIFT,  c.KC_A,           c.KC_S,           c.KC_D,           c.KC_F,           c.KC_G,                                           c.KC_H,           c.KC_J,           c.KC_K,           c.KC_L,           c.KC_SCLN,        c.KC_TRANSPARENT,
//       c.KC_LEFT_CTRL,   c.KC_Z,           c.KC_X,           c.KC_C,           c.KC_V,           c.KC_B,                                           c.KC_N,           c.KC_M,           c.KC_COMMA,       c.KC_DOT,         c.KC_SLASH,       c.KC_TRANSPARENT,
//                                                       c.KC_TRANSPARENT, c.KC_TRANSPARENT,                                 c.KC_TRANSPARENT, c.KC_TRANSPARENT
//     });
//     // zig fmt: on
//     break :keymaps result;
// };

// const combo0: [_]u16 = {
//     c.KC_J,
//     c.KC_K,
//     COMBO_END,
// };
//
// combo_t key_combos[COMBO_COUNT] = {
//     COMBO(combo0, c.KC_ESCAPE),
// };
//
//
//
// bool process_record_user(uint16_t keycode, keyrecord_t *record) {
//   switch (keycode) {
//
//     case c.RGB_SLD:
//       if (record->event.pressed) {
//         rgblight_mode(1);
//       }
//       return false;
//   }
//   return true;
// }
//
//
//
