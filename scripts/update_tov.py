#!/usr/bin/env python3
"""Update tov.rb from the latest public tmux-overview release."""

from __future__ import annotations

import argparse
import json
import re
import urllib.request
from pathlib import Path

REPOSITORY = "magcho/tmux-overview"
TARGETS = ("darwin_amd64", "darwin_arm64", "linux_amd64", "linux_arm64")


def parse_checksums(text: str) -> dict[str, str]:
    checksums: dict[str, str] = {}
    for line in text.splitlines():
        parts = line.split()
        if len(parts) == 2 and re.fullmatch(r"[0-9a-fA-F]{64}", parts[0]):
            checksums[parts[1].lstrip("*")] = parts[0].lower()
    return checksums


def update_formula(formula: str, tag: str, checksums: dict[str, str]) -> str:
    match = re.fullmatch(r"v(\d+\.\d+\.\d+)", tag)
    if not match:
        raise ValueError(f"invalid release tag: {tag}")
    version = match.group(1)

    expected = {f"tov_{version}_{target}.tar.gz" for target in TARGETS}
    missing = sorted(expected - checksums.keys())
    if missing:
        raise ValueError(f"missing checksum for: {', '.join(missing)}")

    formula, count = re.subn(
        r'(?m)^([ \t]*version[ \t]+\")[^\"]+(\"[ \t]*)$',
        rf'\g<1>{version}\g<2>',
        formula,
        count=1,
    )
    if count != 1:
        raise ValueError("formula must contain exactly one version declaration")

    for target in TARGETS:
        filename = f"tov_{version}_{target}.tar.gz"
        url = f"https://github.com/{REPOSITORY}/releases/download/{tag}/{filename}"
        pattern = re.compile(
            rf'(?m)^(?P<url_indent>[ \t]*)url[ \t]+"[^"]*/tov_[^"]+_{target}\.tar\.gz"[ \t]*\n'
            rf'^(?P<sha_indent>[ \t]*)sha256[ \t]+"[^"]+"[ \t]*$'
        )
        replacement = (
            rf'\g<url_indent>url "{url}"\n'
            rf'\g<sha_indent>sha256 "{checksums[filename]}"'
        )
        formula, count = pattern.subn(replacement, formula, count=1)
        if count != 1:
            raise ValueError(f"formula entry not found for: {target}")

    return formula


def fetch_latest_release(repository: str) -> tuple[str, str]:
    request = urllib.request.Request(
        f"https://api.github.com/repos/{repository}/releases/latest",
        headers={"Accept": "application/vnd.github+json", "User-Agent": "homebrew-magcho-updater"},
    )
    with urllib.request.urlopen(request, timeout=30) as response:
        release = json.load(response)

    for asset in release.get("assets", []):
        if asset.get("name") == "checksums.txt":
            checksum_request = urllib.request.Request(
                asset["browser_download_url"],
                headers={"User-Agent": "homebrew-magcho-updater"},
            )
            with urllib.request.urlopen(checksum_request, timeout=30) as response:
                return release["tag_name"], response.read().decode("utf-8")
    raise ValueError("latest release has no checksums.txt asset")


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--formula", type=Path, default=Path("tov.rb"))
    parser.add_argument("--repository", default=REPOSITORY)
    args = parser.parse_args()

    tag, checksum_text = fetch_latest_release(args.repository)
    original = args.formula.read_text()
    updated = update_formula(original, tag, parse_checksums(checksum_text))
    if updated == original:
        print(f"tov.rb is already current ({tag})")
        return
    args.formula.write_text(updated)
    print(f"Updated tov.rb to {tag}")


if __name__ == "__main__":
    main()
