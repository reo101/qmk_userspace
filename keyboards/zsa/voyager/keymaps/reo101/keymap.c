#include QMK_KEYBOARD_H
#include "features/achordion.h"

enum custom_keycodes {
    RGB_SLD = SAFE_RANGE,
};

enum layers {
    BASE    = 0,
    LOWER   = 1,
    UPPER   = 2,
    SPECIAL = 3,
    GAMING  = 4,
};

// clang-format off
const uint16_t
   // Left HRM
    BR_A    = MT(MOD_LSFT, KC_A),
    BR_S    = MT(MOD_LCTL, KC_S),
    BR_D    = MT(MOD_LGUI, KC_D),
    BR_F    = MT(MOD_LALT, KC_F),

   // Right HRM
    BR_J    = MT(MOD_RALT, KC_J),
    BR_K    = MT(MOD_RGUI, KC_K),
    BR_L    = MT(MOD_RCTL, KC_L),
    BR_SCLN = MT(MOD_RSFT, KC_SCLN),

    // Layer toggles
    BR_BSPC = LT(LOWER, KC_BSPC),
    BR_SPC  = LT(UPPER, KC_SPACE),
    BR_SPEC = MO(SPECIAL);
// clang-format on

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    // clang-format off
    [BASE] = LAYOUT(
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,          XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
        XXXXXXX, KC_Q   , KC_W   , KC_E   , KC_R   , KC_T   ,          KC_Y   , KC_U   , KC_I   , KC_O   , KC_P   , XXXXXXX,
        XXXXXXX, BR_A   , BR_S   , BR_D   , BR_F   , KC_G   ,          KC_H   , BR_J   , BR_K   , BR_L   , BR_SCLN, KC_QUOT,
        XXXXXXX, KC_Z   , KC_X   , KC_C   , KC_V   , KC_B   ,          KC_N   , KC_M   , KC_COMM, KC_DOT , KC_SLSH, XXXXXXX,
                                            BR_BSPC, KC_TAB ,          KC_ENT , BR_SPC
    ),
    // clang-format on

    // clang-format off
    [LOWER] = LAYOUT(
        _______, _______, _______, _______, _______, _______,          _______, _______, _______, _______, _______, _______,
        KC_TILD, KC_EXLM, KC_AT  , KC_HASH, KC_DLR , KC_PERC,          KC_CIRC, KC_AMPR, KC_ASTR, KC_MINS, KC_EQL , _______,
        _______, KC_LABK, KC_LCBR, KC_LBRC, KC_LPRN, KC_BSLS,          KC_SLSH, KC_RPRN, KC_RBRC, KC_RCBR, KC_RABK, _______,
        _______, _______, _______, _______, KC_UNDS, KC_MINS,          KC_EQL , KC_PLUS, KC_MNXT, KC_VOLD, KC_VOLU, KC_MPLY,
                                            _______, _______,          _______, BR_SPEC
    ),
    // clang-format on

    // clang-format off
    [UPPER] = LAYOUT(
        _______, _______, _______, _______, _______, _______,          _______, _______, _______, _______, _______, _______,
        KC_NUBS, KC_1   , KC_2   , KC_3   , KC_4   , KC_5   ,          KC_6   , KC_7   , KC_8   , KC_9   , KC_0   , _______,
        KC_DEL , _______, _______, KC_BTN2, KC_BTN1, _______,          KC_LEFT, KC_DOWN, KC_UP  , KC_RGHT, _______, _______,
        _______, KC_PGDN, KC_PGUP, KC_END , KC_HOME, _______,          _______, _______, _______, _______, _______, _______,
                                            BR_SPEC, _______,          _______, _______
    ),
    // clang-format on

    // clang-format off
    [SPECIAL] = LAYOUT(
        DM_RSTP, RGB_TOG, RGB_MOD, _______, _______, _______,          _______, RGB_SPD, RGB_SPI, _______, _______, _______,
        _______, DM_REC1, DM_REC2, _______, _______, _______,          _______, RGB_HUD, RGB_HUI, _______, _______, _______,
        _______, DM_PLY1, DM_PLY2, _______, _______, _______,          _______, RGB_VAD, RGB_VAI, _______, _______, _______,
        _______, CM_TOGG, _______, _______, _______, _______,          _______, RGB_SAD, RGB_SAI, _______, _______, _______,
                                            _______, _______,          _______, _______
    ),
    // clang-format on

    // clang-format off
    [GAMING] = LAYOUT(
        KC_NUBS,    KC_1,    KC_2,    KC_3,    KC_4,    KC_5,             KC_6,    KC_7,    KC_8,    KC_9,    KC_0, _______,
        KC_TAB ,    KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,             KC_Y,    KC_U,    KC_I,    KC_P, KC_LBRC, _______,
        KC_LSFT,    KC_A,    KC_S,    KC_D,    KC_F,    KC_G,             KC_H,    KC_J,    KC_K,    KC_L, KC_SCLN, _______,
        KC_LCTL,    KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,             KC_N,    KC_M, KC_COMM,  KC_DOT, KC_SLSH, _______,
                                            _______, _______,          _______, _______
    ),
    // clang-format on
};

////////////////
//// COMBOS ////
////////////////

enum combos {
    JK_ESCAPE,
};

const uint16_t PROGMEM jk_combo[] = {
    BR_J,
    BR_K,
    COMBO_END,
};

combo_t key_combos[] = {
    [JK_ESCAPE] = COMBO(jk_combo, KC_ESCAPE),
};

///////////////////
//// ACHORDION ////
///////////////////

bool process_record_user(uint16_t keycode, keyrecord_t* record) {
    if (!process_achordion(keycode, record)) {
        return false;
    }

    switch (keycode) {
        case RGB_SLD: {
            if (record->event.pressed) {
                rgblight_mode(1);
            }
            return false;
        } break;
    }

    return true;
}

void matrix_scan_user(void) {
    achordion_task();
}

bool achordion_chord(
    // clang-format off
        uint16_t tap_hold_keycode,
    keyrecord_t* tap_hold_record,
        uint16_t other_keycode,
    keyrecord_t* other_record
    // clang-format on
) {
    switch (tap_hold_keycode) {
        // Bypass Achordion for right-hand mod+enter
        case BR_K: {
            if (other_keycode == KC_ENTER) {
                return true;
            }
        } break;
    }

    return achordion_opposite_hands(tap_hold_record, other_record);
}

uint16_t achordion_timeout(uint16_t tap_hold_keycode) {
    switch (tap_hold_keycode) {
        // Bypass Achordion for these keys
        case BR_BSPC:
        case BR_SPC:
        case BR_SPEC: {
            return 0;
        } break;
    }

    return 500;
}

#define ACHORDION_STREAK

uint16_t achordion_streak_timeout(uint16_t tap_hold_keycode) {
    return 100;
}
