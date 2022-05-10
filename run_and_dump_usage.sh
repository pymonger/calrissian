#!/bin/bash

# extract usage report output filename if set
usage_report=""
for (( i=1; i <= "$#"; i++ )); do
    if [ "${!i}" = "--usage-report" ]; then
      ((i++))
      usage_report=${!i}
      break
    fi
done

# run calrissian and capture exit status
calrissian $*
STATUS=$?

# dump docker usage stats
if [ ! -z "${usage_report}" ]; then
  echo "# BEGIN docker-usage.json"
  cat ${usage_report}
  echo "# END docker-usage.json"
fi

# propagate exit status of calrissian
exit $STATUS
