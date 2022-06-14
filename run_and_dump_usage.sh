#!/bin/bash

# extract job_id
job_id="$1"; shift

# write labels yaml
echo "job-name: ${job_id}" > /tmp/pod_labels.yml

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
calrissian --pod-labels /tmp/pod_labels.yml "$@"
STATUS=$?

# dump docker usage stats
if [ ! -z "${usage_report}" ]; then
  echo "# BEGIN docker-usage.json"
  cat ${usage_report}
  echo ""
  echo "# END docker-usage.json"
fi

# propagate exit status of calrissian
exit $STATUS
