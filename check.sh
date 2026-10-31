#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
ERRORS=0

echo "==> Running dotfiles validation checks..."

# 1. Validate Niri Configuration
if command -v niri >/dev/null 2>&1; then
    echo -n "Checking Niri configuration... "
    if niri validate -c "$REPO_DIR/niri/.config/niri/config.kdl" >/dev/null 2>&1; then
        echo "OK"
    else
        echo "FAILED"
        niri validate -c "$REPO_DIR/niri/.config/niri/config.kdl"
        ERRORS=$((ERRORS + 1))
    fi
fi

# 2. Validate Fuzzel Configuration
if command -v fuzzel >/dev/null 2>&1; then
    echo -n "Checking Fuzzel configuration... "
    if fuzzel --config "$REPO_DIR/fuzzel/.config/fuzzel/fuzzel.ini" --check-config >/dev/null 2>&1; then
        echo "OK"
    else
        echo "FAILED"
        fuzzel --config "$REPO_DIR/fuzzel/.config/fuzzel/fuzzel.ini" --check-config
        ERRORS=$((ERRORS + 1))
    fi
fi

# 3. Check syntax of all executable scripts and shell scripts
echo "Checking script syntax..."
while IFS= read -r script; do
    shebang=$(head -n 1 "$script" 2>/dev/null || true)
    rel_path="${script#$REPO_DIR/}"

    if [[ "$shebang" =~ python ]]; then
        if python3 -c 'import ast, sys; ast.parse(open(sys.argv[1]).read())' "$script" 2>/dev/null; then
            echo "  OK (python): $rel_path"
        else
            echo "  FAILED (python): $rel_path"
            python3 -c 'import ast, sys; ast.parse(open(sys.argv[1]).read())' "$script"
            ERRORS=$((ERRORS + 1))
        fi
    elif [[ "$shebang" =~ sh|bash ]] || [[ "$script" == *.sh ]]; then
        if bash -n "$script" 2>&1; then
            echo "  OK (sh/bash): $rel_path"
        else
            echo "  FAILED (sh/bash): $rel_path"
            ERRORS=$((ERRORS + 1))
        fi
    fi
done < <(find "$REPO_DIR" -type f \( -name "*.sh" -o -path "*/bin/*" \) -not -path "*/.git/*" | sort)

if [ "$ERRORS" -gt 0 ]; then
    echo "==> Validation FAILED with $ERRORS error(s)."
    exit 1
fi

echo "==> All validation checks passed successfully."
exit 0
