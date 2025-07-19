SRC_DIR="$(pwd)"
DEST_DIR="$HOME"

skip_dist=(
    ".git"
    ".gitignore"
    ".DS_Store"
    "link.sh"
    "README.md"
    "LICENSE"
)

link_files_recursively() {
    local src="$1"
    local dest="$2"

    mkdir -p "$dest"

    for item in "$src"/*; do
        [ -e "$item" ] || continue  # 防止空目录

        local name=$(basename "$item")
        local target="$dest/$name"

        if [ -f "$item" ]; then
            if [ -e "$target" ] || [ -L "$target" ]; then
                echo "Removing existing: $target"
                rm -rf "$target"
            fi
            ln -s "$item" "$target"
            echo "Linked: $item → $target"
        elif [ -d "$item" ]; then
            link_files_recursively "$item" "$target"
        fi
    done
}

for item in "$SRC_DIR"/*; do
    name=$(basename "$item")

    if [[ " ${skip_dist[@]} " =~ " $name " ]]; then
        echo "Skipping: $name"
        continue
    fi

    target="$DEST_DIR/.$name"
    if [ -f "$item" ]; then
        if [ -e "$target" ] || [ -L "$target" ]; then
            echo "Removing existing: $target"
            rm -rf "$target"
        fi
        ln -s "$item" "$target"
        echo "Linked: $item → $target"
    elif [ -d "$item" ]; then
        link_files_recursively "$item" "$target"
    fi
done
