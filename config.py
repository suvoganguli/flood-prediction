from pathlib import Path

# ============================================================
# PROJECT ROOT AND DIRECTORIES
# ============================================================

ROOT = Path(__file__).resolve().parent

DATA_DIR = ROOT / "data"
RAW_DIR = DATA_DIR / "raw"
INTERIM_DIR = DATA_DIR / "interim"
PROCESSED_DIR = DATA_DIR / "processed"

OUTPUTS_DIR = ROOT / "outputs"
FIGURES_DIR = OUTPUTS_DIR / "figures"
TABLES_DIR = OUTPUTS_DIR / "tables"
DIAGNOSTICS_DIR = OUTPUTS_DIR / "diagnostics"

NOTEBOOKS_DIR = ROOT / "notebooks"
DOCS_DIR = ROOT / "docs"

for p in [
    DATA_DIR,
    RAW_DIR,
    INTERIM_DIR,
    PROCESSED_DIR,
    OUTPUTS_DIR,
    FIGURES_DIR,
    TABLES_DIR,
    DIAGNOSTICS_DIR,
    NOTEBOOKS_DIR,
    DOCS_DIR,
]:
    p.mkdir(parents=True, exist_ok=True)

# ============================================================
# PROJECT SETTINGS
# ============================================================

PROJECT_NAME = "flood-prediction"
CITY_NAME = "Houston"

BBOX = {
    "lon_min": -95.80,
    "lat_min": 29.40,
    "lon_max": -95.00,
    "lat_max": 30.20,
}

CRS_GEO = "EPSG:4326"
CRS_PROJECTED = "EPSG:3857"

GRID_SIZE_METERS = 5000
FIG_DPI = 300

SAVE_FIGURES = True
SAVE_INTERMEDIATE = True

# ============================================================
# RAW DATA FOLDERS
# ============================================================

FLOOD_EVENTS_RAW_DIR = RAW_DIR / "flood_events"
RAINFALL_RAW_DIR = RAW_DIR / "rainfall"
ELEVATION_RAW_DIR = RAW_DIR / "elevation"
ROADS_RAW_DIR = RAW_DIR / "roads"
BUILDINGS_RAW_DIR = RAW_DIR / "buildings"
POPULATION_RAW_DIR = RAW_DIR / "population"

for p in [
    FLOOD_EVENTS_RAW_DIR,
    RAINFALL_RAW_DIR,
    ELEVATION_RAW_DIR,
    ROADS_RAW_DIR,
    BUILDINGS_RAW_DIR,
    POPULATION_RAW_DIR,
]:
    p.mkdir(parents=True, exist_ok=True)

# ============================================================
# INTERMEDIATE / PROCESSED FILES
# ============================================================

GRID_FILE = INTERIM_DIR / "grids" / "houston_grid_1km.parquet"
LABEL_CANDIDATES_FILE = INTERIM_DIR / "labels" / "label_candidates.parquet"
LABEL_DAILY_FILE = INTERIM_DIR / "labels" / "daily_grid_labels.parquet"

STATIC_FEATURES_FILE = INTERIM_DIR / "features" / "static_features.parquet"
RAINFALL_FEATURES_FILE = INTERIM_DIR / "features" / "rainfall_features.parquet"

MODELING_TABLE_FILE = PROCESSED_DIR / "modeling" / "modeling_table.parquet"
FINAL_LABEL_FILE = PROCESSED_DIR / "final" / "final_labels.parquet"

# ============================================================
# FIGURE FILES
# ============================================================

FIG_GRID = FIGURES_DIR / "01_houston_grid.png"
FIG_LABEL_OVERVIEW = FIGURES_DIR / "02_label_overview.png"
FIG_EVENT_MAP = FIGURES_DIR / "03_event_map.png"

# ============================================================
# HELPER FUNCTIONS
# ============================================================

def ensure_parent_dir(path: Path) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)


def save_figure(fig, path, dpi=None):
    if dpi is None:
        dpi = FIG_DPI

    ensure_parent_dir(path)
    fig.savefig(path, dpi=dpi, bbox_inches="tight")
    print(f"Saved figure to: {path}")


def save_parquet(df, path, index=False):
    ensure_parent_dir(path)
    df.to_parquet(path, index=index)
    print(f"Saved parquet to: {path}")


def print_config_summary():
    print("Project:", PROJECT_NAME)
    print("City:", CITY_NAME)
    print("BBOX:", BBOX)
    print("CRS_GEO:", CRS_GEO)
    print("CRS_PROJECTED:", CRS_PROJECTED)
    print("Grid size (m):", GRID_SIZE_METERS)
    print("Grid file:", GRID_FILE)
