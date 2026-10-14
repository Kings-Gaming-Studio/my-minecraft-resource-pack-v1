#!/usr/bin/env bash
# Builds the server resource pack zip from the source folders and prints its SHA-1.
# Minecraft servers need both: the zip URL and the SHA-1 go into server.properties.
set -euo pipefail

cd "$(dirname "$0")/.."
OUT="dist/KPG-ResourcePack.zip"

# Fail early on broken JSON, since one bad model file shows as a missing texture in game.
python3 - <<'PY'
import json, pathlib, sys
bad = []
for p in pathlib.Path(".").glob("assets/**/*.json"):
    try:
        json.loads(p.read_text(encoding="utf-8"))
    except Exception as e:
        bad.append(f"{p}: {e}")
for p in ["pack.mcmeta"]:
    json.loads(pathlib.Path(p).read_text(encoding="utf-8"))
if bad:
    print("\n".join(bad)); sys.exit(1)
PY

mkdir -p dist
rm -f "$OUT"
# Pin every file's date and sort the file list so an unchanged pack always gives
# the same SHA-1. Players then only re-download when something really changed.
find pack.mcmeta pack.png assets -exec touch -d '2020-01-01T00:00:00Z' {} +
find pack.mcmeta pack.png assets -type f | LC_ALL=C sort | zip -qX "$OUT" -@

SHA1=$(sha1sum "$OUT" | cut -d' ' -f1)
echo "$SHA1" > dist/KPG-ResourcePack.sha1
echo "Built $OUT ($(du -h "$OUT" | cut -f1))"
echo "sha1: $SHA1"
