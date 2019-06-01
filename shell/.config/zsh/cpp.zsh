function gdb-alias() {
   local cmdargs
   cmdargs=( $(whence $1) )
   shift
   cmdargs=( $cmdargs $@ )
   gdb -q --args $cmdargs
}
