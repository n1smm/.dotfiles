#!/usr/bin/env python3

def main(_args):
    location_and_maybe_name = input('New tab: ')

    return location_and_maybe_name

def handle_result(args, location_and_maybe_name, target_window_id, boss):
    num_windows = int(args[1])
    pieces = location_and_maybe_name.split(':')
    location = pieces[0]

    if len(pieces) > 1:
        title = pieces[1]
    else:
        title = location

    window = boss.window_id_map.get(target_window_id)

    if window is not None:
        boss.call_remote_control(window, ('launch', '--type=tab', '--cwd=current'))
        boss.call_remote_control(window, ('action', 'set_tab_title', title))
        _set_win(boss, window, location)

        if num_windows > 1:
            boss.call_remote_control(window, ('launch', '--type=window', '--location=hsplit', '--cwd=current'))
            boss.call_remote_control(window, ('send-text', 'clearall\n'))
            _set_win(boss, window, location)

            if num_windows > 2:
                boss.call_remote_control(window, ('launch', '--type=window', '--location=vsplit', '--cwd=current'))
                _set_win(boss, window, location)
                boss.call_remote_control(window, ('send-text', 'clearall\n'))
                boss.call_remote_control(window, ('action', 'resize_window narrower 25'))
                boss.call_remote_control(window, ('action', 'previous_window'))

            boss.call_remote_control(window, ('action', 'previous_window'))
            boss.call_remote_control(window, ('action', 'resize_window taller 18'))
            boss.call_remote_control(window, ('send-text', 'nvim .\n')) # `e` is my terminal alias for vim

def _set_win(boss, window, location):
    pass
