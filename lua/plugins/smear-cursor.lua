-- smear-cursor.nvim: draws a smooth "tail" between the old and new cursor
-- position on jumps (e.g. `G`, `}`, `]f`, search hops).
return {
  "sphamba/smear-cursor.nvim",
  event = "VeryLazy",
  opts = {
    -- Keep the effect snappy so it doesn't feel laggy during fast motion.
    stiffness = 0.8,
    trailing_stiffness = 0.5,
    distance_stop_animating = 0.5,
    hide_target_hack = false,
  },
}
