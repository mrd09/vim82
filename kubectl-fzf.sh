#!/bin/bash
###################################
# The function for oc combination #
###################################

function kuctx() {
  if [[ "$1" == "-h" || "$1" == "--help" ]]; then
      echo "Usage:
      $FUNCNAME <CR> - abbreviation for 'kubectl ' + 'fzf namespace suggest'"
      echo
  else
      local ns=$(kubectl get ns | sed 1d | awk '{print $1}' | fzf -1 -q "$1" | awk '{print $1}')
      [ -n "${ns}" ] && echo "kubectl switch to ${ns}" && kubectl config set-context $(kubectl config current-context) --namespace=${ns}
  fi
}
