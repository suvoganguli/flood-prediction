i#!/usr/bin/env bash
set -euo pipefail

# ------------------------------------------------------------
# Download historical daily rainfall from Open-Meteo
# for a small grid of sample points across the Houston bbox.
#
# Output:
#   data/raw/rainfall/rain_<id>.csv
# ------------------------------------------------------------

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
OUT_DIR="${PROJECT_ROOT}/data/raw/rainfall"

mkdir -p "${OUT_DIR}"

# ------------------------------------------------------------
# Study period
# ------------------------------------------------------------
START_DATE="2017-01-01"
END_DATE="2025-12-31"

# ------------------------------------------------------------
# Houston bbox from config.py
# lon_min = -95.80
# lat_min =  29.40
# lon_max = -95.00
# lat_max =  30.20
#
# Start simple: a 3 x 3 set of points across the bbox
# ------------------------------------------------------------
POINTS=(
  "h01,29.50,-95.70"
  "h02,29.50,-95.40"
  "h03,29.50,-95.10"
  "h04,29.80,-95.70"
  "h05,29.80,-95.40"
  "h06,29.80,-95.10"
  "h07,30.10,-95.70"
  "h08,30.10,-95.40"
  "h09,30.10,-95.10"
)

BASE_URL="https://archive-api.open-meteo.com/v1/archive"

echo "Downloading daily rainfall CSV files into:"
echo "  ${OUT_DIR}"
echo

for P in "${POINTS[@]}"; do
  IFS=',' read -r ID LAT LON <<< "${P}"

  OUT_FILE="${OUT_DIR}/rain_${ID}.csv"

  echo "Downloading ${ID}  lat=${LAT} lon=${LON}"

  curl -L --get "${BASE_URL}" \
    --data-urlencode "latitude=${LAT}" \
    --data-urlencode "longitude=${LON}" \
    --data-urlencode "start_date=${START_DATE}" \
    --data-urlencode "end_date=${END_DATE}" \
    --data-urlencode "daily=precipitation_sum" \
    --data-urlencode "timezone=America/Chicago" \
    --data-urlencode "temperature_unit=celsius" \
    --data-urlencode "wind_speed_unit=kmh" \
    --data-urlencode "precipitation_unit=mm" \
    --data-urlencode "model=era5" \
    --data-urlencode "format=csv" \
    -o "${OUT_FILE}"

  sleep 1
done

echo
echo "Done. Files saved in ${OUT_DIR}:"
ls -lh "${OUT_DIR}"/rain_*.csv
