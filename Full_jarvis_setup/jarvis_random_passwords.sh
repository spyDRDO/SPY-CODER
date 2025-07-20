  GNU nano 8.5    jarvis_random_passwords.sh
#!/bin/bash

clear
echo -e "\e[1;36m[🎲] Generating 6-digit random password n>
espeak "Sir, starting randomized password number generatio>

# Use shuf to generate random 6-digit numbers without repe>
shuf -i 000000-999999 | while read num
do
    printf "\e[1;32mPassword ➤ %06d\e[0m\n" "$num"
    sleep 0.01
done

echo -e "\e[1;34m[✅] Randomized password list completed!\>
espeak "Sir, all password numbers randomized and displayed"
