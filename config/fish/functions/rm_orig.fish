function rm_orig
  rg --files | rg '\.orig' | xargs rm
end
