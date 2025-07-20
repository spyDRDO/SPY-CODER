# ========== COLOR CODES ==========
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
PURPLE='\033[1;35m'
NC='\033[0m'

# ========== LOGIN SYSTEM ==========
if [ -z "$JARVIS_LOGGED_IN" ]; then
  clear
  echo -e "${CYAN}"
  echo "╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮"
  echo "┃       🔐  LOGIN REQUIRED            ┃"
  echo "╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯"
  echo

  read -p "👤 Username: " username
  read -sp "🔑 Password: " password
  echo

  if [[ $username == "king" && $password == "12345" ]]; then
    echo -e "${GREEN}✔ Login Successful, Sir!${RESET}"
    espeak "Login Successful Sir"
    export JARVIS_LOGGED_IN=true
    sleep 1
  else
    echo -e "${RED}✖ Incorrect credentials. Try again.${RESET}"
    espeak "Wrong password Sir"
    sleep 2
    exit
  fi
fi

# ========== BANNER ==========
clear
echo -e "${GREEN}"
echo "~~|~    /\\    |~~\\  |    |  ~|~  /~~\\"
echo "  |    /__\\   |__/   \\  /    |   \`--."
echo "\\_|   /    \\  |  \\    \\/    _|_  \\__/"
echo -e "${NC}"

# ========== DATE / TIME / GREETING ==========
HOUR=$(date +"%H")
TIME_STR=$(date +"%I:%M %p")
DATE_STR=$(date +"%A, %d %B %Y")

if [ "$HOUR" -ge 4 ] && [ "$HOUR" -lt 12 ]; then
  GREET="Good Morning"
elif [ "$HOUR" -ge 12 ] && [ "$HOUR" -lt 17 ]; then
  GREET="Good Afternoon"
elif [ "$HOUR" -ge 17 ] && [ "$HOUR" -lt 21 ]; then
  GREET="Good Evening"
else
  GREET="Good Night"
fi

echo -e "${YELLOW}Welcome back, Mehboob Sir"
echo -e "${BLUE}📅 Date: ${DATE_STR}"
echo -e "${GREEN}⏰ Time: ${TIME_STR}"
echo -e "${CYAN}🧠 $GREET, Mehboob!${NC}"
espeak "Welcome back, Mehboob sir. $GREET"

# ========== PROMPT STYLE ==========
parse_git_branch() {
  git branch 2>/dev/null | grep '*' | sed 's/* //'
}
export PS1="\[${PURPLE}\]╭─[\[${CYAN}\]MK\[${PURPLE}\]]─(\[${GREEN}\]\w\[${PURPLE}\])[\[${YELLOW}\]\A\[${PURPLE}\]]\[${BLUE}\]> "

# ========== APP LAUNCHER ==========
function open() {
  case "$1" in
    instagram) am start -a android.intent.action.VIEW -d https://instagram.com && espeak "Opening Instagram";;
    youtube) am start -a android.intent.action.VIEW -d https://youtube.com && espeak "Opening YouTube";;
    whatsapp) am start -a android.intent.action.VIEW -d https://whatsapp.com && espeak "Opening WhatsApp";;
    facebook) am start -a android.intent.action.VIEW -d https://facebook.com && espeak "Opening Facebook";;
    chrome) am start -a android.intent.action.VIEW -d https://google.com && espeak "Opening Chrome";;
    settings) am start -a android.settings.SETTINGS && espeak "Opening Settings";;
    gallery) am start -a android.intent.action.VIEW -d file:///sdcard/DCIM/Camera/ && espeak "Opening Gallery";;
    contacts) am start -a android.intent.action.VIEW -d content://contacts/people/ && espeak "Opening Contacts";;
    camera) am start -a android.media.action.IMAGE_CAPTURE && espeak "Opening Camera";;
    *) echo -e "${RED}⚠️ App '$1' not found.${NC}"; espeak "App $1 not found";;
  esac
}

# ========== VOICE ON COMMAND ==========
smart_jarvis_command() {
  case "$1" in
    ls) espeak "Listing files and folders" ;;
    cd) espeak "Changing directory" ;;
    mkdir) espeak "Creating a new folder" ;;
    nano) espeak "Closeing the nano editor" ;;
    clear) espeak "Clearing the screen" ;;
    rm) espeak "Deleting file or folder" ;;
    touch) espeak "Creating a new file" ;;
    figlet) espeak "Generating styled text" ;;
    ping) espeak "Pinging the network" ;;
    curl) espeak "Fetching from the internet" ;;
    apt|pkg) espeak "Managing packages" ;;
    open) ;;  # handled separately
    *) ;;
  esac
}
PROMPT_COMMAND='LAST_CMD=$(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//"); smart_jarvis_command "$(echo $LAST_CMD | cut -d" " -f1)"'

# ========== WRONG COMMAND FEEDBACK ==========
command_not_found_handle() {
  echo -e "${RED}❌ '$1' is not a valid command.${NC}"
  espeak "Sir, the command $1 is not valid."
}


# === BACKGROUND SCRIPTS ===
[ -f ~/jarvis_reminder.sh ] && bash ~/jarvis_reminder.sh >/dev/null 2>&1 &
[ -f ~/.jarvis_battery.sh ] && pgrep -f jarvis_battery.sh >/dev/null || nohup bash ~/.jarvis_battery.sh >/dev/null 2>&1 &

