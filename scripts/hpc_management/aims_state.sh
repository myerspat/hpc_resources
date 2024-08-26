#!/bin/bash
# Place this file in 

usage() {
  printf "AIMS multi-threaded state\n"
  printf " OPTIONS\n"
  printf " -s\tstate of aims (optional)\n"
  printf " -n\tnumber of threads (optional)\n"
  printf " -h\tprint this help\n"
}

while getopts ":n:s:h:" opt; do
  case $opt in
    n) 
      num_threads="$OPTARG"
      ;;
    s)
      state="$OPTARG"
      ;;
    h)
      usage
      ;;
    *)
      usage
      ;;
  esac
done

# Set threads for given state
if [ "$state" == "debug" ]
then 
  num_threads=4
elif [ "$state" == "standard" ]
then
  num_threads=8
fi

[ -z "$num_threads" ] && usage

# Limit CPU usage
export OMP_NUM_THREADS=$num_threads
export OPENBLAS_NUM_THREADS=$num_threads
export MKL_NUM_THREADS=$num_threads
export VECLIB_MAXIMUM_THREADS=$num_threads
export NUMEXPR_NUM_THREADS=$num_threads
