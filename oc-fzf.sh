#!/bin/bash
############################
# Root command extract info:
############################
# 1. get resource name:
: '
## oc api-resources | sed 1d | awk '{print $1}' | fzf -1 -q "$1" | awk '{print $1}'
...
clusterresourcequotas
clusterrolebindings
clusterroles
rolebindings
...
'

# 2. get namespace name:
: '
## oc get ns | sed 1d | awk '{print $1}' | fzf -1 -q "$1" | awk '{print $1}'
...
local-cicd
local-common-dev
local-common-qa
...
'

# 3. get pod name:
: '
## oc get pods | sed 1d | awk '{print $1}' | fzf -1 -q "$1" | awk '{print $1}'
...
pod1-asdlfj
pod2-qwkell
...
'

#########################
# The command line help #
#########################
example_display_help() {
  if [[ "$1" == "-h" || "$1" == "--help" ]]; then
      echo "Usage: $FUNCNAME ..."
      echo
  else
      echo
  fi
}

###################################
# The function for oc combination #
###################################

function ocns() {
  if [[ "$1" == "-h" || "$1" == "--help" ]]; then
      echo "Usage:
      $FUNCNAME <CR> - abbreviation for 'oc project' + 'fzf namespace suggest'"
      echo
  else
      local ns=$(oc get ns | sed 1d | awk '{print $1}' | fzf -1 -q "$1" | awk '{print $1}')
      [ -n "${ns}" ] && echo "oc project ${ns} ############" && oc project "${ns}"
  fi
}

function ocg() {
  local keyword=$1
  if [[ "${keyword}" == "-h" || "${keyword}" == "--help" ]]; then
      echo "Usage:
      $FUNCNAME GREPWORD - abbreviation for 'oc project & oc get' + 'fzf namespace & api-resource'"
      echo
  else
      local ns=$(oc get ns | sed 1d | awk '{print $1}' | fzf -1 -q "$1" | awk '{print $1}')
      local api_resource=$(oc api-resources | sed 1d | awk '{print $1}' | fzf -1 -q "$1" | awk '{print $1}')
      [ -n "${api_resource}" ] && echo "oc project ${ns} && oc get ${api_resource} | grep ${keyword} ############" && oc project "${ns}" && oc get "${api_resource}" | grep "${keyword}"
  fi  
}

function ocgp() {
  if [[ "$1" == "-h" || "$1" == "--help" ]]; then
      echo "Usage: 
      $FUNCNAME <CR> - abbreviation for 'oc get pods' + 'fzf pods name suggest'
      # Support for --all-namespaces: $FUNCNAME all"
      echo
  elif [[ "$1" == "all" || "$1" == "--all-namespaces" ]]; then
      local project=$(oc project -q)
      [ -n "${project}" ] && echo "oc get pods --all-namespaces -o wide ##### ${project} #####" && oc get pods --all-namespaces -o wide
  else
      local project=$(oc project -q)      
      local pod=$(oc get pods | sed 1d | awk '{print $1}' | fzf -1 -q "$1" | awk '{print $1}')
      [ -n "${pod}" ] && echo "oc get pods ${pod} -o wide ##### ${project} #####" && oc get pods "${pod}" -o wide
  fi    
}

function ocga() {
  local keyword=$1
  if [[ "${keyword}" == "-h" || "${keyword}" == "--help" ]]; then  
      echo "Usage:
      $FUNCNAME GREPWORD - abbreviation for 'oc get all,secret,configmap -o wide | grep GREPWORD'"
      echo
  else
      local project=$(oc project -q)
      [ -n "${project}" ] && echo "oc get all,secret,configmap -o wide | grep ${keyword} ##### ${project} #####" && oc get all,secret,configmap -o wide | grep "${keyword}"
  fi  
}

function ocgans() {
  local keyword=$1
  if [[ "${keyword}" == "-h" || "${keyword}" == "--help" ]]; then  
      echo "Usage:
      $FUNCNAME GREPWORD - abbreviation for 'oc get all,secret,configmap -o wide --all-namespaces | grep GREPWORD'"
      echo
  else
      local project=$(oc project -q)
      [ -n "${project}" ] && echo "oc get all,secret,configmap -o wide --all-namespaces | grep ${keyword} ##### ${project} #####" && oc get all,secret,configmap -o wide --all-namespaces | grep "${keyword}"
  fi  
}

function ocrsh() {
  if [[ "$1" == "-h" || "$1" == "--help" ]]; then
      echo "Usage:
      $FUNCNAME <CR> - abbreviation for 'oc rsh' + 'fzf pods name' "
      echo
  else
      local project=$(oc project -q)      
      local pod=$(oc get pods | sed 1d | awk '{print $1}' | fzf -1 -q "$1" | awk '{print $1}')
      [ -n "${pod}" ] && echo "oc rsh ${pod} ##### ${project} #####" && oc rsh "${pod}"
  fi    
}

function oce() {
  if [[ "$1" == "-h" || "$1" == "--help" ]]; then
      echo "Usage:
      $FUNCNAME <CR> - abbreviation for 'oc exec -it \$pod \$cmd' + 'fzf pods name' "
      echo
  else
      local project=$(oc project -q)
      local pod=$(oc get pods | sed 1d | awk '{print $1}' | fzf -1 -q "$1" | awk '{print $1}')
      local read cmd
      [ -n "${pod}" ] && echo "oc exec -it ${pod} ${cmd} ##### ${project} #####" && oc exec -it "${pod}" "${cmd}"
  fi    
}

function ocl() {
  if [[ "$1" == "-h" || "$1" == "--help" ]]; then
      echo "Usage:
      $FUNCNAME <CR> - abbreviation for 'oc logs -f' + 'fzf pods name' "
      echo
  else
      local project=$(oc project -q)      
      local pod=$(oc get pods | sed 1d | awk '{print $1}' | fzf -1 -q "$1" | awk '{print $1}')
      [ -n "${pod}" ] && echo "oc logs -f ${pod} ##### ${project} #####" && oc logs -f "${pod}"
  fi    
}

function op() {
  if [[ "$1" == "-h" || "$1" == "--help" ]]; then
      echo "Usage:
      $FUNCNAME <CR> - abbreviation for 'oc project -q' "
      echo
  else
      local project=$(oc project -q)      
      echo "You are in namespace ##### ${project} #####"
  fi 
}

function ocdel() {
  if [[ "$1" == "-h" || "$1" == "--help" ]]; then
      echo "Usage:
      $FUNCNAME <CR> - abbreviation for 'oc delete pod $pod' + 'fzf pods name' "
      echo
  else
      local project=$(oc project -q)      
      local pod=$(oc get pods | sed 1d | awk '{print $1}' | fzf -1 -q "$1" | awk '{print $1}')
      [ -n "${pod}" ] && echo "oc delete pod ${pod} ##### ${project} #####" && oc delete pod "${pod}" "${@}"
  fi    
}

function ocge() {
  if [[ "$1" == "-h" || "$1" == "--help" ]]; then
      echo "Usage:
      $FUNCNAME <CR> - abbreviation for: oc get events --sort-by='.metadata.creationTimestamp'
      $FUNCNAME <CR> - V2: oc get events --field-selector involvedObject.name=${podName}
      REF: https://kubernetes.io/docs/concepts/overview/working-with-objects/field-selectors/
      "
      echo
  else
      local project=$(oc project -q)
      [ -n "${project}" ] && oc get events --sort-by='.metadata.creationTimestamp' 
  fi
}

function ocgev2() {
  if [[ "$1" == "-h" || "$1" == "--help" ]]; then
      echo "Usage:
      $FUNCNAME <CR> - abbreviation for: oc get events --sort-by='.metadata.creationTimestamp'
      $FUNCNAME <CR> - V2: oc get events --field-selector involvedObject.name=${podName}
      REF: https://kubernetes.io/docs/concepts/overview/working-with-objects/field-selectors/
      "
      echo
#  else
#      local project=$(oc project -q)
#      [ -n "${project}" ] && oc get events --sort-by='.metadata.creationTimestamp' 
#  fi
  else
      local project=$(oc project -q)
      local pod=$(oc get pods | sed 1d | awk '{print $1}' | fzf -1 -q "$1" | awk '{print $1}')
      [ -n "${project}" ] && oc get events --field-selector involvedObject.name="${pod}"
  fi
}
