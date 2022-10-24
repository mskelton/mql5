#ifndef DEFINES_H
#define DEFINES_H

enum ENUM_WND_PROP_FLAGS {
  WND_PROP_FLAG_CAN_DBL_CLICK = 1,
  WND_PROP_FLAG_CAN_DRAG = 2,
  WND_PROP_FLAG_CLICKS_BY_PRESS = 4,
  WND_PROP_FLAG_CAN_LOCK = 8,
  WND_PROP_FLAG_READ_ONLY = 16
};

enum ENUM_WND_STATE_FLAGS {
  WND_STATE_FLAG_ENABLE = 1,
  WND_STATE_FLAG_VISIBLE = 2,
  WND_STATE_FLAG_ACTIVE = 4,
};

enum ENUM_MOUSE_FLAGS {
  MOUSE_INVALID_FLAGS = -1,
  MOUSE_EMPTY = 0,
  MOUSE_LEFT = 1,
  MOUSE_RIGHT = 2
};

enum ENUM_WND_ALIGN_FLAGS {
  WND_ALIGN_NONE = 0,
  WND_ALIGN_LEFT = 1,
  WND_ALIGN_TOP = 2,
  WND_ALIGN_RIGHT = 4,
  WND_ALIGN_BOTTOM = 8,
  WND_ALIGN_WIDTH = WND_ALIGN_LEFT | WND_ALIGN_RIGHT,
  WND_ALIGN_HEIGHT = WND_ALIGN_TOP | WND_ALIGN_BOTTOM,
  WND_ALIGN_CLIENT = WND_ALIGN_WIDTH | WND_ALIGN_HEIGHT
};

#define CONTROLS_FONT_NAME "Trebuchet MS"
#define CONTROLS_FONT_SIZE (10)

#define CONTROLS_COLOR_TEXT C '0x3B,0x29,0x28'
#define CONTROLS_COLOR_TEXT_SEL White
#define CONTROLS_COLOR_BG White
#define CONTROLS_COLOR_BG_SEL C '0x33,0x99,0xFF'

#define CONTROLS_BUTTON_COLOR C '0x3B,0x29,0x28'
#define CONTROLS_BUTTON_COLOR_BG C '0xDD,0xE2,0xEB'
#define CONTROLS_BUTTON_COLOR_BORDER C '0xB2,0xC3,0xCF'

#define CONTROLS_LABEL_COLOR C '0x3B,0x29,0x28'

#define CONTROLS_EDIT_COLOR C '0x3B,0x29,0x28'
#define CONTROLS_EDIT_COLOR_BG White
#define CONTROLS_EDIT_COLOR_BORDER C '0xB2,0xC3,0xCF'

#define CONTROLS_SCROLL_COLOR_BG C '0xEC,0xEC,0xEC'
#define CONTROLS_SCROLL_COLOR_BORDER C '0xD3,0xD3,0xD3'

#define CONTROLS_CLIENT_COLOR_BG C '0xDE,0xDE,0xDE'
#define CONTROLS_CLIENT_COLOR_BORDER C '0x2C,0x2C,0x2C'

#define CONTROLS_LISTITEM_COLOR_TEXT C '0x3B,0x29,0x28'
#define CONTROLS_LISTITEM_COLOR_TEXT_SEL White
#define CONTROLS_LISTITEM_COLOR_BG White
#define CONTROLS_LISTITEM_COLOR_BG_SEL C '0x33,0x99,0xFF'
#define CONTROLS_LIST_COLOR_BG White
#define CONTROLS_LIST_COLOR_BORDER C '0xB2,0xC3,0xCF'

#define CONTROLS_CHECKGROUP_COLOR_BG C '0xF7,0xF7,0xF7'
#define CONTROLS_CHECKGROUP_COLOR_BORDER C '0xB2,0xC3,0xCF'

#define CONTROLS_RADIOGROUP_COLOR_BG C '0xF7,0xF7,0xF7'
#define CONTROLS_RADIOGROUP_COLOR_BORDER C '0xB2,0xC3,0xCF'

#define CONTROLS_DIALOG_COLOR_BORDER_LIGHT White
#define CONTROLS_DIALOG_COLOR_BORDER_DARK C '0xB6,0xB6,0xB6'
#define CONTROLS_DIALOG_COLOR_BG C '0xF0,0xF0,0xF0'
#define CONTROLS_DIALOG_COLOR_CAPTION_TEXT C '0x28,0x29,0x3B'
#define CONTROLS_DIALOG_COLOR_CLIENT_BG C '0xF7,0xF7,0xF7'
#define CONTROLS_DIALOG_COLOR_CLIENT_BORDER C '0xC8,0xC8,0xC8'

#define CONTROLS_INVALID_ID (-1)
#define CONTROLS_INVALID_INDEX (-1)
#define CONTROLS_SELF_MESSAGE (-1)
#define CONTROLS_MAXIMUM_ID (10000)
#define CONTROLS_BORDER_WIDTH (1)
#define CONTROLS_SUBWINDOW_GAP (3)
#define CONTROLS_DRAG_SPACING (50)
#define CONTROLS_DBL_CLICK_TIME (100)

#define CONTROLS_BUTTON_SIZE (16)

#define CONTROLS_SCROLL_SIZE (18)
#define CONTROLS_SCROLL_THUMB_SIZE (22)

#define CONTROLS_RADIO_BUTTON_X_OFF (3)
#define CONTROLS_RADIO_BUTTON_Y_OFF (3)
#define CONTROLS_RADIO_LABEL_X_OFF (20)
#define CONTROLS_RADIO_LABEL_Y_OFF (0)

#define CONTROLS_CHECK_BUTTON_X_OFF (3)
#define CONTROLS_CHECK_BUTTON_Y_OFF (3)
#define CONTROLS_CHECK_LABEL_X_OFF (20)
#define CONTROLS_CHECK_LABEL_Y_OFF (0)

#define CONTROLS_SPIN_BUTTON_X_OFF (2)
#define CONTROLS_SPIN_MIN_HEIGHT (18)
#define CONTROLS_SPIN_BUTTON_SIZE (8)

#define CONTROLS_COMBO_BUTTON_X_OFF (2)
#define CONTROLS_COMBO_MIN_HEIGHT (18)
#define CONTROLS_COMBO_ITEM_HEIGHT (18)
#define CONTROLS_COMBO_ITEMS_VIEW (8)

#define CONTROLS_LIST_ITEM_HEIGHT (18)

#define CONTROLS_DIALOG_CAPTION_HEIGHT (22)
#define CONTROLS_DIALOG_BUTTON_OFF (3)
#define CONTROLS_DIALOG_CLIENT_OFF (2)
#define CONTROLS_DIALOG_MINIMIZE_LEFT (10)
#define CONTROLS_DIALOG_MINIMIZE_TOP (10)
#define CONTROLS_DIALOG_MINIMIZE_WIDTH (100)
#define CONTROLS_DIALOG_MINIMIZE_HEIGHT                                        \
  (4 * CONTROLS_BORDER_WIDTH + CONTROLS_DIALOG_CAPTION_HEIGHT)

#define IS_CAN_DBL_CLICK ((m_prop_flags & WND_PROP_FLAG_CAN_DBL_CLICK) != 0)
#define IS_CAN_DRAG ((m_prop_flags & WND_PROP_FLAG_CAN_DRAG) != 0)
#define IS_CLICKS_BY_PRESS ((m_prop_flags & WND_PROP_FLAG_CLICKS_BY_PRESS) != 0)
#define IS_CAN_LOCK ((m_prop_flags & WND_PROP_FLAG_CAN_LOCK) != 0)
#define IS_READ_ONLY ((m_prop_flags & WND_PROP_FLAG_READ_ONLY) != 0)

#define IS_ENABLED ((m_state_flags & WND_STATE_FLAG_ENABLE) != 0)
#define IS_VISIBLE ((m_state_flags & WND_STATE_FLAG_VISIBLE) != 0)
#define IS_ACTIVE ((m_state_flags & WND_STATE_FLAG_ACTIVE) != 0)

#define INTERNAL_EVENT (-1)

#define EVENT_MAP_BEGIN(class_name)                                            \

#define ON_EVENT(event, control, handler)                                      \
  if (id == (event + CHARTEVENT_CUSTOM) && lparam == control.Id()) ;           \

#define ON_EVENT_PTR(event, control, handler)                                  \
  if (control != NULL && id == (event + CHARTEVENT_CUSTOM) &&                  \
      lparam == control.Id()) ;                                                \

#define ON_NO_ID_EVENT(event, handler)                                         \
  if (id == (event + CHARTEVENT_CUSTOM)) ;                                     \

#define ON_NAMED_EVENT(event, control, handler)                                \
  if (id == (event + CHARTEVENT_CUSTOM) && sparam == control.Name()) ;         \

#define ON_INDEXED_EVENT(event, controls, handler)                             \
  ;                                                                            \

#define ON_EXTERNAL_EVENT(event, handler)                                      \
  if (id == (event + CHARTEVENT_CUSTOM)) ;                                     \

#define ON_CLICK (0)
#define ON_DBL_CLICK (1)
#define ON_SHOW (2)
#define ON_HIDE (3)
#define ON_CHANGE (4)
#define ON_START_EDIT (5)
#define ON_END_EDIT (6)
#define ON_SCROLL_INC (7)
#define ON_SCROLL_DEC (8)
#define ON_MOUSE_FOCUS_SET (9)
#define ON_MOUSE_FOCUS_KILL (10)
#define ON_DRAG_START (11)
#define ON_DRAG_PROCESS (12)
#define ON_DRAG_END (13)
#define ON_BRING_TO_TOP (14)
#define ON_APP_CLOSE (100)

#endif
