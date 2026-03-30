import { useState, useEffect } from "react";

// ── NAMES ── swap this array with your real guest list ──
const NAMES = [
  "Trey","Anika","Brandon","Camila","Derek","Elena","Farid","Grace",
  "Hassan","Iris","Jalen","Keiko","Liam","Maya","Nico","Olivia",
  "Priya","Quinn","Rashid","Sofia","Tomas","Uma","Victor","Wendy",
  "Xander","Yara","Zach","Amara","Blake","Chloe","Dante","Evelyn",
  "Felix","Gina","Hugo","Imani","Joss","Kira","Leo","Mila",
  "Nate","Opal","Pax","Ren","Sky","Tai","Val","Wren",
  "Ash","Bea","Cal","Dex","Elm","Fay","Gil","Hana",
  "Ira","Joy","Kit","Luna","Max","Noor","Oz","Pip",
  "Rio","Sam","Tia","Uri"
];

const ACCENT_COLORS = [
  "#FF6B6B","#4ECDC4","#FFE66D","#A78BFA","#F97316",
  "#06D6A0","#FF477E","#00B4D8","#E9FF70","#C084FC"
];

function generateBashScript(name) {
  return [
    '# TERMINAL PARTY for ' + name,
    '# Paste this entire block into your terminal and hit Enter.',
    '# Works on macOS (zsh or bash), iTerm2, any Linux terminal.',
    '# Make it FULLSCREEN for the best experience!',
    '# Ctrl+C to exit anytime.',
    'bash << \'PARTY\'',
    'NAME="' + name + '"',
    'UPPER=$(echo "$NAME" | tr \'[:lower:]\' \'[:upper:]\')',
    '',
    'trap \'tput cnorm; tput sgr0; clear; exit\' INT TERM EXIT',
    'tput civis; clear',
    'COLS=$(tput cols); LNS=$(tput lines)',
    'MX=$((COLS/2)); MY=$((LNS/2))',
    '',
    '# colors (printf %b compatible)',
    'R=\'\\033[91m\'; G=\'\\033[92m\'; Y=\'\\033[93m\'; B=\'\\033[94m\'',
    'M=\'\\033[95m\'; C=\'\\033[96m\'; W=\'\\033[97m\'',
    'dG=\'\\033[32m\'; dC=\'\\033[36m\'',
    'BD=\'\\033[1m\'; DM=\'\\033[2m\'; RS=\'\\033[0m\'',
    'CL=("$R" "$G" "$Y" "$B" "$M" "$C" "$W")',
    '',
    'cur(){ printf "\\033[%d;%dH" "$1" "$2"; }',
    'out(){ printf "%b" "$@"; }',
    '',
    '# block letter font (5 rows, | separated)',
    'font_data() {',
    '  case "$1" in',
    '    A) echo " ### |#   #|#####|#   #|#   #";;',
    '    B) echo "#### |#   #|#### |#   #|#### ";;',
    '    C) echo " ####|#    |#    |#    | ####";;',
    '    D) echo "#### |#   #|#   #|#   #|#### ";;',
    '    E) echo "#####|#    |###  |#    |#####";;',
    '    F) echo "#####|#    |###  |#    |#    ";;',
    '    G) echo " ####|#    |# ###|#   #| ####";;',
    '    H) echo "#   #|#   #|#####|#   #|#   #";;',
    '    I) echo "###| # | # | # |###";;',
    '    J) echo " ####|    #|    #|#   #| ### ";;',
    '    K) echo "#  # |# #  |##   |# #  |#  # ";;',
    '    L) echo "#    |#    |#    |#    |#####";;',
    '    M) echo "#   #|## ##|# # #|#   #|#   #";;',
    '    N) echo "#   #|##  #|# # #|#  ##|#   #";;',
    '    O) echo " ### |#   #|#   #|#   #| ### ";;',
    '    P) echo "#### |#   #|#### |#    |#    ";;',
    '    Q) echo " ### |#   #|# # #|#  # | ## #";;',
    '    R) echo "#### |#   #|#### |# #  |#   #";;',
    '    S) echo " ####|#    | ### |    #|#### ";;',
    '    T) echo "#####|  #  |  #  |  #  |  #  ";;',
    '    U) echo "#   #|#   #|#   #|#   #| ### ";;',
    '    V) echo "#   #|#   #| # # | # # |  #  ";;',
    '    W) echo "#   #|#   #|# # #|## ##|#   #";;',
    '    X) echo "#   #| # # |  #  | # # |#   #";;',
    '    Y) echo "#   #| # # |  #  |  #  |  #  ";;',
    '    Z) echo "#####|   # |  #  | #   |#####";;',
    '    *) echo "     |     |     |     |     ";;',
    '  esac',
    '}',
    'font_width() { local d; d=$(font_data "$1"); local f="${d%%|*}"; echo ${#f}; }',
    '',
    '# calc name dimensions',
    'TOTAL_W=0',
    'for ((i=0;i<${#UPPER};i++)); do',
    '  w=$(font_width "${UPPER:$i:1}"); TOTAL_W=$((TOTAL_W+w+2))',
    'done',
    'SX=$(( (COLS-TOTAL_W)/2 )); ((SX<1)) && SX=1',
    'SY=$(( (LNS-5)/2 ))',
    '',
    '# draw one block letter',
    'draw_letter() {',
    '  local letter=$1 cx=$2 mode=$3 color=$4',
    '  local data row_data',
    '  local SC=(\'#\' \'@\' \'%\' \'&\' \'?\' \'!\' \'>\' \'<\' \'~\' \'^\' \'*\')',
    '  data=$(font_data "$letter")',
    '  IFS=\'|\' read -ra rows <<< "$data"',
    '  for ((rw=0;rw<5;rw++)); do',
    '    cur $((SY+rw)) $cx',
    '    row_data="${rows[$rw]}"',
    '    for ((ch=0;ch<${#row_data};ch++)); do',
    '      if [ "${row_data:$ch:1}" = "#" ]; then',
    '        if [ "$mode" = "solid" ]; then',
    '          out "${BD}${color}#${RS}"',
    '        else',
    '          out "${BD}${color}${SC[$((RANDOM%${#SC[@]}))]}${RS}"',
    '        fi',
    '      else',
    '        out " "',
    '      fi',
    '    done',
    '  done',
    '}',
    '',
    '# ═════ PHASE 1: STARS WAKING UP ═════',
    'for ((i=0;i<80;i++)); do',
    '  cur $((RANDOM%LNS+1)) $((RANDOM%COLS+1))',
    '  out "${DM}${CL[$((RANDOM%7))]}.${RS}"',
    '  sleep 0.015',
    'done',
    'for ((i=0;i<30;i++)); do',
    '  cur $((RANDOM%LNS+1)) $((RANDOM%COLS+1))',
    '  out "${BD}${CL[$((RANDOM%7))]}*${RS}"',
    '  sleep 0.02',
    'done',
    'sleep 0.3; clear',
    '',
    '# ═════ PHASE 2: MATRIX RAIN ═════',
    'declare -a ry rx rsp',
    'ND=30',
    'for ((i=0;i<ND;i++)); do',
    '  rx[$i]=$((RANDOM%COLS+1)); ry[$i]=1; rsp[$i]=$((RANDOM%2+1))',
    'done',
    'MC=(\'|\' \':\' \'.\' \'0\' \'1\' \';\')',
    'for ((f=0;f<50;f++)); do',
    '  for ((i=0;i<ND;i++)); do',
    '    oy=${ry[$i]}; ox=${rx[$i]}',
    '    ty=$((oy-3)); ((ty>0)) && { cur $ty $ox; out " "; }',
    '    ry[$i]=$((oy+rsp[$i]))',
    '    ny=${ry[$i]}',
    '    ((ny>LNS)) && { ry[$i]=1; rx[$i]=$((RANDOM%COLS+1)); ny=1; ox=${rx[$i]}; }',
    '    cur $ny $ox; out "${BD}${G}${MC[$((RANDOM%${#MC[@]}))]}${RS}"',
    '    ty=$((ny-1)); ((ty>0)) && { cur $ty $ox; out "${dG}${MC[$((RANDOM%${#MC[@]}))]}${RS}"; }',
    '    ty=$((ny-2)); ((ty>0)) && { cur $ty $ox; out "${DM}${dC}.${RS}"; }',
    '  done',
    '  sleep 0.03',
    'done',
    'sleep 0.2; clear',
    '',
    '# ═════ PHASE 3: FIREWORKS (8 bursts) ═════',
    'FW=(\'*\' \'+\' \'o\' \'.\' \'x\' \'~\')',
    'for burst in 1 2 3 4 5 6 7 8; do',
    '  cx=$((RANDOM%(COLS-20)+10)); cy=$((RANDOM%(LNS-10)+5))',
    '  c1=${CL[$((RANDOM%7))]}; c2=${CL[$((RANDOM%7))]}',
    '  for ((ty=LNS;ty>cy;ty-=2)); do',
    '    cur $ty $cx; out "${DM}${c1}|${RS}"',
    '    sleep 0.01; cur $((ty+2)) $cx; out " "',
    '  done',
    '  for r in 1 2 3 4 5 6 7 8; do',
    '    fc=${CL[$((RANDOM%7))]}',
    '    for dy in -1 0 1; do for dx in -2 -1 0 1 2; do',
    '      ((dx==0 && dy==0)) && continue',
    '      px=$((cx+dx*r)); py=$((cy+dy*r))',
    '      ((px>0 && px<=COLS && py>0 && py<=LNS)) || continue',
    '      cur $py $px; ch=${FW[$((RANDOM%${#FW[@]}))]}',
    '      if ((r>5)); then out "${DM}${c2}${ch}${RS}"; else out "${BD}${fc}${ch}${RS}"; fi',
    '    done; done',
    '    sleep 0.03',
    '  done',
    '  sleep 0.1; ((burst%3==0)) && clear',
    'done',
    'sleep 0.2; clear',
    '',
    '# ═════ PHASE 4: COLOR WAVE ═════',
    'WCH=(\'#\' \'=\' \'+\' \':\' \'.\' \':\' \'+\' \'=\' \'#\')',
    'for pass in 0 1 2; do',
    '  c=${CL[$((pass*2%7))]}; c2=${CL[$(((pass*2+1)%7))]}',
    '  for ((y=1;y<=LNS;y++)); do',
    '    cur $y 1; buf=""',
    '    for ((x=1;x<=COLS;x++)); do',
    '      wc=${WCH[$(((x+y)%${#WCH[@]}))]}',
    '      if (((x+y+pass*5)%7<3)); then buf+="${c}${wc}"; else buf+="${c2}${wc}"; fi',
    '    done',
    '    out "${buf}${RS}"',
    '    sleep 0.005',
    '  done',
    'done',
    'sleep 0.3; clear',
    '',
    '# ═════ PHASE 5: SCRAMBLE → REVEAL ═════',
    '# scramble 30 frames',
    'for ((f=0;f<30;f++)); do',
    '  fc=${CL[$((f%7))]}; cx=$SX',
    '  for ((i=0;i<${#UPPER};i++)); do',
    '    ch="${UPPER:$i:1}"',
    '    draw_letter "$ch" $cx "scramble" "$fc"',
    '    w=$(font_width "$ch"); cx=$((cx+w+2))',
    '  done',
    '  sleep 0.05',
    'done',
    '',
    '# resolve left to right',
    'for ((r=0;r<${#UPPER};r++)); do',
    '  cx=$SX',
    '  for ((i=0;i<${#UPPER};i++)); do',
    '    ch="${UPPER:$i:1}"',
    '    if ((i<=r)); then',
    '      draw_letter "$ch" $cx "solid" "${CL[$((i%7))]}"',
    '    else',
    '      draw_letter "$ch" $cx "scramble" "${CL[$(((r+i)%7))]}"',
    '    fi',
    '    w=$(font_width "$ch"); cx=$((cx+w+2))',
    '  done',
    '  sleep 0.2',
    'done',
    'sleep 0.5',
    '',
    '# ═════ PHASE 6: CONFETTI RAIN ═════',
    'NT=$((SY-1)); NB=$((SY+6))',
    'CF=(\'*\' \'+\' \'o\' \'~\' \'#\' \'=\' \'^\' \'!\' \'.\' \':\')',
    'for ((f=0;f<120;f++)); do',
    '  for p in 1 2 3 4 5 6; do',
    '    px=$((RANDOM%COLS+1)); py=$((RANDOM%LNS+1))',
    '    ((py>=NT && py<=NB)) && continue',
    '    cur $py $px; out "${CL[$((RANDOM%7))]}${CF[$((RANDOM%${#CF[@]}))]}${RS}"',
    '  done',
    '  if ((f%4==0)); then',
    '    cx=$SX',
    '    for ((i=0;i<${#UPPER};i++)); do',
    '      ch="${UPPER:$i:1}"',
    '      draw_letter "$ch" $cx "solid" "${CL[$(((f/4+i)%7))]}"',
    '      w=$(font_width "$ch"); cx=$((cx+w+2))',
    '    done',
    '  fi',
    '  sleep 0.05',
    'done',
    '',
    '# ═══════════════════════════════════════',
    '# PHASE 7: GRADUATION CAP (ASCII art, drawn line by line)',
    '# ═══════════════════════════════════════',
    'sleep 0.4; clear',
    '',
    '# Grad cap ASCII art (13 lines tall)',
    'CAP=(',
    '"         _______________         "',
    '"        /               \\\\        "',
    '"  _____/                 \\\\_____  "',
    '" /______________________________\\\\ "',
    '" \\\\______________________________/ "',
    '"        |               |        "',
    '"        |       #       |        "',
    '"        |      ###      |        "',
    '"        |       #       |        "',
    '"        |       #       |        "',
    '"        |      /#\\\\      |        "',
    '"        |     / # \\\\     |        "',
    '"        |    /  #  \\\\    |        "',
    ')',
    'CAP_H=${#CAP[@]}',
    'CAP_W=${#CAP[0]}',
    'CAP_X=$(( (COLS-CAP_W)/2 ))',
    'CAP_Y=$(( (LNS-CAP_H)/2 - 4 ))',
    '((CAP_Y<1)) && CAP_Y=1',
    '',
    '# Draw cap line by line with color cycling',
    'for ((ln=0;ln<CAP_H;ln++)); do',
    '  cur $((CAP_Y+ln)) $CAP_X',
    '  out "${BD}${Y}${CAP[$ln]}${RS}"',
    '  sleep 0.08',
    'done',
    'sleep 0.6',
    '',
    '# ═══════════════════════════════════════',
    '# PHASE 8: TASSEL FLIP ANIMATION',
    '# ═══════════════════════════════════════',
    'TASSEL_X=$((CAP_X + CAP_W/2 + 8))',
    'TASSEL_Y=$((CAP_Y + 3))',
    '',
    '# Tassel swings right to left (4 frames)',
    'T1=("  |" "  |" "  *" " /|" "/ |")',
    'T2=(" |" " |" " *" " |\\\\" " | \\\\")',
    'T3=("  |  " "  |  " "  *  " " /|\\\\ " "/ | \\\\")',
    'T4=(" |" " |" " *" "/| " "| / ")',
    'TFRAMES=("T1" "T2" "T3" "T4" "T3" "T2" "T1")',
    '',
    'for swing in 1 2 3; do',
    '  for frame in 0 1 2 3 2 1; do',
    '    case $frame in',
    '      0) TF=("${T1[@]}");;',
    '      1) TF=("${T2[@]}");;',
    '      2) TF=("${T3[@]}");;',
    '      3) TF=("${T4[@]}");;',
    '    esac',
    '    for ((tl=0;tl<${#TF[@]};tl++)); do',
    '      cur $((TASSEL_Y+tl)) $TASSEL_X',
    '      out "     "',
    '      cur $((TASSEL_Y+tl)) $TASSEL_X',
    '      out "${BD}${Y}${TF[$tl]}${RS}"',
    '    done',
    '    sleep 0.08',
    '  done',
    'done',
    'sleep 0.5',
    '',
    '# ═══════════════════════════════════════',
    '# PHASE 9: DIPLOMA UNROLL',
    '# ═══════════════════════════════════════',
    'clear',
    '',
    '# Diploma dimensions',
    'DW=44',
    'DH=16',
    'DX=$(( (COLS-DW)/2 ))',
    'DY=$(( (LNS-DH)/2 ))',
    '((DX<1)) && DX=1',
    '((DY<1)) && DY=1',
    '',
    '# Unroll effect: draw from center expanding outward',
    'for ((spread=0;spread<=DH/2;spread++)); do',
    '  top=$((DY + DH/2 - spread))',
    '  bot=$((DY + DH/2 + spread))',
    '  for row in $top $bot; do',
    '    ((row<1 || row>LNS)) && continue',
    '    cur $row $DX',
    '    out "${Y}"',
    '    for ((x=0;x<DW;x++)); do',
    '      if ((spread==0)); then out "=";',
    '      elif ((x==0 || x==DW-1)); then out "|";',
    '      elif ((row==top && spread>0)); then out "=";',
    '      elif ((row==bot && spread>0)); then out "=";',
    '      else out " "; fi',
    '    done',
    '    out "${RS}"',
    '  done',
    '  sleep 0.06',
    'done',
    '',
    '# Fill in the diploma content',
    'sleep 0.3',
    '',
    '# Inner border',
    'for ((row=DY+1;row<DY+DH-1;row++)); do',
    '  cur $row $((DX+1))',
    '  if ((row==DY+1 || row==DY+DH-2)); then',
    '    out "${DM}${Y}"',
    '    for ((x=0;x<DW-2;x++)); do out "-"; done',
    '    out "${RS}"',
    '  else',
    '    cur $row $((DX+1)); out "${DM}${Y}|${RS}"',
    '    cur $row $((DX+DW-2)); out "${DM}${Y}|${RS}"',
    '  fi',
    'done',
    'sleep 0.2',
    '',
    '# Diploma text - appears line by line',
    'ctext() {',
    '  local txt="$1" row=$2 color=$3',
    '  local len=${#txt}',
    '  local tx=$(( DX + (DW-len)/2 ))',
    '  cur $row $tx; out "${BD}${color}${txt}${RS}"',
    '}',
    '',
    'ctext "- - - - - - - - - - -" $((DY+3)) "$DM\\033[33m"',
    'sleep 0.15',
    'ctext "THIS CERTIFIES THAT" $((DY+5)) "$W"',
    'sleep 0.2',
    'ctext "$NAME" $((DY+7)) "$Y"',
    'sleep 0.3',
    'ctext "HAS OFFICIALLY GRADUATED" $((DY+9)) "$W"',
    'sleep 0.2',
    'ctext "CLASS OF 2026" $((DY+11)) "$M"',
    'sleep 0.2',
    'ctext "- - - - - - - - - - -" $((DY+13)) "$DM\\033[33m"',
    'sleep 1.0',
    '',
    '# ═══════════════════════════════════════',
    '# PHASE 10: CONGRATS REVEAL + FINAL FIREWORKS',
    '# ═══════════════════════════════════════',
    'clear',
    '',
    '# "CONGRATS" in block letters',
    'GRAD_MSG="CONGRATS"',
    'GRAD_UPPER=$(echo "$GRAD_MSG" | tr \'[:lower:]\' \'[:upper:]\')',
    'GW=0',
    'for ((i=0;i<${#GRAD_UPPER};i++)); do',
    '  w=$(font_width "${GRAD_UPPER:$i:1}"); GW=$((GW+w+2))',
    'done',
    'GX=$(( (COLS-GW)/2 )); ((GX<1)) && GX=1',
    'GY=$(( LNS/2 - 5 ))',
    '',
    '# Scramble then reveal "CONGRATS"',
    'for ((f=0;f<20;f++)); do',
    '  fc=${CL[$((f%7))]}; cx=$GX',
    '  for ((i=0;i<${#GRAD_UPPER};i++)); do',
    '    ch="${GRAD_UPPER:$i:1}"',
    '    draw_letter "$ch" $cx "scramble" "$fc"',
    '    w=$(font_width "$ch"); cx=$((cx+w+2))',
    '  done',
    '  sleep 0.04',
    'done',
    'for ((r=0;r<${#GRAD_UPPER};r++)); do',
    '  cx=$GX',
    '  for ((i=0;i<${#GRAD_UPPER};i++)); do',
    '    ch="${GRAD_UPPER:$i:1}"',
    '    if ((i<=r)); then',
    '      draw_letter "$ch" $cx "solid" "${CL[$((i%7))]}"',
    '    else',
    '      draw_letter "$ch" $cx "scramble" "${CL[$(((r+i)%7))]}"',
    '    fi',
    '    w=$(font_width "$ch"); cx=$((cx+w+2))',
    '  done',
    '  sleep 0.12',
    'done',
    '',
    '# Name below CONGRATS',
    'sleep 0.3',
    'NM_LINE="$NAME — Class of 2026"',
    'NM_X=$(( (COLS-${#NM_LINE})/2 ))',
    'cur $((GY+7)) $NM_X',
    'out "${BD}${W}${NM_LINE}${RS}"',
    'sleep 0.3',
    '',
    '# Hook em / horns up',
    'HOOK="\\\\m/"',
    'cur $((GY+9)) $(( (COLS-3)/2 ))',
    'out "${BD}${Y}${HOOK}${RS}"',
    'sleep 0.2',
    '',
    '# Final fireworks burst around the text',
    'for ((burst=0;burst<15;burst++)); do',
    '  for p in 1 2 3 4 5 6 7 8; do',
    '    px=$((RANDOM%COLS+1)); py=$((RANDOM%LNS+1))',
    '    ((py>=GY && py<=GY+10)) && continue',
    '    cur $py $px; out "${CL[$((RANDOM%7))]}${FW[$((RANDOM%${#FW[@]}))]}${RS}"',
    '  done',
    '  # cycle congrats colors',
    '  if ((burst%3==0)); then',
    '    cx=$GX',
    '    for ((i=0;i<${#GRAD_UPPER};i++)); do',
    '      ch="${GRAD_UPPER:$i:1}"',
    '      draw_letter "$ch" $cx "solid" "${CL[$(((burst/3+i)%7))]}"',
    '      w=$(font_width "$ch"); cx=$((cx+w+2))',
    '    done',
    '  fi',
    '  sleep 0.1',
    'done',
    '',
    '# Hold final frame',
    'sleep 4; cur $LNS 1; printf "\\n"',
    'tput cnorm; tput sgr0',
    'PARTY',
  ].join('\n');
}

export default function TerminalParty() {
  const [search, setSearch] = useState("");
  const [selected, setSelected] = useState(null);
  const [copied, setCopied] = useState(false);
  const [sparkles, setSparkles] = useState([]);

  const filtered = NAMES.filter(n =>
    n.toLowerCase().includes(search.toLowerCase())
  );

  useEffect(() => {
    const interval = setInterval(() => {
      setSparkles(prev => {
        const next = prev
          .map(s => ({ ...s, y: s.y + s.speed, opacity: s.opacity - 0.015 }))
          .filter(s => s.opacity > 0);
        if (Math.random() > 0.4) {
          next.push({
            id: Date.now() + Math.random(),
            x: Math.random() * 100, y: -2,
            char: ["*", "\u00B7", "\u2726", "\u00B0", "\u2022", "\u2605"][Math.floor(Math.random() * 6)],
            color: ACCENT_COLORS[Math.floor(Math.random() * ACCENT_COLORS.length)],
            speed: 0.3 + Math.random() * 0.5, opacity: 1,
          });
        }
        return next;
      });
    }, 60);
    return () => clearInterval(interval);
  }, []);

  const handleCopy = () => {
    if (!selected) return;
    navigator.clipboard.writeText(generateBashScript(selected)).then(() => {
      setCopied(true);
      setTimeout(() => setCopied(false), 2000);
    });
  };

  return (
    <div style={{
      minHeight: "100vh", background: "#0A0A0F", color: "#F0EDE6",
      fontFamily: "'Space Mono', monospace", position: "relative", overflow: "hidden",
    }}>
      {sparkles.map(s => (
        <div key={s.id} style={{
          position: "fixed", left: `${s.x}%`, top: `${s.y}%`,
          color: s.color, opacity: s.opacity, fontSize: "14px",
          pointerEvents: "none", zIndex: 0,
        }}>{s.char}</div>
      ))}

      <div style={{
        position: "fixed", inset: 0, zIndex: 1, pointerEvents: "none",
        background: `url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.85' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)' opacity='0.04'/%3E%3C/svg%3E")`,
        opacity: 0.5,
      }} />

      <div style={{ position: "relative", zIndex: 2, maxWidth: 900, margin: "0 auto", padding: "48px 24px" }}>
        <div style={{ textAlign: "center", marginBottom: 48 }}>
          <h1 style={{
            fontFamily: "'Syne', sans-serif", fontWeight: 800,
            fontSize: "clamp(2.5rem, 8vw, 5rem)", lineHeight: 1,
            background: "linear-gradient(135deg, #FF6B6B, #FFE66D, #4ECDC4, #A78BFA, #FF477E)",
            WebkitBackgroundClip: "text", WebkitTextFillColor: "transparent", marginBottom: 8,
          }}>TERMINAL PARTY</h1>
          <p style={{ fontSize: 14, color: "#888", letterSpacing: "0.15em", textTransform: "uppercase", marginBottom: 6 }}>
            find your name &middot; copy the script &middot; paste in terminal
          </p>
          <p style={{ fontSize: 12, color: "#555", maxWidth: 440, margin: "0 auto", lineHeight: 1.6 }}>
            6-phase show &rarr; graduation ceremony: stars &rarr; matrix rain &rarr; fireworks &rarr;
            color wave &rarr; name reveal &rarr; confetti &rarr; grad cap &rarr; diploma &rarr; CONGRATS.
            ~30 seconds. fullscreen recommended.
          </p>
        </div>

        <div style={{ marginBottom: 32 }}>
          <input type="text" value={search}
            onChange={e => { setSearch(e.target.value); setSelected(null); }}
            placeholder="search names..."
            style={{
              width: "100%", padding: "14px 20px", background: "#151520",
              border: "1px solid #2A2A3A", borderRadius: 8, color: "#F0EDE6",
              fontFamily: "'Space Mono', monospace", fontSize: 14,
              outline: "none", boxSizing: "border-box",
            }}
          />
        </div>

        {!selected && (
          <div style={{
            display: "grid", gridTemplateColumns: "repeat(auto-fill, minmax(110px, 1fr))",
            gap: 10, marginBottom: 40,
          }}>
            {filtered.map((name, i) => (
              <button key={name} onClick={() => setSelected(name)}
                style={{
                  background: "#151520",
                  border: `1px solid ${ACCENT_COLORS[i % ACCENT_COLORS.length]}33`,
                  borderRadius: 6, padding: "14px 8px", cursor: "pointer",
                  fontFamily: "'Bebas Neue', sans-serif", fontSize: 22,
                  letterSpacing: "0.05em",
                  color: ACCENT_COLORS[i % ACCENT_COLORS.length],
                  transition: "all 0.2s",
                }}
                onMouseEnter={e => {
                  e.currentTarget.style.background = `${ACCENT_COLORS[i % ACCENT_COLORS.length]}15`;
                  e.currentTarget.style.borderColor = ACCENT_COLORS[i % ACCENT_COLORS.length];
                  e.currentTarget.style.transform = "translateY(-2px)";
                }}
                onMouseLeave={e => {
                  e.currentTarget.style.background = "#151520";
                  e.currentTarget.style.borderColor = `${ACCENT_COLORS[i % ACCENT_COLORS.length]}33`;
                  e.currentTarget.style.transform = "translateY(0)";
                }}
              >{name}</button>
            ))}
          </div>
        )}

        {filtered.length === 0 && !selected && (
          <p style={{ textAlign: "center", color: "#555", fontSize: 14 }}>no names match &ldquo;{search}&rdquo;</p>
        )}

        {selected && (
          <div style={{ animation: "fadeIn 0.3s ease" }}>
            <style>{`@keyframes fadeIn { from { opacity:0; transform:translateY(10px) } to { opacity:1; transform:translateY(0) } }`}</style>

            <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", marginBottom: 20 }}>
              <button onClick={() => setSelected(null)} style={{
                background: "none", border: "1px solid #333", color: "#888",
                padding: "8px 16px", borderRadius: 6, cursor: "pointer",
                fontFamily: "'Space Mono', monospace", fontSize: 12,
              }}>&larr; back</button>
              <h2 style={{
                fontFamily: "'Syne', sans-serif", fontWeight: 800, fontSize: 32,
                color: ACCENT_COLORS[NAMES.indexOf(selected) % ACCENT_COLORS.length],
              }}>{selected}</h2>
              <div style={{ width: 80 }} />
            </div>

            <div style={{
              background: "#151520", border: "1px solid #2A2A3A",
              borderRadius: 8, padding: 20, marginBottom: 16,
            }}>
              <p style={{ fontSize: 13, color: "#aaa", margin: 0, lineHeight: 1.7 }}>
                <span style={{ color: "#FFE66D" }}>1.</span> Copy the script below<br/>
                <span style={{ color: "#4ECDC4" }}>2.</span> Open Terminal and go <b style={{color:"#fff"}}>fullscreen</b><br/>
                <span style={{ color: "#A78BFA" }}>3.</span> Paste the whole thing and hit Enter<br/>
                <span style={{ color: "#FF477E" }}>4.</span> Enjoy the show (~30 seconds)
              </p>
            </div>

            <div style={{ background: "#0D0D14", border: "1px solid #2A2A3A", borderRadius: 8, overflow: "hidden" }}>
              <div style={{
                display: "flex", alignItems: "center", justifyContent: "space-between",
                padding: "10px 16px", borderBottom: "1px solid #1A1A2A",
              }}>
                <div style={{ display: "flex", gap: 6 }}>
                  <div style={{ width: 10, height: 10, borderRadius: "50%", background: "#FF5F57" }} />
                  <div style={{ width: 10, height: 10, borderRadius: "50%", background: "#FEBC2E" }} />
                  <div style={{ width: 10, height: 10, borderRadius: "50%", background: "#28C840" }} />
                </div>
                <span style={{ fontSize: 11, color: "#555" }}>bash</span>
              </div>
              <pre style={{
                padding: 16, margin: 0, overflow: "auto", maxHeight: 350,
                fontSize: 11, lineHeight: 1.5, color: "#8B8BA0",
                fontFamily: "'Space Mono', monospace",
              }}>{generateBashScript(selected)}</pre>
            </div>

            <button onClick={handleCopy} style={{
              width: "100%", marginTop: 16, padding: "16px",
              background: copied ? "linear-gradient(135deg, #06D6A0, #4ECDC4)" : "linear-gradient(135deg, #FF477E, #A78BFA)",
              border: "none", borderRadius: 8, color: "#fff",
              fontFamily: "'Bebas Neue', sans-serif", fontSize: 24,
              letterSpacing: "0.1em", cursor: "pointer", transition: "all 0.3s",
            }}>{copied ? "COPIED \u2713" : "COPY SCRIPT"}</button>
          </div>
        )}

        <div style={{
          textAlign: "center", marginTop: 64, fontSize: 11, color: "#333",
          letterSpacing: "0.15em", textTransform: "uppercase",
        }}>built with chaos &middot; trey c. &middot; 2026</div>
      </div>
    </div>
  );
}
