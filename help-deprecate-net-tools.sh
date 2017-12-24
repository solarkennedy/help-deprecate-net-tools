#!/bin/bash

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
  echo "    ip n (neighbor)"
  deprecate-net-tools-orig $*
  return 1
}


function ifconfig {
  deprecate-net-tools-warning
  echo "    ip a (addr)"
  echo "    ip link"
  echo "    ip -s (-stats)"
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
