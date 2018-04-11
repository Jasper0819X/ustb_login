#!/usr/bin/env python3
import http.client as client
from urllib.parse import quote
import time
import sys
import getpass


def get_ip():
    conn = client.HTTPConnection('cippv6.ustb.edu.cn')
    conn.request('GET', '/get_ip.php')
    return conn.getresponse().read().decode('utf-8').split("'")[1]


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print('Usage: login.py <your-id>')
        exit()
    username = sys.argv[1]
    password = getpass.getpass()
    ip = get_ip()
    en_ip = quote(ip, safe='')
    en_pwd = quote(password, safe='')

    headers = {
        "Cookie":"myusername=%s; username=%s"%(username, username)
    }

    body = "DDDDD=%s&upass=%s&v6ip=%s&0MKKey=123456789" % (username, en_pwd, en_ip)

    conn = client.HTTPConnection('202.204.48.66')
    conn.request('POST', '/', body, headers)
    res = conn.getresponse()
    print(res.status)
