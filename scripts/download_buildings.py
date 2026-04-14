from pathlib import Path
import sys

PROJECT_ROOT = Path(__file__).resolve().parent.parent
if str(PROJECT_ROOT) not in sys.path:
    sys.path.append(str(PROJECT_ROOT))

from config import BBOX, BUILDINGS_RAW_DIR, CRS_GEO

import osmnx as ox
from shapely.geometry import box

out_file = BUILDINGS_RAW_DIR / "houston_buildings.geojson"

polygon = box(
    BBOX["lon_min"],
    BBOX["lat_min"],
    BBOX["lon_max"],
    BBOX["lat_max"],
)

print("Downloading OSM building footprints...")

buildings = ox.features_from_polygon(
    polygon,
    tags={"building": True}
)

if buildings.empty:
    raise ValueError("No building footprints returned.")

buildings = buildings.to_crs(CRS_GEO)

# Keep only polygons
buildings = buildings[
    buildings.geometry.type.isin(["Polygon", "MultiPolygon"])
].copy()

buildings.to_file(out_file, driver="GeoJSON")

print(f"Saved buildings to: {out_file}")
print(f"Number of building features: {len(buildings)}")
