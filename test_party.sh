# TERMINAL PARTY for Trey Carrillo
# Paste this entire block into your terminal and hit Enter.
# Works on macOS (zsh or bash), iTerm2, any Linux terminal.
# Make it FULLSCREEN for the best experience!
# Ctrl+C to exit anytime.
bash << 'PARTY'
NAME="Trey Carrillo"
UPPER=$(echo "$NAME" | tr '[:lower:]' '[:upper:]')

trap 'tput cnorm; tput sgr0; clear; exit' INT TERM EXIT
tput civis; clear
COLS=$(tput cols); LNS=$(tput lines)
MX=$((COLS/2)); MY=$((LNS/2))

# colors
R='\033[91m'; G='\033[92m'; Y='\033[93m'; B='\033[94m'
M='\033[95m'; C='\033[96m'; W='\033[97m'
dG='\033[32m'; dC='\033[36m'
BO='\033[38;5;208m'
BD='\033[1m'; DM='\033[2m'; RS='\033[0m'
CL=("$R" "$G" "$Y" "$B" "$M" "$C" "$W")

cur(){ printf "\033[%d;%dH" "$1" "$2"; }
out(){ printf "%b" "$@"; }

# shared character arrays (used across multiple phases)
FW=('*' '+' 'o' '.' 'x' '~')
EXP_CHARS=("*" "#" "@" "!" "%" "X" "+" "~" "^" "&")

# block letter font (5 rows, | separated)
font_data() {
  case "$1" in
    A) echo " ### |#   #|#####|#   #|#   #";;
    B) echo "#### |#   #|#### |#   #|#### ";;
    C) echo " ####|#    |#    |#    | ####";;
    D) echo "#### |#   #|#   #|#   #|#### ";;
    E) echo "#####|#    |###  |#    |#####";;
    F) echo "#####|#    |###  |#    |#    ";;
    G) echo " ####|#    |# ###|#   #| ####";;
    H) echo "#   #|#   #|#####|#   #|#   #";;
    I) echo "###| # | # | # |###";;
    J) echo " ####|    #|    #|#   #| ### ";;
    K) echo "#  # |# #  |##   |# #  |#  # ";;
    L) echo "#    |#    |#    |#    |#####";;
    M) echo "#   #|## ##|# # #|#   #|#   #";;
    N) echo "#   #|##  #|# # #|#  ##|#   #";;
    O) echo " ### |#   #|#   #|#   #| ### ";;
    P) echo "#### |#   #|#### |#    |#    ";;
    Q) echo " ### |#   #|# # #|#  # | ## #";;
    R) echo "#### |#   #|#### |# #  |#   #";;
    S) echo " ####|#    | ### |    #|#### ";;
    T) echo "#####|  #  |  #  |  #  |  #  ";;
    U) echo "#   #|#   #|#   #|#   #| ### ";;
    V) echo "#   #|#   #| # # | # # |  #  ";;
    W) echo "#   #|#   #|# # #|## ##|#   #";;
    X) echo "#   #| # # |  #  | # # |#   #";;
    Y) echo "#   #| # # |  #  |  #  |  #  ";;
    Z) echo "#####|   # |  #  | #   |#####";;
    *) echo "     |     |     |     |     ";;
  esac
}
font_width() { local d; d=$(font_data "$1"); local f="${d%%|*}"; echo ${#f}; }

# calc name dimensions
TOTAL_W=0
for ((i=0;i<${#UPPER};i++)); do
  w=$(font_width "${UPPER:$i:1}"); TOTAL_W=$((TOTAL_W+w+2))
done
SX=$(( (COLS-TOTAL_W)/2 )); ((SX<1)) && SX=1
SY=$(( (LNS-5)/2 ))

# draw one block letter at arbitrary y
draw_letter_at() {
  local letter=$1 cx=$2 by=$3 mode=$4 color=$5
  local data row_data
  local SC=('#' '@' '%' '&' '?' '!' '>' '<' '~' '^' '*')
  data=$(font_data "$letter")
  IFS='|' read -ra rows <<< "$data"
  for ((rw=0;rw<5;rw++)); do
    cur $((by+rw)) $cx
    row_data="${rows[$rw]}"
    for ((ch=0;ch<${#row_data};ch++)); do
      if [ "${row_data:$ch:1}" = "#" ]; then
        if [ "$mode" = "solid" ]; then
          out "${BD}${color}#${RS}"
        else
          out "${BD}${color}${SC[$((RANDOM%${#SC[@]}))]}${RS}"
        fi
      else
        out " "
      fi
    done
  done
}
draw_letter() { draw_letter_at "$1" "$2" "$SY" "$3" "$4"; }

# ═══════════════════════════════════════════════════
# PHASE 0: TERMINAL BOOT SEQUENCE
# ═══════════════════════════════════════════════════
BOOT_LINES=(
  "[SYS] booting graduation_protocol v2026.05 ..."
  "[SYS] loading class_of_2026.db ............... OK"
  "[SYS] authenticating $NAME ................... OK"
  "[SYS] compiling celebration_engine ........... OK"
  "[SYS] linking fireworks.so, confetti.so ...... OK"
  "[SYS] mounting /dev/longhorn ................. OK"
  "[SYS] calibrating party intensity ............ MAX"
  ""
  ">>> ACCESS GRANTED <<<"
  ""
  ">>> LAUNCHING CELEBRATION SEQUENCE FOR: $UPPER <<<"
)
BOOT_Y=$((MY-6))
BOOT_DELAY=(08 08 08 10 10 12 12 15 15 20 25)
for ((bi=0;bi<${#BOOT_LINES[@]};bi++)); do
  line="${BOOT_LINES[$bi]}"
  bx=$(( (COLS-${#line})/2 ))
  ((bx<1)) && bx=1
  cur $((BOOT_Y+bi)) $bx
  # Typewriter each line
  for ((ci=0;ci<${#line};ci++)); do
    ch="${line:$ci:1}"
    if [ "$ch" = "." ]; then
      out "${DM}${G}${ch}${RS}"; sleep 0.0$((RANDOM%3+1))
    elif [ "$ch" = ">" ] || [ "$ch" = "<" ]; then
      out "${BD}${BO}${ch}${RS}"; sleep 0.02
    elif ((bi>=8)); then
      out "${BD}${Y}${ch}${RS}"; sleep 0.025
    else
      out "${G}${ch}${RS}"; sleep 0.008
    fi
  done
  # Mini loading bar after "compiling celebration_engine"
  ((bi==3)) && {
    out " ${G}[${RS}"
    for ((lb=0;lb<20;lb++)); do out "${BD}${G}█${RS}"; sleep 0.015; done
    out "${G}]${RS}"
  }
  sleep 0.${BOOT_DELAY[$bi]:-15}
done

# Blink cursor effect
for ((blink=0;blink<6;blink++)); do
  cur $((BOOT_Y+${#BOOT_LINES[@]}+1)) $((MX))
  if ((blink%2==0)); then out "${BD}${G}█${RS}"; else out " "; fi
  sleep 0.15
done
sleep 0.4; clear

# ═══════════════════════════════════════════════════
# PHASE 1: STARS WAKING UP
# ═══════════════════════════════════════════════════
# Layer 1: Far stars (dim, small)
FAR_CH=("." ",")
for ((i=0;i<30;i++)); do
  cur $((RANDOM%LNS+1)) $((RANDOM%COLS+1))
  out "${DM}${W}${FAR_CH[$((RANDOM%2))]}${RS}"
  sleep 0.02
done
# Layer 2: Mid stars (normal brightness)
MID_CH=("+" "*")
for ((i=0;i<20;i++)); do
  cur $((RANDOM%LNS+1)) $((RANDOM%COLS+1))
  out "${W}${MID_CH[$((RANDOM%2))]}${RS}"
  sleep 0.03
done
# Layer 3: Near stars (bright) — save positions
declare -a STAR3_X STAR3_Y
NEAR_CH=("*" "✦")
for ((i=0;i<10;i++)); do
  STAR3_X[$i]=$((RANDOM%COLS+1))
  STAR3_Y[$i]=$((RANDOM%LNS+1))
  cur ${STAR3_Y[$i]} ${STAR3_X[$i]}
  out "${BD}${W}${NEAR_CH[$((RANDOM%2))]}${RS}"
  sleep 0.04
done

# Constellation pass: connect adjacent star pairs with dim lines
for ((cp=0;cp<10;cp+=2)); do
  x1=${STAR3_X[$cp]}; y1=${STAR3_Y[$cp]}
  x2=${STAR3_X[$((cp+1))]}; y2=${STAR3_Y[$((cp+1))]}
  # Draw connecting characters between star pairs
  dx=$((x2-x1)); dy=$((y2-y1))
  steps=$((dx>dy ? dx : dy)); ((steps<0)) && steps=$((-steps))
  ((steps<1)) && steps=1; ((steps>15)) && steps=15
  for ((cs=1;cs<steps;cs++)); do
    cx=$((x1+dx*cs/steps)); cy=$((y1+dy*cs/steps))
    ((cx>0 && cx<=COLS && cy>0 && cy<=LNS)) && {
      if ((dx>dy && dx>0 || dx<dy && dx<0)); then lch="-"
      elif ((dy>dx)); then lch="|"
      else lch="/"; fi
      cur $cy $cx; out "${DM}${C}${lch}${RS}"
    }
    sleep 0.01
  done
done

# Positional twinkle: pulse saved layer-3 stars
for ((tw=0;tw<5;tw++)); do
  for ((i=0;i<10;i++)); do
    cur ${STAR3_Y[$i]} ${STAR3_X[$i]}
    out "${BD}${Y}*${RS}"
  done
  sleep 0.12
  for ((i=0;i<10;i++)); do
    cur ${STAR3_Y[$i]} ${STAR3_X[$i]}
    out "${BD}${W}*${RS}"
  done
  sleep 0.12
done
sleep 0.3; clear

# --- narrative beat ---
BEAT1="the universe remembers your name ..."
BEAT1_X=$(( (COLS-${#BEAT1})/2 ))
cur $MY $BEAT1_X
for ((bi=0;bi<${#BEAT1};bi++)); do
  out "${DM}${C}${BEAT1:$bi:1}${RS}"; sleep 0.03
done
sleep 0.6; clear

# ═══════════════════════════════════════════════════
# PHASE 2: UT MATRIX RAIN
# ═══════════════════════════════════════════════════
UT_WORDS=("LONGHORN" "HOOKEM" "MCCOMBS" "AUSTIN" "TOWER" "BEVO" "TEXAS" "BURNT" "ORANGE" "MARKETING" "2026" "MASTERS" "PCL" "GUADALUPE" "DRAG" "SPEEDWAY" "JESTER" "DARRELL" "ROYAL" "40ACRES" "WHATSTARTSHERE" "HOOK" "EM" "HORNS" "SLAY" "GOAT" "CLASS" "GRAD" "McCombs" "DEGREE" "PARTY" "WOOO" "LETS" "GO")
NAME_WORDS=()
for word in $UPPER; do NAME_WORDS+=("$word"); done
ALL_RAIN=("${UT_WORDS[@]}" "${NAME_WORDS[@]}" "${UT_WORDS[@]}" "${UT_WORDS[@]}")

declare -a sr_x sr_y sr_sp sr_word sr_pos sr_color
SR_N=30
for ((i=0;i<SR_N;i++)); do
  sr_x[$i]=$((RANDOM%COLS+1))
  ((sr_x[$i]<1)) && sr_x[$i]=1; ((sr_x[$i]>COLS)) && sr_x[$i]=$COLS
  sr_y[$i]=$((-(RANDOM%10)))
  sr_sp[$i]=$((RANDOM%2+1))
  sr_word[$i]="${ALL_RAIN[$((RANDOM%${#ALL_RAIN[@]}))]}"
  sr_pos[$i]=0
  sr_color[$i]=$((RANDOM%3))
done

for ((f=0;f<90;f++)); do
  for ((i=0;i<SR_N;i++)); do
    oy=${sr_y[$i]}; ox=${sr_x[$i]}
    word="${sr_word[$i]}"
    pos=${sr_pos[$i]}
    # Erase old head and old trail positions
    ((oy>0 && oy<=LNS && ox>0 && ox<=COLS)) && { cur $oy $ox; out " "; }
    ((oy-1>0 && oy-1<=LNS && ox>0 && ox<=COLS)) && { cur $((oy-1)) $ox; out " "; }
    sr_y[$i]=$((oy + sr_sp[$i]))
    ny=${sr_y[$i]}
    if ((pos >= ${#word})); then
      sr_y[$i]=$((-(RANDOM%8)))
      sr_x[$i]=$((RANDOM%COLS+1))
      ((sr_x[$i]<1)) && sr_x[$i]=1; ((sr_x[$i]>COLS)) && sr_x[$i]=$COLS
      sr_word[$i]="${ALL_RAIN[$((RANDOM%${#ALL_RAIN[@]}))]}"
      sr_pos[$i]=0
      sr_color[$i]=$((RANDOM%3))
      continue
    fi
    ch="${word:$pos:1}"
    sr_pos[$i]=$((pos+1))
    cc=${sr_color[$i]}
    if ((cc==0)); then hc="${G}"; tc="${dG}";
    elif ((cc==1)); then hc="${BO}"; tc="${Y}";
    else hc="${C}"; tc="${B}"; fi
    ((ny>0 && ny<=LNS && ox>0 && ox<=COLS)) && { cur $ny $ox; out "${BD}${hc}${ch}${RS}"; }
    ty=$((ny-1))
    ((ty>0 && ty<=LNS && ox>0 && ox<=COLS)) && { cur $ty $ox; out "${tc}${ch}${RS}"; }
    ((ny>LNS)) && {
      sr_y[$i]=$((-(RANDOM%6)))
      sr_x[$i]=$((RANDOM%COLS+1))
      ((sr_x[$i]<1)) && sr_x[$i]=1; ((sr_x[$i]>COLS)) && sr_x[$i]=$COLS
      sr_word[$i]="${ALL_RAIN[$((RANDOM%${#ALL_RAIN[@]}))]}"
      sr_pos[$i]=0
      sr_color[$i]=$((RANDOM%3))
    }
  done
  # Column flash every 15 frames
  ((f%15==0 && f>0)) && {
    flash_x=$((RANDOM%COLS+1))
    for ((fy=1;fy<=LNS;fy++)); do
      cur $fy $flash_x; out "${BD}${G}█${RS}"
    done
    sleep 0.02
  }
  sleep 0.035
done
sleep 0.2; clear

# ═══════════════════════════════════════════════════
# PHASE 3: COMPILING YOUR FUTURE (loading sequence)
# ═══════════════════════════════════════════════════
LOAD_ITEMS=(
  "leadership.exe"
  "marketing_strategy.dll"
  "consumer_insights.so"
  "brand_management.pkg"
  "data_analytics.lib"
  "presentation_skills.mod"
  "networking.sys"
  "hook_em_spirit.core"
)
BAR_W=$((COLS-30))
((BAR_W>60)) && BAR_W=60
BAR_X=$(( (COLS-BAR_W-20)/2 ))
LOAD_Y=$((MY-${#LOAD_ITEMS[@]}/2-3))

# Header
HDR=">>> COMPILING YOUR FUTURE <<<"
HDR_X=$(( (COLS-${#HDR})/2 ))
cur $((LOAD_Y-2)) $HDR_X
out "${BD}${C}${HDR}${RS}"
sleep 0.3

# Each item loads with a progress bar
WARN_MSGS=("" "" "[WARN] enthusiasm levels exceeding safe thresholds..." "" "" "[WARN] future brightness may cause temporary blindness..." "" "")
for ((li=0;li<${#LOAD_ITEMS[@]};li++)); do
  item="${LOAD_ITEMS[$li]}"
  ly=$((LOAD_Y+li*2))
  cur $ly $BAR_X
  out "${G}Loading ${item}${RS}"
  cur $((ly+1)) $BAR_X; out "${DM}${W}[${RS}"
  # Fill progress bar with stutter + percentage
  seg=$((BAR_W/5)); ((seg<1)) && seg=1
  for ((bp=0;bp<BAR_W;bp++)); do
    if ((bp<BAR_W/3)); then pc="${G}"
    elif ((bp<BAR_W*2/3)); then pc="${Y}"
    else pc="${BO}"; fi
    out "${BD}${pc}█${RS}"
    # Stutter at 40% and 75%
    if ((bp==BAR_W*40/100 || bp==BAR_W*75/100)); then
      sleep 0.$((RANDOM%3+1))
    elif ((bp%seg==0)); then
      sleep 0.01
    fi
    # Percentage counter
    pct=$((bp*100/BAR_W))
    cur $((ly+1)) $((BAR_X+BAR_W+3)); out "${DM}${W}${pct}%%  ${RS}"
  done
  cur $((ly+1)) $((BAR_X+BAR_W+3)); out "${DM}${W}100%%${RS}"
  out " ${BD}${G}✓${RS}"
  sleep 0.06
  # Personality messages after bars 2 and 5
  wm="${WARN_MSGS[$li]}"
  if [ -n "$wm" ]; then
    wm_x=$(( (COLS-${#wm})/2 ))
    ((wm_x<1)) && wm_x=1
    cur $((ly+2)) $wm_x; out "${DM}${Y}${wm}${RS}"
    sleep 0.6
    cur $((ly+2)) $wm_x; printf "\033[K"
  fi
done

# Final message
sleep 0.3
DONE_TXT="COMPILATION COMPLETE — ALL SYSTEMS GO"
DONE_X=$(( (COLS-${#DONE_TXT})/2 ))
cur $((LOAD_Y+${#LOAD_ITEMS[@]}*2+1)) $DONE_X
out "${BD}${Y}${DONE_TXT}${RS}"
sleep 0.8; clear

# ═══════════════════════════════════════════════════
# PHASE 3.5: SYSTEM OVERRIDE TRANSITION
# ═══════════════════════════════════════════════════
# 3-line sweep band moving down the screen
for ((sy=1;sy<=LNS;sy++)); do
  # Bright leading edge
  cur $sy 1; buf=""; for ((sx=1;sx<=COLS;sx++)); do buf+="═"; done
  out "${BD}${BO}${buf}${RS}"
  # Dim trail one line back
  ((sy>1)) && {
    cur $((sy-1)) 1; buf=""; for ((sx=1;sx<=COLS;sx++)); do buf+="─"; done
    out "${DM}${Y}${buf}${RS}"
  }
  # Erase two lines back
  ((sy>2)) && { cur $((sy-2)) 1; printf "\033[K"; }
  sleep 0.005
done
# Clean up final lines
cur $((LNS-1)) 1; printf "\033[K"
cur $LNS 1; printf "\033[K"

# Flash centered text WITHOUT clear — overwrite in place
OVRD="[ CELEBRATION MODE ENGAGED ]"
OVRD_X=$(( (COLS-${#OVRD})/2 ))
OVRD_COLORS=("${BO}" "${Y}" "${W}" "${BO}" "${Y}" "${W}")
for ((of=0;of<6;of++)); do
  cur $MY $OVRD_X
  out "${BD}${OVRD_COLORS[$of]}${OVRD}${RS}"
  sleep 0.08
done

# Expanding box border around the text
OVRD_LEN=${#OVRD}
for ((bf=0;bf<4;bf++)); do
  pad=$((bf*2))
  bx1=$((OVRD_X-pad-1)); bx2=$((OVRD_X+OVRD_LEN+pad))
  by1=$((MY-bf-1)); by2=$((MY+bf+1))
  ((bx1<1)) && bx1=1; ((bx2>COLS)) && bx2=$COLS
  ((by1<1)) && by1=1; ((by2>LNS)) && by2=$LNS
  bw=$((bx2-bx1+1))
  # Top border
  cur $by1 $bx1; out "${BD}${Y}╔${RS}"
  for ((bfi=1;bfi<bw-1;bfi++)); do out "${BD}${Y}═${RS}"; done
  out "${BD}${Y}╗${RS}"
  # Bottom border
  cur $by2 $bx1; out "${BD}${Y}╚${RS}"
  for ((bfi=1;bfi<bw-1;bfi++)); do out "${BD}${Y}═${RS}"; done
  out "${BD}${Y}╝${RS}"
  # Side borders
  for ((bfy=by1+1;bfy<by2;bfy++)); do
    cur $bfy $bx1; out "${BD}${Y}║${RS}"
    cur $bfy $bx2; out "${BD}${Y}║${RS}"
  done
  sleep 0.1
done
sleep 0.4; clear

# --- narrative beat ---
BEAT2="time to celebrate ..."
BEAT2_X=$(( (COLS-${#BEAT2})/2 ))
cur $MY $BEAT2_X
for ((bi=0;bi<${#BEAT2};bi++)); do
  out "${DM}${M}${BEAT2:$bi:1}${RS}"; sleep 0.03
done
sleep 0.5; clear

# ═══════════════════════════════════════════════════
# DISCO FLOOR
# ═══════════════════════════════════════════════════
# Disco ball at top center
DB_X=$((MX-6))
DB=(
"     .----.     "
"   / o  o  \\   "
"  | o  o  o |  "
"   \\ o  o  /   "
"     ----      "
"      ||       "
)
for ((bl=0;bl<${#DB[@]};bl++)); do
  cur $((1+bl)) $DB_X; out "${BD}${W}${DB[$bl]}${RS}"
done

sleep 0.2

# Animated checkerboard dance floor with colored tiles
DBLK=("█" "▓" "▒" "░")
DCL=("\033[41m" "\033[42m" "\033[43m" "\033[44m" "\033[45m" "\033[46m" "\033[47m")
FLOOR_TOP=$((LNS/2))
SPARKLE_CH=("·" "•" "*" "✦" "◆")
NOTE_CH=("♪" "♫" "♩")
for ((disco=0;disco<32;disco++)); do
  # Redraw disco ball sparkle — 5 states
  cur 1 $DB_X
  case $((disco%5)) in
    0) out "${BD}${Y}     .----.     ${RS}";;
    1) out "${BD}${W}     .${SPARKLE_CH[1]}--${SPARKLE_CH[2]}-.     ${RS}";;
    2) out "${BD}${C}     .----.     ${RS}";;
    3) out "${BD}${Y}     .${SPARKLE_CH[3]}--${SPARKLE_CH[0]}-.     ${RS}";;
    4) out "${BD}${W}     .----.     ${RS}";;
  esac

  # Animated light rays — sway with disco%4-2 offset
  for ((ray=0;ray<12;ray++)); do
    rx=$((MX + (ray-6)*6 + disco%4-2))
    for ((ry=7;ry<7+ray%4+2;ry++)); do
      ((rx>0 && rx<=COLS && ry>0 && ry<=LNS)) && {
        cur $ry $rx; out "${DM}${CL[$((disco%7))]}|${RS}"
      }
    done
  done

  # Music note particles — float upward every 4th frame
  ((disco%4==0)) && {
    nx=$((MX+RANDOM%20-10)); ny=$((FLOOR_TOP-2-disco/4))
    ((ny>0 && nx>0 && nx<=COLS)) && {
      cur $ny $nx; out "${DM}${M}${NOTE_CH[$((RANDOM%3))]}${RS}"
    }
  }

  # Draw checkerboard floor tiles
  for ((dy=FLOOR_TOP;dy<=LNS;dy++)); do
    cur $dy 1; buf=""
    for ((dx=1;dx<=COLS;dx++)); do
      if (( (dx/3+dy+disco)%2==0 )); then
        buf+="${DBLK[$((disco%${#DBLK[@]}))]}"
      else
        buf+=" "
      fi
    done
    out "${DCL[$(( (dy+disco)%7 ))]}${buf}${RS}"
  done

  # Spotlights sweep across
  spot=$((MX + (disco%8-4)*8))
  for ((sy=8;sy<FLOOR_TOP;sy++)); do
    ((spot>0 && spot<=COLS && sy>0 && sy<=LNS)) && {
      cur $sy $spot; out "${BD}${CL[$((disco%7))]}|${RS}"
    }
  done
  sleep 0.06
done
sleep 0.3; clear

# --- narrative beat ---
BEAT3="but first ... the eternal debate"
BEAT3_X=$(( (COLS-${#BEAT3})/2 ))
cur $MY $BEAT3_X
for ((bi=0;bi<${#BEAT3};bi++)); do
  out "${DM}${Y}${BEAT3:$bi:1}${RS}"; sleep 0.03
done
sleep 0.5; clear

# ═══════════════════════════════════════════════════
# R vs PYTHON WAR
# ═══════════════════════════════════════════════════
R_ART=(
"  ____  "
" |  _ \\ "
" | |_) |"
" |  _ < "
" |_| \\_\\"
)
R_H=5; R_W=9

PY_ART=(
" _____  "
"|  __ \\ "
"| |__) |"
"|  ___/ "
"|_|     "
)
PY_H=5; PY_W=9

# Snake for Python side
PY_SNAKE=("~~~~~>" "~~~~>" "~~~>" "~~>" "~>" ">" "~>" "~~>" "~~~>" "~~~~>")
# Stats for R side
R_STATS=("mean()" "lm()" "ggplot" "dplyr" "t.test" "cor()")

FIGHT_Y=$((MY - 3))

# Pre-fight: titles appear
PY_TITLE=">>> PYTHON <<<"
R_TITLE=">>> R <<<"
PY_TX=$(( COLS/4 - ${#PY_TITLE}/2 ))
R_TX=$(( 3*COLS/4 - ${#R_TITLE}/2 ))
cur $((FIGHT_Y-3)) $PY_TX; out "${BD}${B}${PY_TITLE}${RS}"
cur $((FIGHT_Y-3)) $R_TX; out "${BD}${C}${R_TITLE}${RS}"
sleep 0.3

# Charge toward each other with projectiles
for ((step=0;step<=MX-6;step+=2)); do
  py_x=$((step+1))
  r_x=$((COLS-step-R_W))
  # Clear & draw Python
  for ((ll=0;ll<PY_H;ll++)); do
    cur $((FIGHT_Y+ll)) $py_x; out "         "
    cur $((FIGHT_Y+ll)) $py_x; out "${BD}${B}${PY_ART[$ll]}${RS}"
  done
  # Clear & draw R
  for ((ll=0;ll<R_H;ll++)); do
    cur $((FIGHT_Y+ll)) $r_x; out "         "
    cur $((FIGHT_Y+ll)) $r_x; out "${BD}${C}${R_ART[$ll]}${RS}"
  done
  # Clear previous projectiles
  ((step>0 && step%6==2)) && {
    for ((ppy=FIGHT_Y;ppy<FIGHT_Y+PY_H;ppy++)); do
      cur $ppy $((py_x+PY_W-2)); printf "\033[K"
    done
  }
  ((step>0 && step%8==2)) && {
    for ((rpy=FIGHT_Y;rpy<FIGHT_Y+R_H;rpy++)); do
      rr_x=$((r_x-8)); ((rr_x>0)) && { cur $rpy $rr_x; out "        "; }
    done
  }
  # Python shoots snake projectiles
  ((step%6==0)) && {
    sn="${PY_SNAKE[$((RANDOM%${#PY_SNAKE[@]}))]}"
    sl_y=$((FIGHT_Y+RANDOM%PY_H))
    cur $sl_y $((py_x+PY_W)); out "${BD}${G}${sn}${RS}"
  }
  # R shoots function projectiles
  ((step%8==0)) && {
    rf="${R_STATS[$((RANDOM%${#R_STATS[@]}))]}"
    sl_y=$((FIGHT_Y+RANDOM%R_H))
    ((r_x>3)) && { cur $sl_y $((r_x-${#rf}-1)); out "${BD}${M}${rf}${RS}"; }
  }
  # VS text appears midway
  ((step>MX/3)) && {
    cur $((FIGHT_Y+2)) $((MX-2))
    if ((step%4<2)); then out "${BD}${R} VS ${RS}"; else out "${BD}${Y} VS ${RS}"; fi
  }
  # Battle sparks around center
  ((step>MX/2)) && {
    for ss in 1 2 3; do
      sx=$((MX+RANDOM%10-5)); sy=$((FIGHT_Y+RANDOM%5))
      ((sx>0 && sx<=COLS && sy>0 && sy<=LNS)) && {
        cur $sy $sx; out "${BD}${CL[$((RANDOM%7))]}${EXP_CHARS[$((RANDOM%${#EXP_CHARS[@]}))]}${RS}"
      }
    done
  }
  sleep 0.02
done

# COLLISION EXPLOSION — symmetric 16-point circular burst
EX_DX=(0 1 2 2 3 2 2 1 0 -1 -2 -2 -3 -2 -2 -1)
EX_DY=(-3 -2 -2 -1 0 1 2 2 3 2 2 1 0 -1 -2 -2)
for ((er=1;er<=15;er++)); do
  for ((angle=0;angle<16;angle++)); do
    rad_x=$((EX_DX[angle]*er/2))
    rad_y=$((EX_DY[angle]*er/3))
    ex=$((MX+rad_x))
    # Screen shake when er > 10
    if ((er>10)); then ey=$((FIGHT_Y+2+rad_y+RANDOM%3-1))
    else ey=$((FIGHT_Y+2+rad_y)); fi
    ((ex>0 && ex<=COLS && ey>0 && ey<=LNS)) && {
      cur $ey $ex
      if ((er>10)); then out "${DM}${CL[$((RANDOM%7))]}.${RS}"
      else out "${BD}${CL[$((RANDOM%7))]}${EXP_CHARS[$((RANDOM%${#EXP_CHARS[@]}))]}${RS}"; fi
    }
  done
  sleep 0.025
done

# Shockwave ring expanding after explosion
for ((sw=16;sw<=24;sw+=2)); do
  for ((angle=0;angle<16;angle++)); do
    swx=$((MX+EX_DX[angle]*sw/3)); swy=$((FIGHT_Y+2+EX_DY[angle]*sw/4))
    ((swx>0 && swx<=COLS && swy>0 && swy<=LNS)) && {
      cur $swy $swx; out "${DM}${W}*${RS}"
    }
  done
  sleep 0.03
done

# Screen flash
sleep 0.1; clear; sleep 0.05
for ((gy=1;gy<=LNS;gy++)); do
  cur $gy 1; printf "%*s" "$COLS" "" | tr " " "#"
done
sleep 0.05; clear

# Result: "YOU MASTERED BOTH" with dramatic reveal
WIN1="WINNER:"
WIN1_X=$(( (COLS-${#WIN1})/2 ))
cur $((MY-3)) $WIN1_X
out "${BD}${W}${WIN1}${RS}"
sleep 0.4

WIN2="$UPPER"
WIN2_X=$(( (COLS-${#WIN2})/2 ))
cur $((MY-1)) $WIN2_X
for ((wi=0;wi<${#WIN2};wi++)); do
  out "${BD}${Y}${WIN2:$wi:1}${RS}"
  sleep 0.04
done
sleep 0.3

WIN3="( you mastered both. obviously. )"
WIN3_X=$(( (COLS-${#WIN3})/2 ))
cur $((MY+1)) $WIN3_X
for ((wi=0;wi<${#WIN3};wi++)); do
  out "${DM}${C}${WIN3:$wi:1}${RS}"
  sleep 0.02
done

# Victory sparkles
for ((vs=0;vs<30;vs++)); do
  vx=$((RANDOM%COLS+1)); vy=$((RANDOM%LNS+1))
  ((vy>=MY-4 && vy<=MY+3)) && continue
  cur $vy $vx; out "${BD}${CL[$((RANDOM%7))]}*${RS}"
  sleep 0.02
done
sleep 1.0; clear

# ═══════════════════════════════════════════════════
# STICK FIGURES IN CAP & GOWN DANCING
# ═══════════════════════════════════════════════════

# 4 stick figure dance frames (cap & gown, taller & more detailed)
# Each frame is 10 lines tall with stage
SF1=("   ___   " "   | |   " "   -+-   " "    O    " "   /|\\   " "  / | \\  " "    |    " "   / \\   " "  /   \\  " " _/     \\_")
SF2=("   ___   " "   | |   " "   -+-   " "    O    " "  \\|    " "   \\|    " "    |    " "   / \\   " "  /   \\  " " _/     \\_")
SF3=("   ___   " "   | |   " "   -+-   " "    O    " "   /|\\   " "  / | \\  " "    |    " "   _|_   " "  / | \\  " " _/ | \\_ ")
SF4=("   ___   " "   | |   " "   -+-   " "    O    " "    |/   " "    |/   " "    |    " "   / \\   " "  /   \\  " " _/     \\_")

# Place 5 figures across the screen
FIG_W=10
FIG_H=10
NFIGS=5
declare -a FIG_X
for ((fi=0;fi<NFIGS;fi++)); do
  FIG_X[$fi]=$(( (COLS/(NFIGS+1)) * (fi+1) - FIG_W/2 ))
done
FIG_Y=$(( MY - FIG_H/2 - 1 ))

# Draw stage/dance floor line
STAGE_Y=$((FIG_Y+FIG_H+1))

# "CLASS OF 2026" text setup
WMI="* * *  C L A S S   O F   2 0 2 6  * * *"
WMI_X=$(( (COLS-${#WMI})/2 ))
WMI_Y=$((STAGE_Y+2))

# Confetti characters and colors
CONF_CH=("*" "+" "." "o" "~")

# Dance loop: 48 frames with bouncing title, confetti, scrolling stage
declare -a CONF_X CONF_Y CONF_C
CONF_N=0
for ((df=0;df<48;df++)); do

  # --- Scrolling stage line (redraw each frame with +df offset) ---
  cur $STAGE_Y 1
  for ((sx=1;sx<=COLS;sx++)); do
    if (((sx+df)%3==0)); then out "${BD}${Y}=${RS}"; else out "${BD}${BO}-${RS}"; fi
  done

  # --- Bouncing "CLASS OF 2026" (toggle BD/normal every 6 frames) ---
  cur $WMI_Y $WMI_X
  printf "\033[K"
  if (( (df/6)%2==0 )); then
    out "${BD}${Y}${WMI}${RS}"
  else
    out "${Y}${WMI}${RS}"
  fi

  # --- Confetti: erase old particles ---
  for ((ci=0;ci<CONF_N;ci++)); do
    cur ${CONF_Y[$ci]} ${CONF_X[$ci]}
    out " "
  done
  CONF_N=0

  # --- Confetti: spawn 3 new particles in top third ---
  TOP_THIRD=$((ROWS/3))
  for ((ci=0;ci<3;ci++)); do
    cx=$((RANDOM%COLS+1))
    cy=$((RANDOM%TOP_THIRD+1))
    cc=${CL[$((RANDOM%7))]};
    ch=${CONF_CH[$((RANDOM%5))]}
    CONF_X[$CONF_N]=$cx
    CONF_Y[$CONF_N]=$cy
    CONF_C[$CONF_N]=$cc
    cur $cy $cx
    out "${cc}${ch}${RS}"
    ((CONF_N++))
  done

  # --- Dance figures ---
  frame=$((df%4))
  for ((fi=0;fi<NFIGS;fi++)); do
    ff=$(( (df+fi)%4 ))
    case $ff in
      0) CUR_F=("${SF1[@]}");;
      1) CUR_F=("${SF2[@]}");;
      2) CUR_F=("${SF3[@]}");;
      3) CUR_F=("${SF4[@]}");;
    esac
    fc=${CL[$(( fi%7 ))]}
    for ((sl=0;sl<FIG_H;sl++)); do
      cur $((FIG_Y+sl)) ${FIG_X[$fi]}
      out "          "
      cur $((FIG_Y+sl)) ${FIG_X[$fi]}
      if ((sl<3)); then
        out "${BD}${Y}${CUR_F[$sl]}${RS}"
      else
        out "${BD}${fc}${CUR_F[$sl]}${RS}"
      fi
    done
  done
  sleep 0.10
done

# Clean up remaining confetti
for ((ci=0;ci<CONF_N;ci++)); do
  cur ${CONF_Y[$ci]} ${CONF_X[$ci]}
  out " "
done
sleep 1.0; clear

# --- narrative beat ---
BEAT4="where it all began ..."
BEAT4_X=$(( (COLS-${#BEAT4})/2 ))
cur $MY $BEAT4_X
for ((bi=0;bi<${#BEAT4};bi++)); do
  out "${DM}${BO}${BEAT4:$bi:1}${RS}"; sleep 0.03
done
sleep 0.5; clear

# ═══════════════════════════════════════════════════
# PHASE 4: UT TOWER (ASCII art, drawn line by line in burnt orange)
# ═══════════════════════════════════════════════════
TOWER=(
"                  .+.                  "
"                 /|X|\\                 "
"                /_|X|_\\                "
"                | *** |                "
"               _|_____|_               "
"              |  _____  |              "
"              | |     | |              "
"              | | U T | |              "
"              | |  _  | |              "
"              | | |_| | |              "
"              | |_____| |              "
"         _____|_________|_____         "
"        |  ___|         |___  |        "
"        | |   | ||| ||| |   | |        "
"        | |   | ||| ||| |   | |        "
"        | |   | ||| ||| |   | |        "
"        | |   | ||| ||| |   | |        "
"        | |___|_________|___| |        "
"        |_____________________|        "
"        | | | | | | | | | | | |        "
"        | | | | | | | | | | | |        "
"        | | | | | | | | | | | |        "
"        |_|_|_|_|_|_|_|_|_|_|_|        "
"       /                       \\       "
"      /  ~  ~  ~  TEXAS  ~  ~  \\      "
"     /___________________________\\     "
"    |_____________________________|    "
)
TW_H=${#TOWER[@]}
TW_W=42
TW_X=$(( (COLS-TW_W)/2 ))
TW_Y=$(( (LNS-TW_H)/2 - 3 ))
((TW_Y<1)) && TW_Y=1

# Draw tower line by line with slight delay
for ((ln=0;ln<TW_H;ln++)); do
  cur $((TW_Y+ln)) $TW_X
  out "${BD}${BO}${TOWER[$ln]}${RS}"
  sleep 0.05
done

# Ambient stars above the tower
for ((as=0;as<18;as++)); do
  ax=$((RANDOM%COLS+1))
  ay=$((RANDOM%(TW_Y>2?TW_Y-1:1)+1))
  ((ay>0 && ay<TW_Y && ax>0 && ax<=COLS)) && {
    cur $ay $ax; out "${DM}${W}.${RS}"
  }
done

# Flash the star/beacon at top with glow halo
for ((fl=0;fl<8;fl++)); do
  cur $((TW_Y)) $((TW_X+18))
  if ((fl%3==0)); then out "${BD}${Y}.+.${RS}"
  elif ((fl%3==1)); then out "${BD}${W}*+*${RS}"
  else out "${BD}${BO}.+.${RS}"; fi
  # Glow halo: 3 dim dots near beacon
  for ((gh=0;gh<3;gh++)); do
    gx=$((TW_X+18+RANDOM%5-2))
    gy=$((TW_Y+RANDOM%3-1))
    ((gy>0 && gy<=LNS && gx>0 && gx<=COLS)) && {
      cur $gy $gx; out "${DM}${Y}·${RS}"
    }
  done
  sleep 0.12
done

# Light up the windows one by one
for ((wi=0;wi<6;wi++)); do
  wy=$((TW_Y+13+wi/2))
  wx=$((TW_X+14+(wi%2)*8))
  cur $wy $wx; out "${BD}${Y}|||${RS}"
  sleep 0.08
done

# Window flicker — 8 frames, each window 25% chance of dimming
for ((wf=0;wf<8;wf++)); do
  for ((wi=0;wi<6;wi++)); do
    wy=$((TW_Y+13+wi/2))
    wx=$((TW_X+14+(wi%2)*8))
    if ((RANDOM%4==0)); then
      cur $wy $wx; out "${DM}${Y}|||${RS}"
    else
      cur $wy $wx; out "${BD}${Y}|||${RS}"
    fi
  done
  sleep 0.08
done

# "THE UNIVERSITY OF TEXAS AT AUSTIN" text below tower
UT_TXT="THE UNIVERSITY OF TEXAS AT AUSTIN"
UT_X=$(( (COLS-${#UT_TXT})/2 ))
cur $((TW_Y+TW_H+1)) $UT_X
for ((ti=0;ti<${#UT_TXT};ti++)); do
  out "${BD}${BO}${UT_TXT:$ti:1}${RS}"
  sleep 0.015
done

# Add "Est. 1883" below
EST="Est. 1883"
EST_X=$(( (COLS-${#EST})/2 ))
cur $((TW_Y+TW_H+2)) $EST_X
out "${DM}${W}${EST}${RS}"
sleep 1.2; clear

# --- narrative beat ---
BEAT5="now ... the journey forward"
BEAT5_X=$(( (COLS-${#BEAT5})/2 ))
cur $MY $BEAT5_X
for ((bi=0;bi<${#BEAT5};bi++)); do
  out "${DM}${Y}${BEAT5:$bi:1}${RS}"; sleep 0.03
done
sleep 0.5; clear

# ═══════════════════════════════════════════════════
# PHASE 5: YELLOW BRICK ROAD — STORY ANIMATION
# Person walks out of tower, yellow brick road, cap toss,
# enters globe, rules the world
# ═══════════════════════════════════════════════════

# Scene 1: Person walks out of the UT Tower doors
# Mini tower at top, person appears at base
MINI_TOWER=(
"       |___|       "
"      |     |      "
"      | U T |      "
"   ___|_____|___   "
"  |  ||| ||| ||  | "
"  |  ||| ||| ||  | "
"  |_______________|"
"  |  | | | | | |  |"
"  |__|_|_|_|_|_|__|"
"  /               \\"
" /_________________\\"
)
MT_H=${#MINI_TOWER[@]}
MT_W=22
MT_X=$(( (COLS-MT_W)/2 ))
MT_Y=2

# Draw mini tower
for ((ln=0;ln<MT_H;ln++)); do
  cur $((MT_Y+ln)) $MT_X
  out "${BD}${BO}${MINI_TOWER[$ln]}${RS}"
  sleep 0.03
done

# Person in cap & gown walks out of door
DOOR_Y=$((MT_Y+MT_H))
DOOR_X=$((MT_X+MT_W/2))

# Grad figure frames (cap & gown)
GRAD1=(" [=] " "  O  " " /|\\ " " / \\ ")
GRAD2=(" [=] " "  O  " " /|\\ " "  |  " " / \\ ")

# Walk person out of the tower and down
for ((step=0;step<8;step++)); do
  py=$((DOOR_Y+step))
  px=$((DOOR_X-2))
  # Clear previous position
  ((step>0)) && {
    for ((ci=0;ci<4;ci++)); do
      cur $((py-1+ci-4)) $((px)); out "     "
    done
  }
  # Draw grad figure
  if ((step%2==0)); then
    for ((gi=0;gi<4;gi++)); do
      cur $((py+gi)) $px; out "${BD}${W}${GRAD1[$gi]}${RS}"
    done
  else
    for ((gi=0;gi<5;gi++)); do
      cur $((py+gi)) $px; out "${BD}${W}${GRAD2[$gi]}${RS}"
    done
  fi
  sleep 0.12
done
sleep 0.3

# Scene 2: Yellow brick road appears stretching to the right
ROAD_Y=$((DOOR_Y+10))
ROAD_START=$((DOOR_X-2))

# Draw the yellow brick road extending across screen
for ((bx=ROAD_START;bx<=COLS-2;bx+=3)); do
  cur $((ROAD_Y)) $bx
  out "${BD}${Y}[=]${RS}"
  cur $((ROAD_Y+1)) $bx
  out "${Y}[=]${RS}"
  # sparkle on the road
  ((RANDOM%3==0)) && {
    cur $((ROAD_Y-1)) $bx; out "${BD}${Y}*${RS}"
  }
  sleep 0.02
done

# Walk person along the road
for ((wx=ROAD_START;wx<=COLS-10;wx+=2)); do
  # Clear previous figure (but leave footprint)
  ((wx>ROAD_START)) && {
    for ((ci=0;ci<5;ci++)); do
      cur $((ROAD_Y-5+ci)) $((wx-2)); out "     "
    done
    # Leave dim footprint at previous position
    cur $((ROAD_Y-1)) $((wx-2)); out "${DM}${W}.${RS}"
  }
  # Draw walking grad
  py=$((ROAD_Y-4))
  if ((wx%4==0)); then
    cur $py $wx;     out "${BD}${W} [=] ${RS}"
    cur $((py+1)) $wx; out "${BD}${W}  O  ${RS}"
    cur $((py+2)) $wx; out "${BD}${W} /|\\ ${RS}"
    cur $((py+3)) $wx; out "${BD}${W} / \\ ${RS}"
  else
    cur $py $wx;     out "${BD}${W} [=] ${RS}"
    cur $((py+1)) $wx; out "${BD}${W}  O  ${RS}"
    cur $((py+2)) $wx; out "${BD}${W} /|\\ ${RS}"
    cur $((py+3)) $wx; out "${BD}${W}  |  ${RS}"
    cur $((py+4)) $wx; out "${BD}${W} / \\ ${RS}"
  fi
  sleep 0.03
done
sleep 0.3

# Scene 3: Cap toss! Person throws cap in the air
TOSS_X=$((COLS-10))
TOSS_PY=$((ROAD_Y-4))

# Clear the walking figure, draw standing figure without cap
for ((ci=0;ci<5;ci++)); do
  cur $((TOSS_PY+ci)) $TOSS_X; out "     "
done
cur $((TOSS_PY+1)) $TOSS_X; out "${BD}${W}  O  ${RS}"
cur $((TOSS_PY+2)) $TOSS_X; out "${BD}${W}\\|/${RS}"
cur $((TOSS_PY+3)) $TOSS_X; out "${BD}${W} / \\ ${RS}"

# Cap flies up with parabolic arc (horizontal drift)
CAP_SX=$TOSS_X
TOSS_TOTAL=$((TOSS_PY-2))
for ((cy=TOSS_PY;cy>=2;cy-=1)); do
  progress=$((TOSS_PY-cy))
  cap_cx=$((CAP_SX - progress/3))
  ((cap_cx<1)) && cap_cx=1
  # clear old cap
  old_cx=$((CAP_SX - (progress-1)/3))
  ((old_cx<1)) && old_cx=1
  cur $((cy+1)) $old_cx; out "     "
  cur $cy $cap_cx; out "${BD}${Y} [=] ${RS}"
  # sparkle trail
  cur $((cy+1)) $((cap_cx+RANDOM%3)); out "${Y}*${RS}"
  sleep 0.06
done

# Cap spins at the top
CAP_SPIN=("[=]" "-=-" "=_=" "-+-" "[=]")
for ((sp=0;sp<10;sp++)); do
  cur 2 $((TOSS_X)); out "${BD}${Y} ${CAP_SPIN[$((sp%5))]} ${RS}"
  sleep 0.08
done
sleep 0.3

# Scene 4: Clear everything, earth/globe takes over the screen
clear

# Draw a big ASCII earth globe
GLOBE=(
"            .--------.            "
"        .--~  ~   ~   ~--.        "
"      /~  .  ~ ~  . ~  ~  ~\\     "
"     / ~ .     ~   .  ~     \\    "
"    / ~   ____  ~ .   ~ ~   \\   "
"   | . ~ / .--\\ ~  ~ .   ~  |   "
"   |~ . | |  ~ ||  ~ . ~ ~  |   "
"   | .~ | |___||~  .   ~    |   "
"   |  ~ \\  ---/ .  ~ . ~   |   "
"    \\ ~  ----  ~   .  ~   /    "
"     \\ . ~ ~  . ~ .  ~   /     "
"      \\~  ~ .  ~  ~ .  ~/      "
"        ~--..  ~ ..--~          "
"            ~----~              "
)
GL_H=${#GLOBE[@]}
GL_W=34
GL_X=$(( (COLS-GL_W)/2 ))
GL_Y=$(( (LNS-GL_H)/2 - 3 ))
((GL_Y<1)) && GL_Y=1

# Globe expand animation — 5 rings, 24 evenly-spaced points per ring
EX_DX=(3 3 2 1 0 -1 -2 -3 -3 -3 -2 -1 0 1 2 3 3 3 2 -2 -3 -3 1 -1)
EX_DY=(0 -1 -1 -2 -2 -2 -1 -1 0 1 1 2 2 2 1 1 0 -1 -2 -2 -1 1 2 2)
for ((ez=1;ez<=5;ez++)); do
  clear
  for ((a=0;a<24;a++)); do
    cx=$((MX + EX_DX[a]*ez))
    cy=$((MY + EX_DY[a]*ez/2))
    ((cx>0 && cx<=COLS && cy>0 && cy<=LNS)) && {
      cur $cy $cx; out "${BD}${C}*${RS}"
    }
  done
  sleep 0.08
done
clear

# Draw the full globe
for ((ln=0;ln<GL_H;ln++)); do
  cur $((GL_Y+ln)) $GL_X
  out "${BD}${C}${GLOBE[$ln]}${RS}"
  sleep 0.04
done

# Add continents coloring - some lines in green
for ((ln=4;ln<11;ln++)); do
  cur $((GL_Y+ln)) $GL_X
  out "${BD}${G}${GLOBE[$ln]}${RS}"
  sleep 0.03
done
sleep 0.3

# Person standing on top of globe (ruler of the world)
RULER_Y=$((GL_Y-5))
RULER_X=$((GL_X+GL_W/2-3))
cur $((RULER_Y)) $RULER_X;   out "${BD}${Y}  \\|/${RS}"
cur $((RULER_Y+1)) $RULER_X; out "${BD}${W}  O  ${RS}"
cur $((RULER_Y+2)) $RULER_X; out "${BD}${W} /|\\ ${RS}"
cur $((RULER_Y+3)) $RULER_X; out "${BD}${W} / \\ ${RS}"
sleep 0.3

# Crown appears above head
for ((cf=0;cf<6;cf++)); do
  cur $((RULER_Y-1)) $((RULER_X))
  if ((cf%2==0)); then out "${BD}${Y} .-=+=-. ${RS}"; else out "${BD}${BO} .-=+=-. ${RS}"; fi
  sleep 0.12
done

# Zoom-in text: "RULES THE WORLD" in 3 frames (DM → normal → BD)
ZOOM_TXT="RULES THE WORLD"
ZOOM_X=$(( (COLS-${#ZOOM_TXT})/2 ))
ZOOM_Y=$((GL_Y+GL_H+2))
cur $ZOOM_Y $ZOOM_X; out "${DM}${Y}${ZOOM_TXT}${RS}"; sleep 0.15
cur $ZOOM_Y $ZOOM_X; out "${Y}${ZOOM_TXT}${RS}"; sleep 0.15
cur $ZOOM_Y $ZOOM_X; out "${BD}${Y}${ZOOM_TXT}${RS}"; sleep 0.15

# Full text: "$NAME RULES THE WORLD" typewriter
RULES_TXT="$UPPER RULES THE WORLD"
RULES_X=$(( (COLS-${#RULES_TXT})/2 ))
cur $ZOOM_Y $RULES_X; printf "\033[K"
for ((ri=0;ri<${#RULES_TXT};ri++)); do
  out "${BD}${Y}${RULES_TXT:$ri:1}${RS}"
  sleep 0.03
done
sleep 0.3

# Sparkle around the globe
for ((ss=0;ss<40;ss++)); do
  sx=$((GL_X-5+RANDOM%(GL_W+10)))
  sy=$((GL_Y-2+RANDOM%(GL_H+4)))
  ((sy>0 && sy<=LNS && sx>0 && sx<=COLS)) && {
    cur $sy $sx; out "${BD}${CL[$((RANDOM%7))]}*${RS}"
  }
  sleep 0.03
done

# Flash the title
for ((ft=0;ft<4;ft++)); do
  cur $((GL_Y+GL_H+2)) $RULES_X
  out "${BD}${CL[$((RANDOM%7))]}${RULES_TXT}${RS}"
  sleep 0.1
done
sleep 1.0; clear

# ═══════════════════════════════════════════════════
# PHASE 6: McCOMBS SCHOOL OF BUSINESS
# ═══════════════════════════════════════════════════
MCCOMBS=(
"  __  __      ____                _          "
" |  \\/  | ___/ ___|___  _ __ ___ | |__  ___  "
" | |\\/| |/ __| |   / _ \\| '_ \` _ \\| '_ \\/ __| "
" | |  | | (__| |__| (_) | | | | | | |_) \\__ \\ "
" |_|  |_|\\___|\\____\\___/|_| |_| |_|_.__/|___/ "
)
MC_H=${#MCCOMBS[@]}
MC_W=${#MCCOMBS[0]}
MC_X=$(( (COLS-MC_W)/2 ))
MC_Y=$(( MY - MC_H/2 - 3 ))
((MC_Y<1)) && MC_Y=1

# Draw McCombs text with typewriter effect
for ((ln=0;ln<MC_H;ln++)); do
  cur $((MC_Y+ln)) $MC_X
  out "${BD}${BO}${MCCOMBS[$ln]}${RS}"
  sleep 0.1
done

# Underline decoration
RULE_X=$MC_X
cur $((MC_Y+MC_H)) $RULE_X
for ((ri=0;ri<MC_W;ri++)); do out "${BO}═${RS}"; sleep 0.008; done
sleep 0.2

# Slide-in subtitle: "SCHOOL OF BUSINESS"
SUB="SCHOOL OF BUSINESS"
SUB_X=$(( (COLS-${#SUB})/2 ))
for ((sl=0;sl<6;sl++)); do
  sx=$((1 + sl*(SUB_X-1)/5))
  cur $((MC_Y+MC_H+1)) 1; printf "\033[K"
  cur $((MC_Y+MC_H+1)) $sx; out "${BD}${W}${SUB}${RS}"
  sleep 0.04
done
sleep 0.3

SUB2="MASTER OF SCIENCE IN MARKETING"
SUB2_X=$(( (COLS-${#SUB2})/2 ))
cur $((MC_Y+MC_H+3)) $SUB2_X
# typewriter effect for the degree name
for ((ti=0;ti<${#SUB2};ti++)); do
  out "${BD}${Y}${SUB2:$ti:1}${RS}"
  sleep 0.025
done
sleep 0.3

SUB3="Class of 2026"
SUB3_X=$(( (COLS-${#SUB3})/2 ))
cur $((MC_Y+MC_H+5)) $SUB3_X
out "${BD}${M}${SUB3}${RS}"
sleep 1.2; clear


# --- narrative beat ---
BEAT6="can you feel that? ... the herd is coming"
BEAT6_X=$(( (COLS-${#BEAT6})/2 ))
cur $MY $BEAT6_X
for ((bi=0;bi<${#BEAT6};bi++)); do
  out "${DM}${BO}${BEAT6:$bi:1}${RS}"; sleep 0.03
done
sleep 0.5; clear

# ═══════════════════════════════════════════════════
# PHASE 7: LONGHORN STAMPEDE HERD
# ═══════════════════════════════════════════════════

# --- Small longhorn (distant, running) ---
LH_SM1=(" /\\_/\\ " "( o.o )" "/ > ^ <\\" "   | |  " "  _/ \\_ ")
LH_SM2=(" /\\_/\\ " "( o.o )" "\\ > ^ </" "  | |   " " _/ \\_ ")
LH_SM_H=5; LH_SM_W=9

# --- Medium longhorn (detailed) ---
LH_MD1=(
"  ___/\\_________/\\___  "
" /    o    .    o    \\ "
"|       \\___/       |"
" \\_   / \\   / \\   _/ "
"   \\_/   \\_/   \\_/   "
)
LH_MD2=(
"  ___/\\_________/\\___  "
" /    o    .    o    \\ "
"|       \\___/       |"
" \\_  / \\   / \\   _/  "
"   \\/   \\_/   \\_/    "
)
LH_MD_H=5; LH_MD_W=24

# --- Large longhorn (closest, very detailed) ---
LH_LG=(
"  ____/\\___________________/\\____  "
" /      O                O      \\ "
"|          \\           /         |"
"|           \\  _____  /          |"
" \\           \\/     \\/           / "
"  \\________________________________/  "
"  |  / \\         / \\         / \\  | "
"  | /   \\       /   \\       /   \\ | "
"  |/     |     /     \\     |     \\| "
"   |_____|    |_______|    |_____| "
)
LH_LG_H=10; LH_LG_W=40

# Ground rumble effect before stampede
for ((rumble=0;rumble<8;rumble++)); do
  for ((rx=1;rx<=COLS;rx+=3)); do
    ry=$((LNS-RANDOM%2))
    cur $ry $rx; out "${DM}${BO}~${RS}"
  done
  sleep 0.06
done

# "STAMPEDE!" text flashes
STAMP_TXT=">>> STAMPEDE! <<<"
STAMP_X=$(( (COLS-${#STAMP_TXT})/2 ))
for ((sf=0;sf<4;sf++)); do
  cur $((MY)) $STAMP_X
  out "${BD}${CL[$((RANDOM%7))]}${STAMP_TXT}${RS}"
  sleep 0.08
done
clear

# Wave 1: Herd of 7 tiny longhorns stampeding
HERD_Y1=$((MY-8)); ((HERD_Y1<2)) && HERD_Y1=2
for ((lx=-10;lx<=COLS+2;lx+=3)); do
  for ((hi=0;hi<7;hi++)); do
    hy=$((HERD_Y1 + (hi%3)*6 - 2))
    hx=$((lx - hi*5))
    ((hx<1)) && continue
    # Alternate run frames
    if ((lx%6<3)); then frame_arr=("${LH_SM1[@]}"); else frame_arr=("${LH_SM2[@]}"); fi
    for ((ll=0;ll<LH_SM_H;ll++)); do
      ((hy+ll>0 && hy+ll<=LNS && hx>0)) && {
        cur $((hy+ll)) $hx; out "${DM}${BO}${frame_arr[$ll]}${RS}"
      }
    done
    # Clear trail — match small longhorn width (9 chars)
    ex=$((hx-3))
    ((ex>0)) && {
      for ((ll=0;ll<LH_SM_H;ll++)); do
        ((hy+ll>0 && hy+ll<=LNS)) && { cur $((hy+ll)) $ex; out "         "; }
      done
    }
    # Dust clouds behind
    ((RANDOM%3==0 && hx>3)) && {
      cur $((hy+LH_SM_H-1)) $((hx-2)); out "${DM}${W}*..${RS}"
    }
  done
  sleep 0.015
done
sleep 0.1

# Wave 2: 3 medium longhorns with dust trail
HERD_Y2=$((MY-3))
for ((lx=-24;lx<=COLS+2;lx+=2)); do
  for ((hi=0;hi<3;hi++)); do
    hy=$((HERD_Y2 + hi*7 - 4))
    hx=$((lx - hi*10))
    ((hx<1)) && continue
    if ((lx%4<2)); then
      for ((ll=0;ll<LH_MD_H;ll++)); do
        ((hy+ll>0 && hy+ll<=LNS && hx>0 && hx+LH_MD_W<=COLS)) && {
          cur $((hy+ll)) $hx; out "${BD}${BO}${LH_MD1[$ll]}${RS}"
        }
      done
    else
      for ((ll=0;ll<LH_MD_H;ll++)); do
        ((hy+ll>0 && hy+ll<=LNS && hx>0 && hx+LH_MD_W<=COLS)) && {
          cur $((hy+ll)) $hx; out "${BD}${BO}${LH_MD2[$ll]}${RS}"
        }
      done
    fi
    # Clear trail
    ex=$((hx-2))
    ((ex>0)) && {
      for ((ll=0;ll<LH_MD_H;ll++)); do
        ((hy+ll>0 && hy+ll<=LNS)) && { cur $((hy+ll)) $ex; out "  "; }
      done
    }
  done
  # Dust cloud particles
  for dd in 1 2 3 4 5 6; do
    dp=$((HERD_Y2+RANDOM%14)); dpp=$((lx-RANDOM%10-3))
    ((dpp>0 && dp>0 && dp<=LNS)) && { cur $dp $dpp; out "${DM}${W}*${RS}"; }
  done
  sleep 0.015
done
sleep 0.1

# Ground tremor before wave 3
for ((tremor=0;tremor<5;tremor++)); do
  jy=$((LNS - tremor%2))
  cur $jy 1
  for ((tx=1;tx<=COLS;tx++)); do
    if (((tx+tremor)%5==0)); then out "${DM}${BO}~${RS}"; else out "${DM}${W}.${RS}"; fi
  done
  sleep 0.06
  cur $jy 1; printf "\033[K"
done

# Wave 3: 1 HUGE longhorn charges across — screen shakes
HERD_Y3=$((MY - LH_LG_H/2))
for ((lx=-LH_LG_W;lx<=COLS+2;lx+=2)); do
  # Screen shake effect — offset the Y randomly
  shake=$((RANDOM%3-1))
  for ((ll=0;ll<LH_LG_H;ll++)); do
    dy=$((HERD_Y3+ll+shake))
    ((dy>0 && dy<=LNS && lx>0 && lx+LH_LG_W<=COLS)) && {
      cur $dy $lx; out "${BD}${BO}${LH_LG[$ll]}${RS}"
    }
    ex=$((lx-2))
    ((ex>0 && dy>0 && dy<=LNS)) && { cur $dy $ex; printf "\033[K"; }
  done
  # Intense dust cloud + ground crack behind (reduced dust)
  for dd in 1 2 3 4 5 6; do
    dp=$((HERD_Y3-3+RANDOM%(LH_LG_H+6)+shake)); dpp=$((lx-RANDOM%15-3))
    ((dpp>0 && dp>0 && dp<=LNS)) && {
      cur $dp $dpp
      out "${CL[$((RANDOM%7))]}${FW[$((RANDOM%${#FW[@]}))]}${RS}"
    }
  done
  sleep 0.01
done
sleep 0.15

# --- SCREEN BREAK ---
BREAK_Y=$MY
for ((bx=1;bx<=COLS;bx++)); do
  cur $BREAK_Y $bx
  bc=${CL[$((RANDOM%7))]}
  case $((RANDOM%6)) in
    0) out "${BD}${bc}/${RS}" ;;
    1) out "${BD}${bc}\\${RS}" ;;
    2) out "${BD}${bc}X${RS}" ;;
    3) out "${BD}${bc}#${RS}" ;;
    4) out "${BD}${bc}*${RS}" ;;
    5) out "${BD}${bc}=${RS}" ;;
  esac
done
sleep 0.08

# Screen flash + crack
for ((fl=0;fl<4;fl++)); do
  for ((bx=1;bx<=COLS;bx+=3)); do
    by=$((BREAK_Y+RANDOM%3-1))
    ((by>0 && by<=LNS)) && {
      cur $by $bx
      if ((fl%2==0)); then out "${BD}${W}###${RS}"; else out "${BD}${BO}><>${RS}"; fi
    }
  done
  sleep 0.03
done

# HOOK EM text appears in the crack — pulsing 6 flashes
HE_TXT="HOOK EM \\m/"
HE_X=$(( (COLS-${#HE_TXT})/2 ))
for ((hf=0;hf<6;hf++)); do
  cur $BREAK_Y $HE_X
  if ((hf%2==0)); then out "${BD}${BO}${HE_TXT}${RS}"
  else out "${BD}${Y}${HE_TXT}${RS}"; fi
  sleep 0.1
done
sleep 0.3; clear


# --- narrative beat ---
BEAT7="light up the sky"
BEAT7_X=$(( (COLS-${#BEAT7})/2 ))
cur $MY $BEAT7_X
for ((bi=0;bi<${#BEAT7};bi++)); do
  out "${BD}${Y}${BEAT7:$bi:1}${RS}"; sleep 0.04
done
sleep 0.4; clear

# ═══════════════════════════════════════════════════
# PHASE 8: FIREWORKS (12 bursts with trails and expanding rings)
# ═══════════════════════════════════════════════════
TRAIL_CHARS=("|" ":" "." " ")
for burst in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16; do
  cx=$((RANDOM%(COLS-20)+10)); cy=$((RANDOM%(LNS-12)+5))
  c1=${CL[$((RANDOM%7))]}; c2=${CL[$((RANDOM%7))]}
  # Even bursts skip trail for staggered overlap
  if ((burst%2==0)); then
    # Quick flash at launch point
    cur $LNS $cx; out "${BD}${c1}|${RS}"; sleep 0.02; cur $LNS $cx; out " "
  fi
  # Visible trail going UP with fading tail (odd bursts get full trail)
  if ((burst%2==1)); then
  for ((ty=LNS;ty>cy;ty-=1)); do
    cur $ty $cx; out "${BD}${c1}|${RS}"
    # Draw fading trail below
    for ((tt=1;tt<=3;tt++)); do
      ((ty+tt<=LNS)) && {
        cur $((ty+tt)) $cx; out "${DM}${c1}${TRAIL_CHARS[$((tt-1))]}${RS}"
      }
    done
    ((ty+4<=LNS)) && { cur $((ty+4)) $cx; out " "; }
    sleep 0.008
  done
  # Clear the trail
  for ((cl=cy;cl<=cy+4 && cl<=LNS;cl++)); do
    cur $cl $cx; out " "
  done
  fi
  # Expanding circular burst with 24 directions + gravity droop
  for r in 1 2 3 4 5 6 7 8 9 10 11 12; do
    fc=${CL[$((RANDOM%7))]}
    # 24 angles for smoother circle
    for ((a=0;a<24;a++)); do
      case $((a%24)) in
        0)  dx=0;  dy=-2;;  1)  dx=1;  dy=-2;;
        2)  dx=2;  dy=-2;;  3)  dx=2;  dy=-1;;
        4)  dx=3;  dy=-1;;  5)  dx=3;  dy=0;;
        6)  dx=3;  dy=1;;   7)  dx=2;  dy=1;;
        8)  dx=2;  dy=2;;   9)  dx=1;  dy=2;;
        10) dx=0;  dy=2;;   11) dx=-1; dy=2;;
        12) dx=-2; dy=2;;   13) dx=-2; dy=1;;
        14) dx=-3; dy=1;;   15) dx=-3; dy=0;;
        16) dx=-3; dy=-1;;  17) dx=-2; dy=-1;;
        18) dx=-2; dy=-2;;  19) dx=-1; dy=-2;;
        20) dx=1;  dy=0;;   21) dx=-1; dy=0;;
        22) dx=0;  dy=1;;   23) dx=0;  dy=-1;;
      esac
      # Gravity: particles droop downward (capped at 4)
      grav=$((r*r/20)); ((grav>4)) && grav=4
      px=$((cx+dx*r/2)); py=$((cy+dy*r/3+grav))
      ((px>0 && px<=COLS && py>0 && py<=LNS)) || continue
      cur $py $px; ch=${FW[$((RANDOM%${#FW[@]}))]}
      if ((r>9)); then out "${DM}${c2}.${RS}"
      elif ((r>6)); then out "${DM}${c1}${ch}${RS}"
      elif ((r>3)); then out "${c1}${ch}${RS}"
      else out "${BD}${fc}${ch}${RS}"; fi
    done
    sleep 0.02
  done
  # Crackle effect — 6 dim sparks near burst center
  sleep 0.15
  for ((ck=0;ck<6;ck++)); do
    ckx=$((cx+RANDOM%5-2))
    cky=$((cy+RANDOM%3-1))
    ((ckx>0 && ckx<=COLS && cky>0 && cky<=LNS)) && {
      cur $cky $ckx; out "${DM}${c1}·${RS}"
    }
  done
  sleep 0.08; ((burst%5==0)) && clear
done
sleep 0.2; clear


# --- narrative beat ---
BEAT8="this one is for you ..."
BEAT8_X=$(( (COLS-${#BEAT8})/2 ))
cur $MY $BEAT8_X
for ((bi=0;bi<${#BEAT8};bi++)); do
  out "${BD}${W}${BEAT8:$bi:1}${RS}"; sleep 0.04
done
sleep 0.5; clear

# ═══════════════════════════════════════════════════
# PHASE 9: NAME SCRAMBLE → REVEAL (block letters)
# ═══════════════════════════════════════════════════
# Use first name only for block letters (fits better)
FIRST=$(echo "$UPPER" | cut -d" " -f1)
FW2=0
for ((i=0;i<${#FIRST};i++)); do
  w=$(font_width "${FIRST:$i:1}"); FW2=$((FW2+w+2))
done
FX=$(( (COLS-FW2)/2 )); ((FX<1)) && FX=1

# scramble 50 frames - fast cycling for dramatic effect
for ((f=0;f<50;f++)); do
  fc=${CL[$((f%7))]}; cx=$FX
  for ((i=0;i<${#FIRST};i++)); do
    ch="${FIRST:$i:1}"
    draw_letter "$ch" $cx "scramble" "$fc"
    w=$(font_width "$ch"); cx=$((cx+w+2))
  done
  if ((f<20)); then sleep 0.02
  elif ((f<35)); then sleep 0.03
  else sleep 0.05; fi
done

# Drumroll before resolve
dr_y=$((SY+6))
for ((dr=0;dr<20;dr++)); do
  dx=$((RANDOM%COLS+1))
  cur $dr_y $dx; out "${BD}${W}|${RS}"
  sleep 0.02
  cur $dr_y $dx; out " "
done

# resolve left to right
for ((r=0;r<${#FIRST};r++)); do
  cx=$FX
  for ((i=0;i<${#FIRST};i++)); do
    ch="${FIRST:$i:1}"
    if ((i<=r)); then
      draw_letter "$ch" $cx "solid" "${CL[$((i%7))]}"
    else
      draw_letter "$ch" $cx "scramble" "${CL[$(((r+i)%7))]}"
    fi
    w=$(font_width "$ch"); cx=$((cx+w+2))
  done
  sleep 0.2
done

# Full name below block letters
FN_X=$(( (COLS-${#NAME})/2 ))
cur $((SY+6)) $FN_X
out "${BD}${W}${NAME}${RS}"
sleep 0.5

# ═══════════════════════════════════════════════════
# PHASE 10: CONFETTI RAIN
# ═══════════════════════════════════════════════════
NT=$((SY-1)); NB=$((SY+7))
CF=('*' '+' 'o' '~' '#' '=' '^' '!' '.' ':' '@' '%')
for ((f=0;f<150;f++)); do
  for p in 1 2 3 4 5 6 7 8 9 10 11 12; do
    px=$((RANDOM%COLS+1)); py=$((RANDOM%LNS+1))
    ((py>=NT && py<=NB)) && continue
    cur $py $px; out "${BD}${CL[$((RANDOM%7))]}${CF[$((RANDOM%${#CF[@]}))]}${RS}"
  done
  if ((f%3==0)); then
    cx=$FX
    for ((i=0;i<${#FIRST};i++)); do
      ch="${FIRST:$i:1}"
      draw_letter "$ch" $cx "solid" "${CL[$(((f/3+i*2)%7))]}"
      w=$(font_width "$ch"); cx=$((cx+w+2))
    done
  fi
  sleep 0.04
done

# ═══════════════════════════════════════════════════
# PHASE 10: GRADUATION CAP + TASSEL FLIP
# ═══════════════════════════════════════════════════
sleep 0.4; clear

CAP=(
"              ________________________              "
"            /                          \\            "
"          /                              \\          "
"   ______/                                \\______   "
"  /________________________________________________\\ "
"  \\________________________________________________/ "
"          |                          |               "
"          |                          |               "
"          |          ______          |               "
"          |         |  ##  |         |               "
"          |         | #### |         |               "
"          |         |__##__|         |               "
"          |            ##            |               "
"          |            ##            |               "
"          |           /##\\           |               "
"          |          / ## \\          |               "
"          |         /  ##  \\         |               "
"          |        / ####  \\        |               "
"          |_______/ ###### \\_______|               "
)
CAP_H=${#CAP[@]}
CAP_W=${#CAP[0]}
CAP_X=$(( (COLS-CAP_W)/2 ))
CAP_Y=$(( (LNS-CAP_H)/2 - 4 ))
((CAP_Y<1)) && CAP_Y=1

# Draw cap line by line
for ((ln=0;ln<CAP_H;ln++)); do
  cur $((CAP_Y+ln)) $CAP_X
  if ((ln<6)); then
    out "${BD}${BO}${CAP[$ln]}${RS}"
  else
    out "${BD}${Y}${CAP[$ln]}${RS}"
  fi
  sleep 0.06
done
sleep 0.3

# Tassel swing animation (6 frames, swings left to right)
TASSEL_X=$((CAP_X + CAP_W/2 + 10))
TASSEL_Y=$((CAP_Y + 4))
T1=("   |  " "   |  " "   |  " "   *  " "  /|  " " / |  " "/  |  ")
T2=("  |   " "  |   " "  |   " "  *   " "  |\\  " "  | \\ " "  |  \\")
T3=("  |   " "   |  " "   |  " "   *  " "  /|\\ " " / | \\" "/  |  \\")
T4=(" |    " " |    " " |    " " *    " "/|    " "| /   " "|/    ")
T5=("    | " "    | " "    | " "    * " "    |\\" "    | \\" "    |/")
T6=("  |   " "   |  " "   |  " "   *  " "  /|\\ " " / | \\" "/  |  \\")

for swing in 1 2 3; do
  # Brim shimmer on each swing
  if ((swing%2==1)); then brim_c="${BD}${BO}"; else brim_c="${BD}${Y}"; fi
  cur $((CAP_Y+3)) $CAP_X; out "${brim_c}${CAP[3]}${RS}"
  cur $((CAP_Y+4)) $CAP_X; out "${brim_c}${CAP[4]}${RS}"
  for frame in 0 1 2 3 4 5 2 1; do
    case $frame in
      0) TF=("${T1[@]}");;
      1) TF=("${T2[@]}");;
      2) TF=("${T3[@]}");;
      3) TF=("${T4[@]}");;
      4) TF=("${T5[@]}");;
      5) TF=("${T6[@]}");;
    esac
    for ((tl=0;tl<${#TF[@]};tl++)); do
      cur $((TASSEL_Y+tl)) $TASSEL_X
      out "       "
      cur $((TASSEL_Y+tl)) $TASSEL_X
      out "${BD}${BO}${TF[$tl]}${RS}"
    done
    # Tassel sparkles — 2 dim stars near tassel ball
    for ((ts=0;ts<2;ts++)); do
      tsx=$((TASSEL_X+RANDOM%5-1))
      tsy=$((TASSEL_Y+3+RANDOM%3))
      ((tsx>0 && tsx<=COLS && tsy>0 && tsy<=LNS)) && {
        cur $tsy $tsx; out "${DM}${Y}*${RS}"
      }
    done
    sleep 0.07
  done
done
sleep 0.5


# ═══════════════════════════════════════════════════
# PHASE 11: PERSONALIZED FLEX
# ═══════════════════════════════════════════════════

# Simple, elegant credential reveal
MSGS=(
  "$NAME"
  ""
  "MASTER OF SCIENCE"
  "CLASS OF 2026"
  ""
  "McCOMBS SCHOOL OF BUSINESS"
  "THE UNIVERSITY OF TEXAS AT AUSTIN"
)
MSG_Y=$((MY-5))

for ((mi=0;mi<${#MSGS[@]};mi++)); do
  msg="${MSGS[$mi]}"
  if [ -z "$msg" ]; then continue; fi
  msg_x=$(( (COLS-${#msg})/2 ))
  ((msg_x<1)) && msg_x=1
  cur $((MSG_Y+mi*2)) $msg_x
  if ((mi==0)); then mc="${BD}${W}"
  elif ((mi==2)); then mc="${BD}${Y}"
  elif ((mi==3)); then mc="${BD}${BO}"
  elif ((mi==5)); then mc="${BD}${BO}"
  else mc="${DM}${W}"; fi
  for ((ci=0;ci<${#msg};ci++)); do
    out "${mc}${msg:$ci:1}${RS}"
    sleep 0.02
  done
  sleep 0.3
done
sleep 0.3

# Decorative frame around credentials
frame_top=$((MSG_Y-1)); frame_bot=$((MSG_Y+14))
frame_left=$((MX-25)); frame_right=$((MX+25))
((frame_left<1)) && frame_left=1
((frame_right>COLS)) && frame_right=$COLS
# Top border
cur $frame_top $frame_left; out "${DM}${C}╭${RS}"
for ((fx=frame_left+1;fx<frame_right;fx++)); do out "${DM}${C}─${RS}"; sleep 0.008; done
out "${DM}${C}╮${RS}"
# Bottom border
cur $frame_bot $frame_left; out "${DM}${C}╰${RS}"
for ((fx=frame_left+1;fx<frame_right;fx++)); do out "${DM}${C}─${RS}"; done
out "${DM}${C}╯${RS}"
# Side borders
for ((fy=frame_top+1;fy<frame_bot;fy++)); do
  cur $fy $frame_left; out "${DM}${C}│${RS}"
  cur $fy $frame_right; out "${DM}${C}│${RS}"
done
# Star border scatter
for ((sb=0;sb<10;sb++)); do
  case $((sb%4)) in
    0) sx=$((frame_left+RANDOM%(frame_right-frame_left))); sy=$frame_top;;
    1) sx=$((frame_left+RANDOM%(frame_right-frame_left))); sy=$frame_bot;;
    2) sx=$frame_left; sy=$((frame_top+RANDOM%(frame_bot-frame_top)));;
    3) sx=$frame_right; sy=$((frame_top+RANDOM%(frame_bot-frame_top)));;
  esac
  ((sx>0 && sx<=COLS && sy>0 && sy<=LNS)) && {
    cur $sy $sx; out "${DM}${Y}*${RS}"
  }
done
sleep 1.0; clear



# ═══════════════════════════════════════════════════
# PHASE 12: "MASTER" BLOCK REVEAL
# ═══════════════════════════════════════════════════
clear

GRAD_MSG="MASTER"
GRAD_UPPER=$(echo "$GRAD_MSG" | tr '[:lower:]' '[:upper:]')
GW=0
for ((i=0;i<${#GRAD_UPPER};i++)); do
  w=$(font_width "${GRAD_UPPER:$i:1}"); GW=$((GW+w+2))
done
GX=$(( (COLS-GW)/2 )); ((GX<1)) && GX=1
GY=$(( LNS/2 - 6 ))

# Progressive slowdown scramble: 0.02 (0-7), 0.04 (8-13), 0.06 (14-19)
for ((f=0;f<20;f++)); do
  fc=${CL[$((f%7))]}; cx=$GX
  for ((i=0;i<${#GRAD_UPPER};i++)); do
    ch="${GRAD_UPPER:$i:1}"
    draw_letter_at "$ch" $cx $GY "scramble" "$fc"
    w=$(font_width "$ch"); cx=$((cx+w+2))
  done
  if ((f<8)); then sleep 0.02
  elif ((f<14)); then sleep 0.04
  else sleep 0.06; fi
done
# Resolve with white flash per letter
for ((r=0;r<${#GRAD_UPPER};r++)); do
  cx=$GX
  for ((i=0;i<${#GRAD_UPPER};i++)); do
    ch="${GRAD_UPPER:$i:1}"
    if ((i<=r)); then
      # White flash on the letter just resolved
      if ((i==r)); then
        draw_letter_at "$ch" $cx $GY "solid" "${BD}${W}"
        sleep 0.03
      fi
      draw_letter_at "$ch" $cx $GY "solid" "${CL[$((i%7))]}"
    else
      draw_letter_at "$ch" $cx $GY "scramble" "${CL[$(((r+i)%7))]}"
    fi
    w=$(font_width "$ch"); cx=$((cx+w+2))
  done
  sleep 0.12
done

# Horizontal rule separator
RULE_W=$((GW>40?40:GW))
RULE_RX=$(( (COLS-RULE_W)/2 ))
cur $((GY+6)) $RULE_RX
for ((ri=0;ri<RULE_W;ri++)); do out "${BO}═${RS}"; sleep 0.008; done

# Name below MASTER
sleep 0.3
NM_LINE="$NAME"
NM_X=$(( (COLS-${#NM_LINE})/2 ))
cur $((GY+7)) $NM_X
out "${BD}${W}${NM_LINE}${RS}"
sleep 0.2

# Degree line
DEG_LINE="M.S. Marketing"
DEG_X=$(( (COLS-${#DEG_LINE})/2 ))
cur $((GY+8)) $DEG_X
out "${BD}${Y}${DEG_LINE}${RS}"
sleep 0.3

# ═══════════════════════════════════════════════════
# PHASE 13: HOOK EM — LONGHORN + \m/
# ═══════════════════════════════════════════════════

# "HOOK EM" in block letters below congrats
HOOK_MSG="HOOK EM"
HW=0
for ((i=0;i<${#HOOK_MSG};i++)); do
  w=$(font_width "${HOOK_MSG:$i:1}"); HW=$((HW+w+2))
done
HX=$(( (COLS-HW)/2 )); ((HX<1)) && HX=1
HY=$((GY+9))

# Reveal HOOK EM — center-out
HOOK_LEN=${#HOOK_MSG}
HOOK_MID=$((HOOK_LEN/2))
for ((dist=0;dist<=HOOK_MID;dist++)); do
  cx=$HX
  for ((i=0;i<HOOK_LEN;i++)); do
    ch="${HOOK_MSG:$i:1}"
    diff=$((i-HOOK_MID)); ((diff<0)) && diff=$((-diff))
    if ((diff<=dist)); then
      draw_letter_at "$ch" $cx $HY "solid" "${BO}"
    else
      draw_letter_at "$ch" $cx $HY "scramble" "${CL[$(((dist+i)%7))]}"
    fi
    w=$(font_width "$ch"); cx=$((cx+w+2))
  done
  sleep 0.04
done

# Longhorn ASCII art
HORN_Y=$((HY+7))
HORN=(
"    \\m/    "
"   _/ \\_   "
"  / . . \\  "
"  \\_____/  "
)
HORN_W=${#HORN[0]}
HORN_X=$(( (COLS-HORN_W)/2 ))
for ((hl=0;hl<${#HORN[@]};hl++)); do
  cur $((HORN_Y+hl)) $HORN_X
  out "${BD}${BO}${HORN[$hl]}${RS}"
  sleep 0.08
done

# Longhorn flash — 6 frames alternating BD+BO / BD+Y
for ((lf=0;lf<6;lf++)); do
  for ((hl=0;hl<${#HORN[@]};hl++)); do
    cur $((HORN_Y+hl)) $HORN_X
    if ((lf%2==0)); then out "${BD}${BO}${HORN[$hl]}${RS}"
    else out "${BD}${Y}${HORN[$hl]}${RS}"; fi
  done
  sleep 0.12
done

# Scattered \m/ symbols around longhorn
for ((sm=0;sm<8;sm++)); do
  smx=$((HORN_X-10+RANDOM%(HORN_W+20)))
  smy=$((HORN_Y-3+RANDOM%(${#HORN[@]}+6)))
  ((smx>0 && smx<=COLS-3 && smy>0 && smy<=LNS)) && {
    cur $smy $smx; out "${DM}${Y}\\m/${RS}"
  }
done
sleep 0.5

# ═══════════════════════════════════════════════════
# PHASE 14: FINAL FIREWORKS + COLOR CYCLING
# ═══════════════════════════════════════════════════
for ((burst=0;burst<40;burst++)); do
  for p in 1 2 3 4 5 6 7 8 9 10 11 12 13 14; do
    px=$((RANDOM%COLS+1)); py=$((RANDOM%LNS+1))
    ((py>=GY && py<=HORN_Y+5 && px>=GX-2 && px<=GX+GW+2)) && continue
    cur $py $px; out "${CL[$((RANDOM%7))]}${FW[$((RANDOM%${#FW[@]}))]}${RS}"
  done
  # cycle congrats + hook em colors — every 2 frames, wave formula
  if ((burst%2==0)); then
    cx=$GX
    for ((i=0;i<${#GRAD_UPPER};i++)); do
      ch="${GRAD_UPPER:$i:1}"
      draw_letter_at "$ch" $cx $GY "solid" "${CL[$(((burst/2+i*2)%7))]}"
      w=$(font_width "$ch"); cx=$((cx+w+2))
    done
    cx=$HX
    for ((i=0;i<${#HOOK_MSG};i++)); do
      ch="${HOOK_MSG:$i:1}"
      draw_letter_at "$ch" $cx $HY "solid" "${CL[$(((burst/2+i*2+3)%7))]}"
      w=$(font_width "$ch"); cx=$((cx+w+2))
    done
  fi
  sleep 0.1
done

# ═══════════════════════════════════════════════════
# PHASE 15: SCREEN CRACK + CHAOS FINALE
# ═══════════════════════════════════════════════════
# Shatter simulation — 3 frames of random block chars at center
SHATTER_CH=("▓" "▒" "░" "█" "#" "%" "&")
for ((sh=0;sh<3;sh++)); do
  for ((sc=0;sc<15;sc++)); do
    shx=$((MX+RANDOM%11-5))
    shy=$((MY+RANDOM%7-3))
    ((shx>0 && shx<=COLS && shy>0 && shy<=LNS)) && {
      cur $shy $shx; out "${BD}${CL[$((RANDOM%7))]}${SHATTER_CH[$((RANDOM%7))]}${RS}"
    }
  done
  sleep 0.04
done

# Screen "cracks" radiate from center
crack_chars=("/" "\\" "|" "-" "+" "X" "*")
for ((cr=1;cr<=25;cr++)); do
  for angle in 0 1 2 3 4 5 6 7; do
    case $angle in
      0) cdx=0;  cdy=-1;;
      1) cdx=1;  cdy=-1;;
      2) cdx=2;  cdy=0;;
      3) cdx=1;  cdy=1;;
      4) cdx=0;  cdy=1;;
      5) cdx=-1; cdy=1;;
      6) cdx=-2; cdy=0;;
      7) cdx=-1; cdy=-1;;
    esac
    cpx=$((MX + cdx*cr + RANDOM%3-1))
    cpy=$((MY + cdy*cr))
    ((cpx>0 && cpx<=COLS && cpy>0 && cpy<=LNS)) && {
      cur $cpy $cpx
      out "${BD}${CL[$((RANDOM%7))]}${crack_chars[$((RANDOM%${#crack_chars[@]}))]}${RS}"
    }
  done
  sleep 0.04
done
sleep 0.3

# Rapid color flash grand finale
for ((ff=0;ff<8;ff++)); do
  fc=${CL[$((ff%7))]}
  cx=$GX
  for ((i=0;i<${#GRAD_UPPER};i++)); do
    ch="${GRAD_UPPER:$i:1}"
    draw_letter_at "$ch" $cx $GY "solid" "$fc"
    w=$(font_width "$ch"); cx=$((cx+w+2))
  done
  cx=$HX
  for ((i=0;i<${#HOOK_MSG};i++)); do
    ch="${HOOK_MSG:$i:1}"
    draw_letter_at "$ch" $cx $HY "solid" "$fc"
    w=$(font_width "$ch"); cx=$((cx+w+2))
  done
  sleep 0.06
done

# Final burst — fill screen with confetti in 4 cascading batches
for ((batch=0;batch<4;batch++)); do
  for ((fb=0;fb<100;fb++)); do
    px=$((RANDOM%COLS+1)); py=$((RANDOM%LNS+1))
    cur $py $px; out "${BD}${CL[$((RANDOM%7))]}${CF[$((RANDOM%${#CF[@]}))]}${RS}"
  done
  sleep 0.05
done
sleep 0.8

# ═══════════════════════════════════════════════════
# PHASE FINAL: CLOSING MESSAGE
# ═══════════════════════════════════════════════════
clear

# Elegant final screen — dynamic box width
BOX_W=$((COLS>60 ? 50 : COLS-10))
((BOX_W<30)) && BOX_W=30
# Build box lines dynamically
BOX_TOP="╔"; for ((bwi=0;bwi<BOX_W-2;bwi++)); do BOX_TOP+="═"; done; BOX_TOP+="╗"
BOX_EMPTY="║"; for ((bwi=0;bwi<BOX_W-2;bwi++)); do BOX_EMPTY+=" "; done; BOX_EMPTY+="║"
BOX_BOT="╚"; for ((bwi=0;bwi<BOX_W-2;bwi++)); do BOX_BOT+="═"; done; BOX_BOT+="╝"
# Center text within box
MSG1="THE WORLD IS YOURS NOW."
MSG2="GO GET IT."
PAD1=$(( (BOX_W-2-${#MSG1})/2 ))
PAD2=$(( (BOX_W-2-${#MSG2})/2 ))
BOX_MSG1="║"; for ((p=0;p<PAD1;p++)); do BOX_MSG1+=" "; done; BOX_MSG1+="${MSG1}"
rem1=$((BOX_W-2-PAD1-${#MSG1})); for ((p=0;p<rem1;p++)); do BOX_MSG1+=" "; done; BOX_MSG1+="║"
BOX_MSG2="║"; for ((p=0;p<PAD2;p++)); do BOX_MSG2+=" "; done; BOX_MSG2+="${MSG2}"
rem2=$((BOX_W-2-PAD2-${#MSG2})); for ((p=0;p<rem2;p++)); do BOX_MSG2+=" "; done; BOX_MSG2+="║"

FINAL_LINES=("$BOX_TOP" "$BOX_EMPTY" "$BOX_MSG1" "$BOX_EMPTY" "$BOX_MSG2" "$BOX_EMPTY" "$BOX_BOT")
FL_H=${#FINAL_LINES[@]}
FL_W=$BOX_W
FL_X=$(( (COLS-FL_W)/2 ))
FL_Y=$(( MY - FL_H/2 - 3 ))

# Name first, big and centered
FIN_NAME="$UPPER"
FIN_NX=$(( (COLS-${#FIN_NAME})/2 ))
cur $((FL_Y-3)) $FIN_NX
for ((fi=0;fi<${#FIN_NAME};fi++)); do
  out "${BD}${BO}${FIN_NAME:$fi:1}${RS}"
  sleep 0.04
done
sleep 0.3

# Draw the box
for ((fl=0;fl<FL_H;fl++)); do
  cur $((FL_Y+fl)) $FL_X
  if ((fl==2 || fl==4)); then
    out "${BD}${Y}${FINAL_LINES[$fl]}${RS}"
  else
    out "${DM}${W}${FINAL_LINES[$fl]}${RS}"
  fi
  sleep 0.08
done
sleep 0.4

# Degree and school below
FIN_DEG="M.S. Marketing  |  McCombs  |  Class of 2026"
FIN_DX=$(( (COLS-${#FIN_DEG})/2 ))
cur $((FL_Y+FL_H+2)) $FIN_DX
for ((fi=0;fi<${#FIN_DEG};fi++)); do
  out "${DM}${W}${FIN_DEG:$fi:1}${RS}"
  sleep 0.015
done
sleep 0.5

# Gentle sparkle border
for ((ss=0;ss<60;ss++)); do
  sx=$((RANDOM%COLS+1)); sy=$((RANDOM%LNS+1))
  ((sy>=FL_Y-2 && sy<=FL_Y+FL_H+2)) && continue
  cur $sy $sx; out "${DM}${CL[$((RANDOM%7))]}*${RS}"
  sleep 0.02
done

# Hook em sign-off
sleep 0.5
HE_FINAL="\\m/ HOOK EM \\m/"
HE_FX=$(( (COLS-${#HE_FINAL})/2 ))
cur $((FL_Y+FL_H+5)) $HE_FX
out "${BD}${BO}${HE_FINAL}${RS}"

# Breathing border — 3 cycles
for ((breath=0;breath<3;breath++)); do
  # Dim border
  cur $FL_Y $FL_X; out "${DM}${W}${FINAL_LINES[0]}${RS}"
  cur $((FL_Y+FL_H-1)) $FL_X; out "${DM}${W}${FINAL_LINES[$((FL_H-1))]}${RS}"
  sleep 0.8
  # Bright border
  cur $FL_Y $FL_X; out "${BD}${W}${FINAL_LINES[0]}${RS}"
  cur $((FL_Y+FL_H-1)) $FL_X; out "${BD}${W}${FINAL_LINES[$((FL_H-1))]}${RS}"
  sleep 0.8
done
cur $LNS 1; printf "\n"
tput cnorm; tput sgr0
PARTY