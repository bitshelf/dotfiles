# 禁用语法高亮
bleopt highlight_syntax=

# 禁用基于文件名的高亮
bleopt highlight_filename=

# 禁用基于变量类型的高亮
bleopt highlight_variable=

# 禁用自动完成（注意：在 bash-4.0+ 中，默认启用）
bleopt complete_auto_complete=

# 提示：你可以设置自动完成延迟时间（单位：毫秒）
bleopt complete_auto_delay=300

# 禁用基于历史记录的自动完成
# bleopt complete_auto_history=
bleopt complete_contract_function_names=
# bleopt indent_tabs=

# 禁用模糊完成
bleopt complete_ambiguous=

# 禁用使用 Tab 键触发的菜单补全
bleopt complete_menu_complete=

# 禁用菜单过滤（注意：在 bash-4.0+ 中，默认启用）
bleopt complete_menu_filter=

# 禁用类似 "[ble: EOF]" 的结束标记
bleopt prompt_eol_mark=''
# 提示：也可以设置为其他字符串
bleopt prompt_eol_mark='⏎'

# 禁用 "[ble: exit %d]" 类似的错误退出标记
bleopt exec_errexit_mark=
# 提示：也可以设置为其他字符串
bleopt exec_errexit_mark=$'\e[91m[error %d]\e[m'

# 禁用 "[ble: elapsed 1.203s (CPU 0.4%)]" 类似的耗时标记
bleopt exec_elapsed_mark=
# 提示：也可以设置为其他字符串
bleopt exec_elapsed_mark=$'\e[94m[%ss (%s %%)]\e[m'
# 提示：也可修改显示该标记的时间阈值
bleopt exec_elapsed_enabled='sys+usr>=10*60*1000'  # 例如：总 CPU 使用时间达到十分钟

# 禁用 "[ble: exit]" 类似的退出标记
bleopt exec_exit_mark=

# 禁用其他如 "[ble: ...]" 类似标记
bleopt edit_marker=
bleopt edit_marker_error=
bleopt edit_abell=

bleopt complete_menu_color_match=off
