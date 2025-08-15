function rm_orig
  gr && rg --files | rg '\.orig' | xargs rm && po
end
