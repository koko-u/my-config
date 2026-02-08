function __ak_candidates --description 'AutoKey process name candidates'
    echo autokey-gtk autokey-qt
end

function __ak_running --description 'Return running AutoKey process names'
    set -l result
    for n in (__ak_candidates)
        if pgrep -x $n >/dev/null
            set result $result $n
        end
    end
    printf "%s\n" $result
end

function autokey_toggle --description 'Toggle AutoKey pause/resume or start it'
    set -l running (__ak_running)

    if test (count $running) -gt 0
        # どちらか1つで状態判定（gtk/qt 両方走っていても挙動は同じ）
        set -l probe $running[1]
        set -l states (ps -o stat= -C $probe 2>/dev/null)

        if string match -q "*T*" $states
            # 停止中（T=stopped）→ 再開
            for n in $running
                pkill -CONT $n
            end
            echo "Resumed AutoKey: $running"
        else
            # 動作中 → 一時停止
            for n in $running
                pkill -STOP $n
            end
            echo "Paused AutoKey: $running"
        end
    else
        # プロセスが居ない → 起動（どちらか見つかった方）
        if type -q autokey-gtk
            nohup autokey-gtk >/dev/null 2>&1 &
            disown
            echo "Started autokey-gtk"
        else if type -q autokey-qt
            nohup autokey-qt >/dev/null 2>&1 &
            disown
            echo "Started autokey-qt"
        else
            echo "AutoKey not found (autokey-gtk/qt)" 1>&2
            return 1
        end
    end
end
