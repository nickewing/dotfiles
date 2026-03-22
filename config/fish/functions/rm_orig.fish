function rm_orig
    gr && fd '\.orig' . | xargs rm && po
end
