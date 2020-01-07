bash-script-template
====================

A *Bash* scripting template incorporating best practices & several useful functions.

Files
-----

| File            | Description                                                                                     |
| --------------- |------------------------------------------------------------------------------------------------ |
| **common.sh**   | Designed for sourcing into scripts; contains only those functions unlikely to need modification |
| **script.sh**   | Sample script which sources in `common.sh` and contains those functions likely to be modified   |
| **colors.sh**   | Contains all color codes separately due to length         										|

Usage
-----

Being a Bash script you're free to *slice-and-dice* the source as you see fit.

The following steps outline what's typically involved to help you get started:

1. Open`script.sh` for editing
2. Update the `script_usage()` function with additional usage guidance
3. Update the `parse_params()` function with additional script parameters
4. Add additional functions to implement the desired functionality
5. Update the `main()` function to call your added functions

### Adding a `hostname` parameter

The following contrived example demonstrates how to add a parameter to display the system's hostname.

Update the `script_usage()` function by inserting the following before the `EOF`:  

```plain
    --hostname                  Display the system's hostname
```

Update the `parse_params()` function by inserting the following before the default case statement (`*)`):  

```bash
--hostname)
    hostname=true
    ;;
```

Update the `main()` function by inserting the following after the existing initialisation statements:  

```bash
if [[ -n ${hostname-} ]]; then
    pretty_print "Hostname is: $(hostname)"
fi
```

Controversies
-------------

The Bash scripting community is an opinionated one. This is not a bad thing, but it does mean that some decisions made in this template aren't going to be agreed upon by everyone. A few of the most notable ones are highlighted here with an explanation of the rationale.

### errexit (*set -e*)

Conventional wisdom has for a long time held that at the top of every Bash script should be `set -e` (or the equivalent `set -o errexit`). This modifies the behaviour of Bash to exit immediately when it encounters a non-zero exit code from an executed command if it meets certain criteria. This would seem like an obviously useful behaviour in many cases, however, controversy arises both from the complexity of the grammar which determines if a command is eligible for this behaviour and the fact that there are many circumstances where a non-zero exit code is expected and should not result in termination of the script. An excellent overview of the argument against this option can be found in [BashFAQ/105](https://mywiki.wooledge.org/BashFAQ/105).

My personal view is that the benefits of `errexit` outweigh its disadvantages. More importantly, a script which is compatible with this option will work just as well if it is disabled, however, the inverse is not true. By being compatible with `errexit` those who find it useful can use this template without modification while those opposed can simply disable it without issue.

### nounset (*set -u*)

By enabling `set -u` (or the equivalent `set -o nounset`) the script will exit if an attempt is made to expand an unset variable. This can be useful both for detecting typos as well as potentially premature usage of variables which were expected to have been set earlier. The controvery here arises in that many Bash scripting coding idioms rely on referencing unset variables, which in the absence of this option are perfectly valid. Further discussion on this option can be found in [BashFAQ/112](https://mywiki.wooledge.org/BashFAQ/112).

This option is enabled for the same reasons as described above for `errexit`.

License
-------

All content is licensed under the terms of [The MIT License](LICENSE).
