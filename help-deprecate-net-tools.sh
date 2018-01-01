#!/bin/bash
#
# help-deprecate-net-tools functions
#
# These functions are for humans, to help them migrate from the
# deprecated net-tools commands to their modern replacements.
#
# Most of the knowledge encoded in these helpers come from:
#
#   http://dougvitale.wordpress.com/2011/12/21/deprecated-linux-networking-commands-and-their-replacements
#
# The original source of these functions is in:
#
#   https://github.com/solarkennedy/help-deprecate-net-tools/
#


function deprecate-net-tools-orig {
  echo ""
  echo "If you need to run the command exactly, you can use the full path:"
  echo ""
  echo -n "    "
  echo -n "$(which "${FUNCNAME[1]}")"
  echo " $*"
  echo ""
}


function deprecate-net-tools-warning {
  echo "The '${FUNCNAME[1]}' command has been deprecated, try typing:"
  echo ""
}


function arp {
  deprecate-net-tools-warning
  if [[ $1 == "-a" ]] || [[ $1 == "--all" ]]; then
    echo "    ip n show"
  elif [[ $1 == "-d" ]] || [[ $1 == "--delete" ]]; then
    echo "    ip n del $2"
    echo "or"
    echo "    ip n flush $2"
  elif [[ $1 == "-i" ]] || [[ $1 == "--device" ]]; then
    echo "    ip n [add|chg|del|repl] dev $2"
  elif [[ $1 == "-s" ]] || [[ $1 == "--set" ]]; then
    echo "    ip n add $2 lladdr $3 dev [device] nud [nud_state]"
  elif [[ $1 == "-v" ]] || [[ $1 == "--device" ]]; then
    echo "    ip -s n"
  else
    echo "    ip n help"
    echo ""
    echo "(I'm not sure exactly what the exact replacement command is)"
  fi
  deprecate-net-tools-orig "$*"
  return 1
}


function ifconfig {
  deprecate-net-tools-warning
  if [[ $# == 0 ]]; then
    echo "    ip addr"
  elif [[ $# == 1 ]]; then
    echo "    ip addr show dev $1"
  elif [[ $2 == "add" ]]; then
    echo "    ip addr add $2 dev $1"
  elif [[ $2 == "allmulti" ]]; then
    echo "    ip mr iif $1"
  elif [[ $2 == "arp" ]]; then
    echo "    ip link set arp on dev $1"
  elif [[ $2 == "-arp" ]]; then
    echo "    ip link set arp off dev $1"
  elif [[ $2 == "broadcast" ]]; then
    echo "    ip addr add broadcast on dev $1"
  elif [[ $2 == "-broadcast" ]]; then
    echo "    ip addr add broadcast off dev $1"
  elif [[ $2 == "del" ]]; then
    echo "    ip addr del $3 dev $1"
  elif [[ $2 == "up" ]]; then
    echo "    ip link set $1 up"
  elif [[ $2 == "down" ]]; then
    echo "    ip link set dev $1 down"
  elif [[ $2 == "mtu" ]]; then
    echo "    ip link set dev $1 mtu $3"
  elif [[ $2 == "multicast" ]]; then
    echo "    ip link set dev $1 multicast $3"
  elif [[ $2 == "promisc" ]]; then
    echo "    ip link set dev $1 promisc on"
  elif [[ $2 == "-promisc" ]]; then
    echo "    ip link set dev $1 promisc off"
  elif [[ $2 == "txquelen" ]]; then
    echo "    ip link set dev $1 txqueuelen $3"
  elif [[ $2 == "tunnel" ]]; then
    echo "    ip tunnel mode sit $1"
  else
    echo "    ip link"
    echo ""
    echo "(I'm not sure exactly what the exact replacement command is)"
  fi
  deprecate-net-tools-orig "$*"
  return 1
}


function iptunnel {
  deprecate-net-tools-warning
  echo "    ip tunnel $*"
  deprecate-net-tools-orig "$*"
  return 1
}


function iwconfig {
  deprecate-net-tools-warning
  if [[ $# == 0 ]]; then
    echo "    ip dev"
  elif [[ $# == 1 ]]; then
    echo "    iw dev $1 link"
  elif [[ $2 == "essid" ]]; then
    echo "    iw $1 connect $2"
  elif [[ $2 == "mode" ]]; then
    echo "    iw $1 mode $3"
  elif [[ $2 == "freq" ]]; then
    echo "    iw $1 connect [ESSID] $3"
  elif [[ $2 == "bit" ]] || [[ $2 == "rate" ]]; then
    echo "    iw $1 set bitrates legacy-2.4 $3"
  elif [[ $2 == "enc" ]] || [[ $2 == "key" ]]; then
    echo "    iw $1 connect [ESSID] keys 0:$3"
  elif [[ $2 == "power" ]]; then
    echo "    iw dev $1 set power_save $3"
  elif [[ $2 == "nickname" ]]; then
    echo "    # iw doesn't support setting a station name"
  elif [[ $2 == "nwid" ]]; then
    echo "    # iw doesn't support setting an nwid (pre-802.11)"
  elif [[ $2 == "ap" ]]; then
    echo "    iw $1 connect $3"
  elif [[ $2 == "txpower" ]]; then
    echo "    iw dev $1 set txpower $3"
  elif [[ $2 == "sens" ]]; then
    echo "    # iw doesn't support setting the sensitivity"
  elif [[ $2 == "retry" ]]; then
    echo "    iw phy $1 set retry $3"
  elif [[ $2 == "rts" ]]; then
    echo "    iw phy $1 set rts $3"
  elif [[ $2 == "frag" ]]; then
    echo "    iw phy $1 set frag $3"
  elif [[ $2 == "modulation" ]]; then
    echo "    # iw doesn't support setting the modulation"
  elif [[ $2 == "commit" ]]; then
    echo "    # iw doesn't support 'commit'"
  else
    echo "    iw dev"
    echo ""
    echo "(I'm not sure exactly what the exact replacement command is)"
  fi
  deprecate-net-tools-orig "$*"
  return 1
}


function nameif {
  deprecate-net-tools-warning
  if [[ $1 == "-c" ]]; then
    echo "    ifrename -c $2"
  elif [[ $2 == "-s" ]]; then
    echo "    # ifrename doesn't support -s"
  elif [[ $# -ge 1 ]]; then
    echo "    ip link set dev $1 name [new name]"
    echo "    # or"
    echo "    ifrename -i $1 -n [new name]"
  else
    echo "    ifrename"
    echo "    # I'm not sure exactly what the replacement command is"
  fi
  deprecate-net-tools-orig "$*"
  return 1
}


function netstat {
  local ORIG_ARGS TEMP SS_OPTS
  ORIG_ARGS="$*"
  deprecate-net-tools-warning
  TEMP=$(getopt -o tuUSwx64rigsMvWnNepoclA::aFCZ --long route,interfaces,groups,statistics,masquerade,verbose,wide,numeric,numeric-hosts,numeric-ports,numeric-users,symbolic,extend,program,timers,continuous,listening,all,fib,cache,context,tcp,udp,udplite,sctp,raw,unix,ax25,ipx,netrom,af,protocol:: -- "$@")
  eval set -- "$TEMP"
  #return 1
  while true; do
    case "$1" in
      -r|--route)
        echo "    ip route"
	;;
      -i|--interfaces)
        echo "    ip -s link"
	;;
      -g|--groups)
        echo "    ip maddr"
        ;;
      -M|--masquerade)
        echo "# there is no equivalent ss option for showing masqueraded connections"
        ;;
      -v|--verbose)
        echo "# there is no equivalent ss option for --verbose"
        ;;
      -W|--wide)
        echo "# there is no equivalent ss option for not truncating ips"
        ;;
      -l|--listening)
        SS_OPTS="${SS_OPTS}l"
        ;;
      -n|--numeric)
        SS_OPTS="${SS_OPTS}n"
        ;;
      -p|--program)
        SS_OPTS="${SS_OPTS}p"
        ;;
      --numeric-hosts)
        echo "# there is no equivalent ss option for --numeric-hosts"
        ;;
      --numeric-ports)
        echo "# there is no equivalent ss option for --numeric-ports"
        ;;
      --numeric-users)
        echo "# there is no equivalent ss option for --numeric-users"
        ;;
      -N|--symbolic)
        SS_OPTS="${SS_OPTS}r"
        ;;
      -e|--extend)
        SS_OPTS="${SS_OPTS}e"
        ;;
      -o|--timers)
        SS_OPTS="${SS_OPTS}o"
        ;;
      -c|--continuous)
        echo "# ss doesn't have a native way to output continouous output."
        echo "# but you can prepend it with the 'watch' command to simulate that behavior."
        ;;
      -a|--all)
        SS_OPTS="${SS_OPTS}a"
        ;;
      -F|--fib)
        echo "    ip -s route show cache"
        ;;
      -C|--cache)
        echo "    ip route list cache"
        ;;
      -s|--statistics)
        SS_OPTS="${SS_OPTS}s"
        ;;
      -T|--notrim)
        echo "# ss doesn't support --notrim"
        ;;
      -t|--tcp)
        SS_OPTS="${SS_OPTS}t"
        ;;
      -u|--udp)
        SS_OPTS="${SS_OPTS}u"
        ;;
      -w|--raw)
        SS_OPTS="${SS_OPTS}w"
        ;;
      -x|--unix)
        SS_OPTS="${SS_OPTS}x"
        ;;
      -Z|--context)
        SS_OPTS="${SS_OPTS}Z"
        ;;
      --)
        break
        ;;
    esac
    shift
  done
  if [[ ! -z $SS_OPTS ]]; then
    echo "    ss -${SS_OPTS}"
  fi
  deprecate-net-tools-orig "$ORIG_ARGS"
  return 1
}


function route {
  deprecate-net-tools-warning
  if [[ $# == 0 ]]; then
    echo "    ip route"
  elif [[ $1 == "-A" ]]; then
    echo "    ip -f $2 $3"
  elif [[ $1 == "-C" ]] || [[ $1 == "--cache" ]]; then
    echo "    ip route show cache"
  elif [[ $1 == "-e" ]] || [[ $1 == "-ee" ]]; then
    echo "    ip route show"
  elif [[ $1 == "-F" ]] || [[ $1 == "--fib" ]]; then
    echo "    ip route show cache"
  elif [[ $1 == "-h" ]] || [[ $1 == "--help" ]]; then
    echo "    ip route help"
  elif [[ $1 == "-n" ]]; then
    echo "    ip route"
    echo "    # The ip command disables network resolution by default"
  elif [[ $1 == "-V" ]] || [[ $1 == "--version" ]]; then
    echo "    ip -V"
  elif [[ $1 == "add" ]] || [[ $1 == "del" ]]; then
    if [[ $2 == "dev" ]]; then
      echo "    ip route $1 dev $3"
    elif [[ $2 == "gw" ]] || [[ $3 == "gw" ]]; then
      echo "    ip route $1 default via $4"
    elif [[ $2 == "-host" ]] || [[ $2 == "-net" ]]; then
      echo "    # There is no equivilant ip route command for $2"
    elif [[ $2 == "metric" ]]; then
      echo "    ip route $1 metric $2"
    elif [[ $2 == "mod" ]] || [[ $2 == "dyn" ]] || [[ $2 == "reinstate" ]]; then
      echo "    # There is no equivilant ip route command for $2"
    elif [[ $2 == "mss" ]]; then
      echo "    ip route $1 advmss $2"
    elif [[ $2 == "reject" ]]; then
      echo "    ip route $1 prohibit $2"
    elif [[ $2 == "window" ]]; then
      echo "    ip route $1 window $2"
    else
      echo "    ip route $*"
    fi
  else
    echo "    ip route help"
    echo "    # I'm not sure what the equivilant ip route command is"
  fi
  deprecate-net-tools-orig "$*"
  return 1
}
