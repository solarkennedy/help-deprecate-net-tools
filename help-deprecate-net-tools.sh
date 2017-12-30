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
  deprecate-net-tools-warning
  echo "    ss"
  echo "    iproute"
  echo "    ip -s link"
  echo "    ip maddr"
  deprecate-net-tools-orig "$*"
  return 1
}


function route {
  deprecate-net-tools-warning
  echo "    ip r (route)"
  deprecate-net-tools-orig "$*"
  return 1
}
