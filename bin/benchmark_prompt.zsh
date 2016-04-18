cumul=0; for i ({0..99}) {
  start=$(date +%s.%N)
  end=$(date +%s.%N)
  (( cumul+= (end-start) ))
}
overhead=$((cumul/100.))
cumul=0; for i ({0..99}) {
  start=$(date +%s.%N)
  print -P $PS1 $RPS1
  end=$(date +%s.%N)
  (( cumul+= (end-start) ))
}
print $((cumul/100. - overhead))
