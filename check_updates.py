#!/usr/bin/env python3
# Copyright 2022 Canonical Ltd.
# See LICENSE file for licensing details.

import requests
import subprocess
import re
from bs4 import BeautifulSoup

def get_releases():
    URL = "https://dlcdn.apache.org/zookeeper/"
    page = requests.get(URL)

    soup = BeautifulSoup(page.content, "html.parser")
    releases = []

    links = soup.find_all('a')
    for link in links:
        short_link = link['href'][:-1]
        if 'zookeeper-' in short_link:
            releases.append(short_link[10:])
    return releases

def get_branches():
    git_branch = subprocess.run(["git", "branch", "-r"], capture_output=True, text=True).stdout
    return re.findall("\d.\d.\d+", git_branch)

def diff_versions():
    return [ x for x in get_releases() if x not in get_branches() ]
    

if __name__ == "__main__":
    for version in diff_versions():
        print(version)