#!/usr/bin/env bash

# A best practices Bash script template with many useful functions. This file
# sources in the bulk of the functions from the common.sh file which it expects
# to be in the same directory. Only functions which are likely to need modification
# are present in this file. By pulling in the common functions you'll minimise
# code duplication, as well as ease any potential updates to shared functions.

# A better class of script...
set -o errexit          # Exit on most errors (see the manual)
set -o errtrace         # Make sure any error trap is inherited
set -o nounset          # Disallow expansion of unset variables
set -o pipefail         # Use last non-zero exit code in a pipeline

# Print help if no arguments were passed
# Uncomment to force arguments when invoking the script
[[ $# -eq 0 ]] && set -- "--help"

# DESC: Usage help
# ARGS: None
# OUTS: None
function script_usage() {
    cat << EOF
Usage:
     -h|--help                  Displays this help
     -u|--username              Sets string following arg as \${username}
     -p|--password              Prompts for password to pass
     -v|--verbose               Displays verbose output
     -d|--debug                 Sets \${debug}=true
EOF
}

# DESC: Parameter parser
# ARGS: $@ (optional): Arguments provided to the script
# OUTS: Variables indicating command-line parameters and options
function parse_params() {
    local param
    while [[ $# -gt 0 ]]; do
        param="$1"
        shift
        case $param in
            -h|--help)
                script_usage
                exit 0
                ;;
            -u|--username)
                shift
                username=${1}
                ;;
            -p|--password)
# Find the best risk-averse method to pass password
                ;;
            -v|--verbose)
                verbose=true
                ;;
            -d|--debug)
                set -o xtrace
                ;;
            *)
                script_exit "Invalid parameter was provided: $param" 1
                ;;
        esac
    done
}

# DESC: Main control flow
# ARGS: $@ (optional): Arguments provided to the script
# OUTS: None
function main() {
    source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

    trap script_trap_err ERR
    trap script_trap_exit EXIT

    script_init "$@"
    parse_params "$@"
    #lock_init system
}

# Execute main passing all args
main "$@"