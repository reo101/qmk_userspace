#include QMK_KEYBOARD_H
#include "version.h"
#include "features/achordion.h"
#define MOON_LED_LEVEL LED_LEVEL

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

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  [BASE] = LAYOUT_voyager(
    KC_NO,          KC_NO,          KC_NO,          KC_NO,          KC_NO,          KC_NO,                                          KC_NO,          KC_NO,          KC_NO,          KC_NO,          KC_NO,          KC_NO,
    KC_NO,          KC_Q,           KC_W,           KC_E,           KC_R,           KC_T,                                           KC_Y,           KC_U,           KC_I,           KC_O,           KC_P,           KC_NO,
    KC_NO,          MT(MOD_LSFT, KC_A),MT(MOD_LCTL, KC_S),MT(MOD_LGUI, KC_D),MT(MOD_LALT, KC_F),KC_G,                                           KC_H,           MT(MOD_RALT, KC_J),MT(MOD_RGUI, KC_K),MT(MOD_RCTL, KC_L),MT(MOD_RSFT, KC_SCLN),KC_QUOTE,
    KC_NO,          KC_Z,           KC_X,           KC_C,           KC_V,           KC_B,                                           KC_N,           KC_M,           KC_COMMA,       KC_DOT,         KC_SLASH,       KC_NO,
                                                    LT(1,KC_BSPC),  KC_TAB,                                         KC_ENTER,       LT(2,KC_SPACE)
  ),
  [LOWER] = LAYOUT_voyager(
    KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT,                                 KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT,
    KC_TRANSPARENT, KC_EXLM,        KC_AT,          KC_HASH,        KC_DLR,         KC_PERC,                                        KC_CIRC,        KC_AMPR,        KC_ASTR,        KC_MINUS,       KC_EQUAL,       KC_TRANSPARENT,
    KC_TRANSPARENT, KC_LABK,        KC_LCBR,        KC_LBRC,        KC_LPRN,        KC_BSLS,                                        KC_SLASH,       KC_RPRN,        KC_RBRC,        KC_RCBR,        KC_RABK,        KC_TRANSPARENT,
    KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_UNDS,        KC_MINUS,                                       KC_EQUAL,       KC_PLUS,        KC_MEDIA_NEXT_TRACK,KC_AUDIO_VOL_DOWN,KC_AUDIO_VOL_UP,KC_MEDIA_PLAY_PAUSE,
                                                    KC_TRANSPARENT, KC_TRANSPARENT,                                 KC_TRANSPARENT, MO(3)
  ),
  [UPPER] = LAYOUT_voyager(
    KC_NUBS,        KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT,                                 KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT,
    KC_TRANSPARENT, KC_1,           KC_2,           KC_3,           KC_4,           KC_5,                                           KC_6,           KC_7,           KC_8,           KC_9,           KC_0,           KC_TRANSPARENT,
    KC_DELETE,      KC_TRANSPARENT, KC_TRANSPARENT, KC_MS_BTN2,     KC_MS_BTN1,     KC_TRANSPARENT,                                 KC_LEFT,        KC_DOWN,        KC_UP,          KC_RIGHT,       KC_TRANSPARENT, KC_TRANSPARENT,
    KC_TRANSPARENT, KC_PGDN,        KC_PAGE_UP,     KC_END,         KC_HOME,        KC_TRANSPARENT,                                 KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT,
                                                    MO(3),          KC_TRANSPARENT,                                 KC_TRANSPARENT, KC_TRANSPARENT
  ),
  [SPECIAL] = LAYOUT_voyager(
    DM_RSTP,        RGB_TOG,        RGB_MODE_FORWARD,KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT,                                 KC_TRANSPARENT, RGB_SPD,        RGB_SPI,        KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT,
    KC_TRANSPARENT, DM_REC1,        DM_REC2,        KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT,                                 KC_TRANSPARENT, RGB_HUD,        RGB_HUI,        KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT,
    KC_TRANSPARENT, DM_PLY1,        DM_PLY2,        KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT,                                 KC_TRANSPARENT, RGB_VAD,        RGB_VAI,        KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT,
    KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT,                                 KC_TRANSPARENT, RGB_SAD,        RGB_SAI,        KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT,
                                                    KC_TRANSPARENT, KC_TRANSPARENT,                                 KC_TRANSPARENT, KC_TRANSPARENT
  ),
  [GAMING] = LAYOUT_voyager(
    KC_NUBS,        KC_1,           KC_2,           KC_3,           KC_4,           KC_5,                                           KC_6,           KC_7,           KC_8,           KC_9,           KC_0,           KC_TRANSPARENT,
    KC_TAB,         KC_Q,           KC_W,           KC_E,           KC_R,           KC_T,                                           KC_Y,           KC_U,           KC_I,           KC_P,           KC_LBRC,        KC_TRANSPARENT,
    KC_LEFT_SHIFT,  KC_A,           KC_S,           KC_D,           KC_F,           KC_G,                                           KC_H,           KC_J,           KC_K,           KC_L,           KC_SCLN,        KC_TRANSPARENT,
    KC_LEFT_CTRL,   KC_Z,           KC_X,           KC_C,           KC_V,           KC_B,                                           KC_N,           KC_M,           KC_COMMA,       KC_DOT,         KC_SLASH,       KC_TRANSPARENT,
                                                    KC_TRANSPARENT, KC_TRANSPARENT,                                 KC_TRANSPARENT, KC_TRANSPARENT
  ),
};

const uint16_t PROGMEM combo0[] = {
    KC_J,
    KC_K,
    COMBO_END,
};

combo_t key_combos[] = {
    COMBO(combo0, KC_ESCAPE),
};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {

    case RGB_SLD:
      if (record->event.pressed) {
        rgblight_mode(1);
      }
      return false;
  }
  return true;
}
