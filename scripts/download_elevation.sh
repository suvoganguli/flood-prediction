#!/usr/bin/env bash
set -euo pipefail

# ------------------------------------------------------------
# Download USGS 3DEP 1/3 arc-second DEM tiles for the Houston bbox
#
# Houston bbox in config.py:
#   lon_min = -95.80
#   lat_min =  29.40
#   lon_max = -95.00
#   lat_max =  30.20
#
# This bbox spans 4 one-degree tiles:
#   n29w096, n29w095, n30w096, n30w095
#
# Output:
#   data/raw/elevation/*.tif
# ------------------------------------------------------------

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
OUT_DIR="${PROJECT_ROOT}/data/raw/elevation"

mkdir -p "${OUT_DIR}"

BASE_URL="https://prd-tnm.s3.amazonaws.com/StagedProducts/Elevation/13/TIFF/current"

TILES=(
  "n29w096"
  "n30w096"
)

echo "Downloading USGS 3DEP 1/3 arc-second DEM tiles..."
echo "Output directory: ${OUT_DIR}"
echo

for TILE in "${TILES[@]}"; do
  FILE_NAME="USGS_13_${TILE}.tif"
  URL="${BASE_URL}/${TILE}/${FILE_NAME}"
  OUT_FILE="${OUT_DIR}/${FILE_NAME}"

  echo "Downloading ${FILE_NAME}"
  curl -L --fail "${URL}" -o "${OUT_FILE}"
done

echo
echo "Done. Downloaded files:"
ls -lh "${OUT_DIR}"/USGS_13_*.tif
