local extension = {}
extension["es6"] = "javascript"
extension["ngrb"] = "ruby"

local pattern = {}
pattern[".*.envrc"] = "sh"
pattern[".*.envrc.sample"] = "sh"
pattern[".*.env"] = "sh"
pattern[".*.env.sample"] = "sh"

vim.filetype.add({
  extension = extension,
  pattern = pattern
})
