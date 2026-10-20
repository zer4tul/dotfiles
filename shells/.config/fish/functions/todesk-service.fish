function todesk-service
    set session "todesk_service"
    
    if tmux has-session -t $session 2>/dev/null
        tmux attach -t $session
    else
        tmux new-session -s $session "/Applications/ToDesk.app/Contents/MacOS/ToDesk_Service"
    end
end
