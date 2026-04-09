#!/usr/bin/env bash

sudo chown -R 1000:1000 "$HOME" &>/dev/null

# Reinstall Claude if binary isn't present (i.e. if $HOME is a new volume)
if [[ ! -e $HOME/.local/bin/claude ]]
then
    cp -r /opt/claude/* "$HOME"/.local/
    if "$HOME"/.local/bin/claude --version &>/dev/null
    then
      echo "Claude Code executable installed successfully"
    else
      echo "Claude Code executable not installed successfully"
    fi
fi

[[ -e "$HOME/.claude.json" ]] || cp "/opt/claude/.claude.json" "$HOME/.claude.json"

HTTP_AUTH_USERNAME="${HTTP_AUTH_USERNAME:-admin}"
HTTP_AUTH_PASSWORD="${HTTP_AUTH_PASSWORD:-}"

mkdir -p "$HOME/.nginx/tmp"

# If $HTTP_AUTH_PASSWORD is not set, basic auth is unused
if [[ -n "$HTTP_AUTH_USERNAME" && -n "$HTTP_AUTH_PASSWORD" ]]; then
  echo "Basic auth enabled for user: $HTTP_AUTH_USERNAME"
  HTPASSWD_FILE="$HOME/.nginx/.htpasswd"
  htpasswd -cb "$HTPASSWD_FILE" "$HTTP_AUTH_USERNAME" "$HTTP_AUTH_PASSWORD"
  cat > "$HOME/.nginx/auth.conf" <<EOF
auth_basic "Restricted";
auth_basic_user_file $HTPASSWD_FILE;
EOF
else
  # Empty auth.conf — no authentication required
  > "$HOME/.nginx/auth.conf"
fi

# Start nginx in the background
nginx -c /opt/nginx/nginx.conf -g "daemon off;" &

# Run /nix.sh from docker.io/heywoodlh/nix
/nix.sh true

# Start claude-code-webui on the internal port (localhost only)
/usr/local/bin/claude-code-webui --host 127.0.0.1 --port 3000 "$@"
