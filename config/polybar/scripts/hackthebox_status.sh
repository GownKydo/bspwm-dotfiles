IFACE=$(ip addr | grep "tun0" | awk '{print $2}' | head -1 | tr -d ':')
 
if [ "$IFACE" = "tun0" ]; then
    echo "%{F#1bbf3e}  %{F#1bbf3e}$(ip addr | grep "tun0" | tail -1 | awk '{print $2}' | sed 's/\/.*//')%{u-}"
else
    echo "%{F#1bbf3e} %{u-} Disconnected"
fi
