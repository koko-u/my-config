# -*- coding: utf-8 -*-
# Simple script to check AutoKey's window filter behavior

win = window.get_active_title()
clazz = window.get_active_class()
dialog.info_dialog("Window Filter Test",
                   f"Triggered in:\n\nTitle: {win}\nClass: {clazz}")
