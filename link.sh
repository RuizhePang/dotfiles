SRC_DIR="$(pwd)"
DEST_DIR="$HOME"

for item in "$SRC_DIR"/*; do
    name=$(basename "$item")
    target="$DEST_DIR/.$name"

    if [ -e "$target" ] || [ -L "$target" ]; then
        echo "Removing existing: $target"
        rm -rf "$target"
    fi

    ln -s "$item" "$target"
    echo "Linked: $item → $target"
done
