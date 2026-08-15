#!/usr/bin/env bash
set -euo pipefail

TARGET_URL="http://localhost/api/doc"
MAX_RETRIES=15
RETRY_INTERVAL=3

echo "Validating application health at ${TARGET_URL}..."

for ((i=1; i<=MAX_RETRIES; i++)); do
    if HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "${TARGET_URL}"); then
        :
    else
        HTTP_STATUS="000"
    fi

    if [ "${HTTP_STATUS}" = "200" ]; then
        echo "Validation SUCCESS: Received HTTP ${HTTP_STATUS} from ${TARGET_URL} on attempt ${i}/${MAX_RETRIES}."
        exit 0
    fi

    echo "Attempt ${i}/${MAX_RETRIES}: Received HTTP ${HTTP_STATUS}. Waiting ${RETRY_INTERVAL}s..."
    sleep "${RETRY_INTERVAL}"
done

echo "ERROR: Validation FAILED after ${MAX_RETRIES} attempts. Endpoint ${TARGET_URL} did not return HTTP 200." >&2
exit 1