export EDITOR='subl'
export ANT_HOME='/home/David/bin/apache-ant-1.9.6'
export PATH=$ANT_HOME/bin:$PATH

if [[ $(uname -o) == "Cygwin" ]]
then
  export JAVA_HOME='/cygdrive/c/Program Files/Java/jdk1.8.0_77'
fi
