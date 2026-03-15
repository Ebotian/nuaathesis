#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Usage: ./batch_pandoc_convert.sh SRC_DIR [OUTDIR]
# Fast conversion using pandoc: Markdown -> DOCX (good for text + images)

SRC_DIR="${1:-.}"
OUTDIR="${2:-docx_output}"

if [ ! -d "$SRC_DIR" ]; then
  echo "Source directory not found: $SRC_DIR" >&2
  exit 1
fi

mkdir -p "$OUTDIR"

echo "Converting Markdown files from $SRC_DIR to DOCX (pandoc) -> $OUTDIR"

# Find markdown files recursively, skip common build/vendor dirs
while IFS= read -r -d '' md; do
  case "$md" in
    */.git/*|*/node_modules/*|*/dist/*|*/release/*) continue ;;
  esac

  # create a safe output name based on path relative to SRC_DIR
  relpath="${md#$SRC_DIR/}"
  safe_name="$(echo "$relpath" | sed 's#[/ ]#_##g')"
  out="$OUTDIR/${safe_name%.md}.docx"

  echo "- $md -> $out"
  pandoc --from=gfm+yaml_metadata_block+footnotes --standalone --toc \
    --resource-path="$SRC_DIR" --extract-media="$OUTDIR/media" \
    -o "$out" "$md"
done < <(find "$SRC_DIR" -type f -name '*.md' -print0)

echo "Done. DOCX files are in: $OUTDIR"
