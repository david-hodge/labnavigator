-- global-toggle.lua
-- Quarto Lua filter to add global code toggle functionality

function add_global_toggle()
  -- Add CSS(head) + JS(after-body)
  quarto.doc.add_html_dependency({
    name = "global-toggle",
    version = "1.0",
    stylesheets = {"global-toggle/global-toggle.css"},
    scripts = {
      { path = "global-toggle/global-toggle.js", attribs = {defer = "defer"}, afterBody = true}
      }
  })

  -- Inject HTML at the end of body
  quarto.doc.include_file("after-body", "global-toggle/global-toggle.html")
  print("[global-toggle] Done.")
end

return {
  { Pandoc = add_global_toggle }
}
