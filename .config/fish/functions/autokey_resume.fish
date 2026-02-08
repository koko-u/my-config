function autokey_resume --description 'Resume AutoKey'
    set -l resumed 0
    for name in autokey-gtk autokey-qt
        if pgrep -x $name >/dev/null
            pkill -CONT $name
            echo "Resumed $name"
            set resumed 1
        end
    end

    if test $resumed -eq 0
        echo "No AutoKey process found."
    end
end
