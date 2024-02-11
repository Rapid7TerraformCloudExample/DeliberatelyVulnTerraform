#!/bin/bash
echo "Mimics tool is being downloaded"

curl -o mimics https://artifacts.rapid7.com/cloudsec/mimics/latest/mimics_latest_linux_amd64
chmod +x mimics

echo "Mimics tool is scanning configuration"

./mimics scan ./ \
--api-key "<API_KEY>" \
--base-url "<BASE_URL>" \
--no-verify \
--log-format json \
--report-formats all \
--report-name ics_findings \
--ics-config "AWS CIS Benchmark 1.4" \
--no-fail \
--verbose
