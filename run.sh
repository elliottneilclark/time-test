#!/bin/bash

set -e
set -x

JAVA_ARGS="-server -XX:+UseG1GC -XX:MaxGCPauseMillis=50"
FT="csv"
OFILE="result.${FT}"

rm -f hs_* || true

[[ -f "$OFILE" ]] &&  rm ${OFILE}
mvn clean package
clear
${JAVA_HOME}/bin/java ${JAVA_ARGS} -jar target/benchmarks.jar \
  -bm sample -tu ns \
  -wf 1 -f 5 \
  -t max -foe true -gc true \
  -rf ${FT} -rff ${OFILE} "$@"

