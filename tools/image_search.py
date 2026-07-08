#!/usr/bin/env python3
"""
image_search.py -- fetch the top N images for a search term ("the Google Images thing").

Primary engine : icrawler.GoogleImageCrawler  -> actually crawls Google Images.
Fallback engine: ddgs.DDGS().images()          -> DuckDuckGo / Bing image search,
                                                  used automatically if Google returns
                                                  nothing (rate-limit / HTML changes).

Usage:
    python image_search.py "Eiffel Tower"
    python image_search.py "red panda" --num 5 --out downloads
    python image_search.py                     # prompts for a search term

Install the dependencies once:
    pip install icrawler ddgs requests
"""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

IMG_EXTS = {".jpg", ".jpeg", ".png", ".gif", ".bmp", ".webp"}


def slugify(text: str) -> str:
    """Turn a search term into a safe folder name, e.g. 'Red Panda!' -> 'red_panda'."""
    slug = re.sub(r"[^\w\s-]", "", text).strip().lower()
    slug = re.sub(r"[\s-]+", "_", slug)
    return slug or "images"


def list_images(folder: Path) -> list[Path]:
    """Return image files currently in a folder."""
    if not folder.exists():
        return []
    return sorted(p for p in folder.iterdir() if p.suffix.lower() in IMG_EXTS)


# --------------------------------------------------------------------------- #
# Engine 1: Google Images (via icrawler)                                       #
# --------------------------------------------------------------------------- #
def fetch_from_google(keyword: str, num: int, out_dir: Path) -> list[Path]:
    """Download the top `num` images from Google Images into `out_dir`."""
    import logging

    from icrawler.builtin import GoogleImageCrawler

    out_dir.mkdir(parents=True, exist_ok=True)
    crawler = GoogleImageCrawler(
        storage={"root_dir": str(out_dir)},
        feeder_threads=1,
        parser_threads=1,
        downloader_threads=4,
        log_level=logging.ERROR,  # keep icrawler's chatty INFO logs quiet
    )
    crawler.crawl(keyword=keyword, max_num=num)
    return list_images(out_dir)


# --------------------------------------------------------------------------- #
# Engine 2: DuckDuckGo / Bing (via ddgs) -- fallback                           #
# --------------------------------------------------------------------------- #
def fetch_from_ddgs(keyword: str, num: int, out_dir: Path) -> list[Path]:
    """Fallback: get image URLs from ddgs and download them one by one."""
    import requests
    from ddgs import DDGS

    out_dir.mkdir(parents=True, exist_ok=True)
    headers = {
        "User-Agent": (
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
            "AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0 Safari/537.36"
        )
    }

    # Ask for extra results because some direct URLs will fail to download.
    results = DDGS().images(query=keyword, max_results=num * 4)

    saved: list[Path] = []
    for i, item in enumerate(results):
        if len(saved) >= num:
            break
        url = item.get("image")
        if not url:
            continue
        try:
            resp = requests.get(url, headers=headers, timeout=15)
            resp.raise_for_status()
        except Exception as exc:  # noqa: BLE001 - keep going on any single failure
            print(f"  skip ({exc.__class__.__name__}): {url[:70]}")
            continue

        # Pick an extension from the content-type or the URL, default to .jpg.
        ctype = resp.headers.get("Content-Type", "")
        ext = {
            "image/jpeg": ".jpg",
            "image/png": ".png",
            "image/gif": ".gif",
            "image/webp": ".webp",
        }.get(ctype.split(";")[0].strip())
        if ext is None:
            ext = next((e for e in IMG_EXTS if url.lower().split("?")[0].endswith(e)), ".jpg")

        dest = out_dir / f"{len(saved) + 1:03d}{ext}"
        dest.write_bytes(resp.content)
        saved.append(dest)
        print(f"  saved {dest.name}  <- {url[:70]}")

    return list_images(out_dir)


def search_images(keyword: str, num: int, out_dir: Path) -> list[Path]:
    """Try Google first, fall back to ddgs if it returns nothing."""
    print(f'Searching Google Images for "{keyword}" (top {num})...')
    try:
        images = fetch_from_google(keyword, num, out_dir)
    except Exception as exc:  # noqa: BLE001
        print(f"  Google engine error: {exc}")
        images = []

    if images:
        return images[:num]

    print("Google returned nothing -- falling back to DuckDuckGo/Bing (ddgs)...")
    try:
        return fetch_from_ddgs(keyword, num, out_dir)[:num]
    except Exception as exc:  # noqa: BLE001
        print(f"  Fallback engine error: {exc}")
        return []


def parse_args(argv: list[str]) -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Download the top N images for a search term (Google Images)."
    )
    parser.add_argument("query", nargs="*", help="the name / text to search for")
    parser.add_argument("-n", "--num", type=int, default=5, help="how many images (default 5)")
    parser.add_argument(
        "-o", "--out", default=None, help="output folder (default: ./<slug>)"
    )
    return parser.parse_args(argv)


def main(argv: list[str]) -> int:
    args = parse_args(argv)

    keyword = " ".join(args.query).strip() or input("Enter a name / text to search: ").strip()
    if not keyword:
        print("No search term given.")
        return 1

    out_dir = Path(args.out) if args.out else Path(slugify(keyword))
    images = search_images(keyword, args.num, out_dir)

    if not images:
        print("\nNo images could be downloaded.")
        return 1

    print(f"\nDone. {len(images)} image(s) saved in: {out_dir.resolve()}")
    for p in images[: args.num]:
        print(f"  - {p.name}")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
