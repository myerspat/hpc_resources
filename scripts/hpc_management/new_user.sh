#!/bin/sh
# Taken from https://www.baeldung.com/linux/automate-user-account-creation

usage() {
  printf "create-user [-u|--username] <username>\n"
  printf " OPTIONS\n"
  printf " -u --username\tusername of the new account (required)\n"
  printf " -p --password\tpassword for the new account (optional)\n"
  printf " -h --help\tprint this help\n"
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    -u|--username) username="$2" shift ;;
    -p|--password) password="$2" shift ;;
        -h|--help) usage ;;
                *) usage ;;
  esac
  shift
done

[ -z "$username" ] && usage
[ -z "$password" ] && password=$(uuidgen | cut -d'-' -f1)

# Run commands
# Add user with /bin/bash shell
useradd -m -s /bin/bash -p $(echo "$password" | openssl passwd -1 -stdin) $username > /dev/null 2>&1

# Require password change when first connecting
passwd --expire $username > /dev/null

# Append to user profile with alias and thread limits
num_threads=8
echo "
# Aliases
alias ~='cd ~'
alias .='cd ../'
alias ..='cd ../../'
alias ...='cd ../../../'

alias ll='ls -alF'
alias la='ls -a'
alias l='ls -CF'

# Limit CPU usage
export MKL_NUM_THREADS=$num_threads
export NUMEXPR_NUM_THREADS=$num_threads
export OMP_NUM_THREADS=$num_threads
export OPENBLAS_NUM_THREADS=$num_threads
export VECLIB_MAXIMUM_THREADS=$num_threads" >> /home/${username}/.profile

#------------#
# VARIATIONS #
#------------#
# useradd -m "$username"
# echo -n "$password\n$password\n" | passwd $username"
# echo "${username}:${password}" | chpasswd

if [ "$?" -eq 0 ]; then
  echo "Username: $username"
  echo "Password: $password"
else
  echo "Failed to set up user account"
  userdel -f "$username"
fi
