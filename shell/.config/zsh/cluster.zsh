function cluster_ssh {
    HOST="$1"

    [ -z "$HOST" ] && HOST="barrett2"

    if ! klist -s; then
      kinit aozdemir@CS.STANFORD.EDU || return
      aklog
    fi
    TERM=xterm-256color ssh $HOST
}
