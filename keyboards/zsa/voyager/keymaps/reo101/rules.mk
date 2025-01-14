# Set any rules.mk overrides for your specific keymap here.
# See rules at https://docs.qmk.fm/#/config_options?id=the-rulesmk-file
CONSOLE_ENABLE = no
COMMAND_ENABLE = no
ORYX_ENABLE = yes
RGB_MATRIX_CUSTOM_KB = yes
DYNAMIC_MACRO_ENABLE = yes
SPACE_CADET_ENABLE = no
COMBO_ENABLE = yes

SRC += ./features/achordion.c

CFLAGS += -w
# CFLAGS += -Wno-unused-function
CFLAGS += -I$(shell zig env | jq -r '.lib_dir')
