  GNU nano 8.5        jarvis_reminder.sh
#!/data/data/com.termux/files/usr/bin/bash

LAST_ALERT=""

while true; do
  TIME_NOW=$(date +"%H:%M")
  HOUR=$(date +"%H")
  MIN=$(date +"%M")

  # REMINDERS in Hindi voice
  declare -A REMINDERS
  REMINDERS["04:30"]="सर, सुबह हो गई है। कृपया उठ जाइए।"
  REMINDERS["08:00"]="सर, नाश्ता करने का समय हो गया है।"
  REMINDERS["12:00"]="सर, दोपहर के खाने का समय हो गया है।"
  REMINDERS["16:30"]="सर, ट्यूशन जाने का समय हो गया है।"
  REMINDERS["16:50"]="सर, ट्यूशन के लिए देर हो रही है। कृपया जल्द>
  REMINDERS["21:00"]="सर, रात के खाने का समय हो गया है।"
  REMINDERS["23:00"]="सर, सोने का समय हो गया है। शुभ रात्रि।"

  if [[ "${REMINDERS[$TIME_NOW]}" != "" && "$LAST_ALERT" !>
    espeak -v hi -s 150 -p 60 -a 150 "${REMINDERS[$TIME_NO>
    LAST_ALERT="$TIME_NOW"
  fi

  sleep 30
done


