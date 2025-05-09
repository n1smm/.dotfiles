#!/usr/bin/env python3
import json
from kitty.boss import Boss

# This is invoked first—in an overlay. We don't need user input here.
def main(args):
    return ""

# After main() returns, handle_result() runs in the background.
def handle_result(args, result, target_window_id, boss: Boss):
    # Define the layout tree:
    layout = {
        "type": "split",
        "direction": "vertical",
        "children": [
            { "type": "leaf" },
            {
                "type": "split",
                "direction": "horizontal",
                "children": [
                    { "type": "leaf" },
                    { "type": "leaf" }
                ]
            }
        ]
    }
    # Invoke Kitty's remote-control API on the current window/tab:
    boss.call_remote_control(
        target_window_id,
        ("goto-layout", json.dumps(layout))
    )

