if [[ $USER == dlindenb ]]; then
  export PATH=/afs/cs.cmu.edu/academic/class/15410-f15/bin:$PATH
  aklog cs.cmu.edu
  alias simics='env SIMICS_TEXT_CONSOLE="yes" simics46'
else
  DISPLAY=localhost:0.0 ; export DISPLAY
fi
