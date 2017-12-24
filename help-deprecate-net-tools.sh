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
  echo -n "    "; echo -n `which ${FUNCNAME[1]}`; echo " $*"
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
  deprecate-net-tools-orig $*
  return 1
}


function ifconfig {
  deprecate-net-tools-warning
  if [[ $# == 0 ]]; then
    echo "    ip a (addr)"
  elif [[ $# == 1 ]]; then
    echo "    ip a show dev $1"
  elif [[ $2 == "add" ]]; then
    echo "    ip a add $2 dev $1"
  elif [[ $2 == "allmulti" ]]; then
    echo "    ip mr iif $1"
  elif [[ $2 == "arp" ]]; then
    echo "    ip link set arp on dev $1"
  elif [[ $2 == "-arp" ]]; then
    echo "    ip link set arp off dev $1"
  elif [[ $2 == "broadcast" ]]; then
    echo "    ip a add broadcast on dev $1"
  elif [[ $2 == "-broadcast" ]]; then
    echo "    ip a add broadcast off dev $1"
  elif [[ $2 == "del" ]]; then
    echo "    ip a del $3 dev $1"
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
  deprecate-net-tools-orig $*
  return 1
}


function iptunnel {
  deprecate-net-tools-warning
  echo "    ip tunnel"
  deprecate-net-tools-orig $*
  return 1
}


function iwconfig {
  deprecate-net-tools-warning
  echo "    iw"
  deprecate-net-tools-orig $*
  return 1
}


function nameif {
  deprecate-net-tools-warning
  echo "    ip link"
  echo "    ifrename"
  deprecate-net-tools-orig $*
  return 1
}


function netstat {
  deprecate-net-tools-warning
  echo "    ss"
  echo "    iproute"
  echo "    ip -s link"
  echo "    ip maddr"
  deprecate-net-tools-orig $*
  return 1
}


function route {
  deprecate-net-tools-warning
  echo "    ip r (route)"
  deprecate-net-tools-orig $*
  return 1
}
