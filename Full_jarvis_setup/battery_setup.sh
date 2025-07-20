#!/data/data/com.termux/files/usr/bin/bash

prev_status=""
prev_level=""
was_charging="no"
warned_early_unplug="no"

while true; do
  battery=$(termux-battery-status)
  level=$(echo "$battery" | jq '.percentage')
  status=$(echo "$battery" | jq -r '.status')

  # 🔌 जब चार्जर लगाएं
  if [[ "$status" == "CHARGING" && "$prev_status" != "CHAR>
    termux-tts-speak -l hi "धन्यवाद सर, चार्जिंग शुरू हो गई है"
    prev_status="CHARGING"
    was_charging="yes"
    warned_early_unplug="no"
  fi

  # 🔋 जब बैटरी पूरी चार्ज हो जाए
  if [[ "$level" -ge 100 && "$status" == "FULL" ]]; then
    termux-tts-speak -l hi "सर, बैटरी पूरी चार्ज हो गई है"
    sleep 300  # 5 मिनट तक चुप रहे
  fi

  # ⚠️ बैटरी लो हो जाए
  if [[ "$level" -le 20 && "$status" == "DISCHARGING" && ">
    termux-tts-speak -l hi "सर, फोन को चार्ज पर लगा दीजिए, >
    prev_level="LOW"
  fi

  # 🔌 चार्जिंग के पहले ही चार्जर निकाल दिया गया
  if [[ "$status" == "DISCHARGING" && "$was_charging" == ">
    termux-tts-speak -l hi "सर, चार्जिंग पूरी नहीं हुई थी, फिर >
    warned_early_unplug="yes"
    was_charging="no"
  fi

  # 🔋 जब unplug हो तो previous state reset करो
  if [[ "$status" == "DISCHARGING" && "$prev_status" != "D>
    prev_status="DISCHARGING"
    prev_level=""
  fi

  sleep 30
done
