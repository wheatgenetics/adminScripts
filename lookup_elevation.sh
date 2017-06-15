find ~/htp_images/uas/ -maxdepth 1 -name "*.tar" | xargs -I{} tar --wildcards -xvf {} *Drone*
find -name "Drone*.txt" | xargs -I{} grep "Flight elevation" {} /dev/null
find -name "Drone*.txt" | xargs -I{} grep -H  "Flight elevation" {} 
