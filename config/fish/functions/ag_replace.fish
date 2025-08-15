function ag_replace -a search_str replace_str dir
  ag -l $search_str $dir | xargs perl -pi -E "s/$search_str/$replace_str/g"
end
