#!/bin/sh

export LOG_FAIL_PATH="log/Test-*.xml"

for LOG_FILE_NAME in `ls $LOG_FAIL_PATH`
do
  export FAILURE_MESSAGE=`xpath -e '//testsuite/testcase/failure/text()' LOG_FILE_NAME | sed ":a;N;s/\n//g;ta"`
  if [ ! -z "$FAILURE_MESSAGE" ]; then 
  do
    cat $LOG_FILE_NAME
    cat $FAILURE_MESSAGE
    export FAILURE_MESSAGE_FILE=`xpath -e '//testsuite/testcase/@classname' LOG_FILE_NAME
    cat $FAILURE_MESSAGE_FILE
  done
  else 
    echo "nothing in $LOG_FILE_NAME"
  fi

  export ERROR_MESSAGE=`xpath -e '//testsuite/testcase/system-out/text()' log/TEST-*.xml | grep "Annotation Error Message"`
  if [ ! -z "$ERROR_MESSAGE" ]; then 
  do
    cat $LOG_FILE_NAME
    cat $ERROR_MESSAGE
    export ERROR_MESSAGE_FILE=`xpath -e '//testsuite/testcase/@classname' LOG_FILE_NAME
    cat $ERROR_MESSAGE_FILE
  done
  else 
    echo "nothing in $LOG_FILE_NAME"
  fi
  
  export WARNING_MESSAGE=`xpath -e '//testsuite/testcase/system-out/text()' log/TEST-*.xml | grep "Annotation Warning Message"`
  if [ ! -z "$WARNING_MESSAGE" ]; then 
  do
    cat $LOG_FILE_NAME
    cat $WARNING_MESSAGE
    export WARNING_MESSAGE_FILE=`xpath -e '//testsuite/testcase/@classname' LOG_FILE_NAME
    cat $WARNING_MESSAGE_FILE
  done
  else 
    echo "nothing in $LOG_FILE_NAME"
  fi
done
