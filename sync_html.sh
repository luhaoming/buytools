#!/usr/bin/env bash

MD=1.md
IGNORE=.html.ignore

mapfile -t SECTIONS < <(grep '^## ' "$MD" | sed 's/^## //')

html_list=$(ls *.html 2>/dev/null)

in_ignore() {
  [[ -f "$IGNORE" ]] && grep -qx "$1" "$IGNORE"
}

for f in $html_list; do
  in_ignore "$f" && continue
  grep -q "(./$f)" "$MD" && continue

  echo "發現新 html：$f"
  echo "可用段落："
  i=1
  for s in "${SECTIONS[@]}"; do
    echo " $i) $s"
    ((i++))
  done
  echo

  read -p "加到哪個段落 1,2,3... (x=跳過, xx=忽略, 預設 others): " idx

  case "$idx" in
    x)
      echo "跳過 $f"
      echo
      continue
      ;;
    xx)
      echo "$f" >> "$IGNORE"
      echo "已加入 ignore：$f"
      echo
      continue
      ;;
  esac

  read -p "小工具名稱($f) : " name
  tool_name=${name:-${f%.html}}

  [[ -z "$idx" ]] && section="others"
  [[ -n "$idx" ]] && section="${SECTIONS[$((idx-1))]}"

  awk -v sec="$section" -v line="* [$tool_name](./$f)" '
    $0 == "## "sec {print; print line; next}
    {print}
  ' "$MD" > "$MD.tmp" && mv "$MD.tmp" "$MD"

  echo "已加入 ## $section"
  echo
done
