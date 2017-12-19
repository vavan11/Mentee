#!/usr/bin/python
import os
import sys
import argparse
def parse():
    parser = argparse.ArgumentParser()
    parser.add_argument('-f', '--ftype', help='one service')
    args = vars(parser.parse_args())
    f_type = args['ftype']
    if None in args.values():
        print args.values()
        parser.print_help()
        parser.exit(1)
    else:
        return(f_type)

def check_one_service(x):
    service = os.system("sudo systemctl is-active %s" %x)
    print service

def main():
    f_type = parse()
    check_one_service(f_type)

main()
