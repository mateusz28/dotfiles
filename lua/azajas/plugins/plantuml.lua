-- install without yarn or npm
return {
  "weirongxu/plantuml-previewer.vim",
  dependencies = {
    "tyru/open-browser.vim",
    "aklt/plantuml-syntax",
  },
  event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "plantuml", "markdown" },
}
