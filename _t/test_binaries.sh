#!/bin/bash

#dist/github.com/callebjorkell/jira-darwin-amd64      dist/github.com/callebjorkell/jira-linux-amd64       dist/github.com/callebjorkell/jira-windows-amd64.exe
#dist/github.com/callebjorkell/jira-linux-386         dist/github.com/callebjorkell/jira-windows-386.exe

EXIT_CODE=0

function error() {
  echo $1
  EXIT_CODE=1
}

DIST_DIR="dist/github.com/go-jira"

out=`file ${DIST_DIR}/jira-darwin-amd64 2>&1`
if ! [[ "$out" =~ "Mach-O 64-bit" ]]; then
   error "darwin/amd64 build not as expected: $out"
fi

out=`file ${DIST_DIR}/jira-linux-amd64 2>&1`
if ! [[ "$out" =~ "ELF 64-bit LSB executable, x86-64" ]]; then
   error "linux/amd64 build not as expected: $out"
fi

out=`file ${DIST_DIR}/jira-linux-386 2>&1`
if ! [[ "$out" =~ "ELF 32-bit LSB executable, Intel 80386" ]]; then
   error "linux/i386 build not as expected: $out"
fi

out=`file ${DIST_DIR}/jira-windows-amd64.exe 2>&1`
if ! [[ "$out" =~ "PE32+ executable (console) x86-64" ]]; then
   error "windows/amd64 build not as expected: $out"
fi

out=`file ${DIST_DIR}/jira-windows-386.exe 2>&1`
if ! [[ "$out" =~ "PE32 executable (console) Intel 80386" ]]; then
   error "windows/i386 build not as expected: $out"
fi

exit $EXIT_CODE
