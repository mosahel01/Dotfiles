local colors = {
  -- Core colors based on provided theme
  fg = "#e2e2e2",         -- Main text color
  alt_fg = "#FFFF00",     -- Yellow for keywords/highlights
  bg = "#181818",         -- Dark gray background
  alt_bg = "#383838",     -- Lighter background for menus/popups
  cursorline = "#383838", -- Cursor line background
  cursor_bg = "#FFFF00",  -- Yellow cursor
  line = "#383838",       -- Line color

  -- Selection and highlight colors
  selection_bg = "#3d2f2f",        -- Selection background (darker version)
  selection_highlight = "#3d2f2f", -- Selection highlight
  word_highlight = "#2f2f2f",      -- Word highlight background (darker)
  find_match = "#3d2f2f",          -- Find match background
  bracket_match = "#2f2f2f",       -- Bracket match background

  -- Syntax colors based on provided theme
  _red = "#FF4444",           -- Red for errors/warnings
  _white = "#e2e2e2",         -- Main white text
  _light_blue = "#888888",    -- Gray-ish blue
  _blue = "#888888",          -- Muted blue/gray
  _yellow = "#FFFF00",        -- Bright yellow for keywords
  _green = "#00FF00",         -- Bright green for strings
  _green_light = "#003300",   -- Dark green background
  _green_alt = "#00AA00",     -- Alt green
  _type_color = "#bfc566",    -- Types, macros color from theme
  _namespace = "#919191",     -- Namespace color from theme
  _grey_dark = "#666666",     -- Dark gray for comments
  _pink = "#888888",          -- Muted pink
  _pink_light = "#222222",    -- Dark pink background
  _pink_alt = "#888888",      -- Alt pink
  _pink_dark_alt = "#888888", -- Dark alt pink
  _purple = "#888888",        -- Muted purple
  _purple_light = "#222222",  -- Dark purple background
  _orange = "#888888",        -- Muted orange
  _orange_light = "#222222",  -- Dark orange background
  hint = "#111111",           -- Hint color
  cyan = "#888888",           -- Muted cyan

  -- System colors for compatibility
  system_green_light = "#003300",
  system_orange_light = "#222222",
  system_pink_light = "#222222",
  system_blue = "#111111",

  -- Additional compatibility colors
  orange = "#888888",
  blue = "#888888",
  green = "#00FF00",
  purple = "#888888",
  light_gray = "#666666",
  gray = "#444444",
}

return colors
