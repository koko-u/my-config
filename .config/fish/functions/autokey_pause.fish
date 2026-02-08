function autokey_pause --description 'Pause AutoKey'
    set -l paused 0
    for name in autokey-gtk autokey-qt
        if pgrep -x $name >/dev/null
            pkill -STOP $name
            echo "Paused $name"
            set paused 1
        end
    end

    if test $paused -eq 0
        echo "No AutoKey process found."
    end
end
