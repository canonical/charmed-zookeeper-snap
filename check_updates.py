#!/usr/bin/env python3
# Copyright 2023 Canonical Ltd.
# See LICENSE file for licensing details.

from typing import Optional
import requests
import subprocess
import re
from bs4 import BeautifulSoup


class Branch:
    def __init__(self, branch_name: str):
        self.branch_name = branch_name

    @property
    def major_version(self) -> Optional[str]:
        major = re.match(r"\d+.\d+", self.branch_name)
        if major:
            return major[0]

        return None

    @property
    def minor_version(self) -> Optional[str]:
        file = subprocess.run(
            ["git", "show", f"{self.branch_name}:snap/snapcraft.yaml"],
            capture_output=True,
            text=True,
        ).stdout

        match = None
        for line in file.splitlines():
            if match := re.match(r"(version:) \'(\d+.\d+.\d+)'", line):
                break

        if match:
            return match[2]

        return None


def get_branches() -> set[Branch]:
    git_branch = subprocess.run(
        ["git", "branch", "-r"], capture_output=True, text=True
    ).stdout
    git_branches = set(re.findall(r"\d+.\d+/[a-z]+", git_branch))

    return {Branch(branch_name=branch) for branch in git_branches}


def get_releases() -> set[str]:
    URL = "https://dlcdn.apache.org/zookeeper/"
    page = requests.get(URL)

    soup = BeautifulSoup(page.content, "html.parser")
    links = soup.find_all("a")

    releases = set()
    for link in links:
        short_link = link["href"][:-1]
        if "zookeeper-" in short_link:
            full_version = re.sub(r"zookeeper\-", "", short_link)
            releases.add(full_version)

    return releases


if __name__ == "__main__":
    branches = get_branches()
    releases = get_releases()

    supported_minor_versions = {branch.minor_version for branch in branches}
    new_versions = releases - supported_minor_versions

    print(new_versions)
