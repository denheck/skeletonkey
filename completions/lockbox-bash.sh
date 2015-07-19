_lockbox()
{
  local cur prev opts cmd
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  cmd=lockbox

  case "${prev}" in
    add|get|remove)
      opts="`$cmd list | tr '\n' ' '`"
      ;;
    list)
      opts=""
      ;;
    *)
      opts="`$cmd | awk '{ print $2}' | tr '\n' ' '`"
      ;;
  esac

  COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
  return 0
}

complete -F _lockbox lockbox
