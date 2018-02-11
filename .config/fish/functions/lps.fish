function lps
  set -l username $LPS_DEFAULT_USERNAME
  set -l signedin 1

  if command -s lpass >/dev/null
    while test -z $username
      read --prompt-str 'lpass username: ' username
    end

    lpass login --trust $username >/dev/null 2>&1

    if test $status -eq 0
      set -l pass (lpass ls -l | lpfmt | eval "fzf $FZF_DEFAULT_OPTS --ansi --header='[lastpass:copy]'" | cut -d ' ' -f 1)

      if not test -z $pass
        echo $pass
      else
        echo "no pass selected"
      end
    end
  else
    echo "Please install [lpass] first"
  end
end