-- acc-tools.lua
-- Wrapper for acc-tools extension with YAML toggle support

local sub_filters = {
  ["global-toggle"] = "global-toggle.global-toggle",
  ["code-blocks"]   = "code-blocks.code-blocks",
  ["acc-styles"]    = "acc-styles.acc-styles"
}

local toggles = {}
local collected = {}  -- table of Pandoc functions

-- Read YAML toggles
function Meta(meta)
  -- Stop if PDF or LaTeX format
  if FORMAT:match("pdf") or FORMAT:match("latex") then
    print("[acc-tools] PDF mode detected — skipping all subfilters.")
    return nil  -- do nothing; Pandoc will skip
  end
  
  local su_meta = meta["acc-tools"] or {}

  -- Check su_meta is in the right format
  if type(su_meta) ~= "table" then
    print("[acc-tools] ERROR: 'acc-tools' metadata must be list of pairs. Example format:")
    print("[acc-tools] acc-tools:")
    print("[acc-tools]   global-toggle: false")
    print("[acc-tools]   code-blocks: false")
    print("[acc-tools]   acc-styles: true")
    
    -- Don't quit. Just resest to all on and continue.
    print("[acc-tools] Applying default: all submodules enabled.")
    su_meta = {}

  end

  -- Default: all submodules enabled
  for name, _ in pairs(sub_filters) do
    toggles[name] = true
  end

  -- Override any user-specified false values
  for name, value in pairs(su_meta) do
    if value == false then
      toggles[name] = false
    end
    print("[acc-tools] Toggle for " .. name .. " = " .. tostring(toggles[name]))
  end

  -- Require submodules and collect their Pandoc functions
  for name, path in pairs(sub_filters) do
    if toggles[name] then
      local ok, mod = pcall(require, path)
      if ok then
        print("[acc-tools] Loading module: " .. path)
        -- Handle double-bracket return: { { Pandoc = func } }
        if type(mod) == "table" then
          for _, entry in ipairs(mod) do
            if type(entry) == "table" and type(entry.Pandoc) == "function" then
              table.insert(collected, entry.Pandoc)
            end
          end
        end
      else
        print("[acc-tools] Failed to load " .. path .. ": " .. tostring(mod))
      end
    else
      print("[acc-tools] Skipping module " .. path .. " (toggle = false)")
    end
  end
end

-- Compose all collected Pandoc functions into one
function Pandoc(doc)
  for _, func in ipairs(collected) do
    doc = func(doc) or doc
  end
  return doc
end

return { {Meta = Meta}, {Pandoc = Pandoc} }
