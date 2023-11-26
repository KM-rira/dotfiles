import argparse

def getStatus(args):
    select_type = ""
    limit = 30
    for arg in args:
        # type 引数に基づいて selectType を設定
        if arg == 'o':
            select_type = '--state open'
        elif arg == 'c':
            select_type = '--state closed'
        elif arg == 'a':
            select_type = '--state all'
        elif arg == 'd':
            select_type = '--draft'
        elif arg.isdigit():
            limit = arg

    return select_type, limit
