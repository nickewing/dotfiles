function repeat -a n
  while test $n -gt 0; $argv[2..]
    set n (math $n - 1)
  end
end
