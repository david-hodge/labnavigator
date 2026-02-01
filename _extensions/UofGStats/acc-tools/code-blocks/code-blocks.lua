-- improve_code_blocks.lua
-- Quarto Lua filter to improve code blocks

function improve_code_blocks()
  -- Add CSS(head) + JS(after-body)
  quarto.doc.add_html_dependency({
    name = "improve-code-blocks",
    version = "1.0",
    stylesheets = {"code-blocks/visible-copy.css", "code-blocks/code-switcher.css"},
    scripts = {
      { path = "code-blocks/copy-button.js", attribs = {defer = "defer"}, afterBody = true}
      }
  })
  print("[code-blocks] Done.")
end

return {
  { Pandoc = improve_code_blocks }
}
