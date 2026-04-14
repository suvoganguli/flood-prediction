#!/usr/bin/env bash
set -euo pipefail

# ------------------------------------------------------------
# Download NOAA Storm Events "details" CSV files for selected years
# and keep only the files relevant for flood-target exploration.
# ------------------------------------------------------------

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
OUT_DIR="${PROJECT_ROOT}/data/raw/flood_events"

mkdir -p "${OUT_DIR}"

BASE_URL="https://www.ncei.noaa.gov/pub/data/swdi/stormevents/csvfiles"
INDEX_URL="${BASE_URL}/"

# Choose a practical starting range for Houston target design.
START_YEAR=2017
END_YEAR=2025

echo "Downloading NOAA Storm Events files into:"
echo "  ${OUT_DIR}"
echo

TMP_INDEX="${OUT_DIR}/stormevents_index.html"

curl -L "${INDEX_URL}" -o "${TMP_INDEX}"

for YEAR in $(seq "${START_YEAR}" "${END_YEAR}"); do
    FILE_NAME=$(
        grep -o "StormEvents_details-ftp_v1\.0_d${YEAR}_c[0-9]\{8\}\.csv\.gz" "${TMP_INDEX}" \
        | head -n 1 || true
    )

    if [[ -z "${FILE_NAME}" ]]; then
        echo "Could not find details file for year ${YEAR}"
        continue
    fi

    echo "Downloading ${FILE_NAME} ..."
    curl -L "${BASE_URL}/${FILE_NAME}" -o "${OUT_DIR}/${FILE_NAME}"
done

rm -f "${TMP_INDEX}"

echo
echo "Done."
echo "Downloaded files:"
ls -lh "${OUT_DIR}"/*.csv.gz
