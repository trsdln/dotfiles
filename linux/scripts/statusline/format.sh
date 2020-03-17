#!/bin/sh

padding=" "

format_wm_info() {
  num_mon=$(bspc query -M | wc -l)
  wm=""
  IFS=':'
  set -- ${line#?}
  while [ $# -gt 0 ] ; do
    item=$1
    name=${item#?}
    case $item in
      [mM]*)
        [ $num_mon -lt 2 ] && shift && continue
        case $item in
          m*)
            # monitor
            FG=$COLOR_MONITOR_FG
            BG=$COLOR_MONITOR_BG
            ;;
          M*)
            # focused monitor
            FG=$COLOR_FOCUSED_MONITOR_FG
            BG=$COLOR_FOCUSED_MONITOR_BG
            ;;
        esac
        wm="${wm}%{F${FG}}%{B${BG}}%{A:bspc monitor -f ${name}:} ${name} %{A}%{B-}%{F-}"
        ;;
      [fFoOuU]*)
        case $item in
          f*)
            # free desktop
            FG=$COLOR_FREE_FG
            BG=$COLOR_FREE_BG
            ;;
          F*)
            # focused free desktop
            FG=$COLOR_FOCUSED_FREE_FG
            BG=$COLOR_FOCUSED_FREE_BG
            ;;
          o*)
            # occupied desktop
            FG=$COLOR_OCCUPIED_FG
            BG=$COLOR_OCCUPIED_BG
            ;;
          O*)
            # focused occupied desktop
            FG=$COLOR_FOCUSED_OCCUPIED_FG
            BG=$COLOR_FOCUSED_OCCUPIED_BG
            ;;
          u*)
            # urgent desktop
            FG=$COLOR_URGENT_FG
            BG=$COLOR_URGENT_BG
            ;;
          U*)
            # focused urgent desktop
            FG=$COLOR_FOCUSED_URGENT_FG
            BG=$COLOR_FOCUSED_URGENT_BG
            ;;
        esac
        wm="${wm}%{F${FG}}%{B${BG}}%{A:bspc desktop -f ${name}:} ${padding}${name}${padding} %{A}%{B-}%{F-}"
        ;;
      [TG]*)
        # layout, state and flags
        wm="${wm}%{F$COLOR_STATE_FG}%{B$COLOR_STATE_BG} ${name} %{B-}%{F-}"
        ;;
    esac
    shift
  done
}

format_panel_info() {
  while read -r line ; do
    case $line in
      C*)
        # clock output
        sys="%{F$COLOR_SYS_FG}%{B$COLOR_SYS_BG} ${line#?} %{B-}%{F-}"
        ;;
      T*)
        # xtitle
        title="%{F$COLOR_TITLE_FG}%{B$COLOR_TITLE_BG} ${line#?} %{B-}%{F-}"
        ;;
      W*)
        # bspwm's state
        format_wm_info
        ;;
    esac
    complete_info="%{l}${title}%{c}${wm}%{r}${date}${sys}"

    if [ $num_mon -lt 2 ]; then
      printf "%s\n" "%{Sl}${complete_info}"
    else
      # show status line at both monitors if available
      printf "%s\n" "%{Sl}${complete_info}%{Sf}${complete_info}"
    fi
  done
}
