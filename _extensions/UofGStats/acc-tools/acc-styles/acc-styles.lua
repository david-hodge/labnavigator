-- acc-styles.lua
-- Quarto Lua filter to add accessibility styles globally

function add_acc_styles()
  -- Add the CSS(head) file as a global dependency
  quarto.doc.add_html_dependency({
    name = "acc-styles",
    version = "1.0",
    stylesheets = {"acc-styles/acc-styles.css"}
  })
  print("[acc-styles] Done.")
end

return {
  { Pandoc = add_acc_styles }
}