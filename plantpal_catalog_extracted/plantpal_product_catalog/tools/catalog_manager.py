#!/usr/bin/env python3
"""
Catalog manager for plantpal's product data (assets/data/products.json).

`validate`, `add`, and `list` are pure local file operations — no network
access needed. `check-links` is the one command that goes online, and it
only sends a HEAD request to each buyUrl to confirm it still resolves; it
never reads or extracts page content, so it isn't scraping in any sense
that could run afoul of a site's terms of service.

Usage:
    python3 catalog_manager.py validate
    python3 catalog_manager.py add
    python3 catalog_manager.py list
    python3 catalog_manager.py check-links
"""

import json
import re
import sys
from datetime import date
from pathlib import Path
from urllib.error import HTTPError, URLError
from urllib.request import Request, urlopen

DATA_PATH = Path(__file__).resolve().parent.parent / "assets" / "data" / "products.json"

REQUIRED_FIELDS = [
    "id", "name", "categoryId", "description", "imageQuery",
    "price", "currency", "vendor", "buyUrl", "lastVerified",
]


def load():
    if not DATA_PATH.exists():
        sys.exit(f"Could not find {DATA_PATH}")
    return json.loads(DATA_PATH.read_text())


def save(data):
    DATA_PATH.write_text(json.dumps(data, indent=2, ensure_ascii=False) + "\n")


def validate(data=None, quiet=False):
    data = data or load()
    errors = []
    ids_seen = set()
    category_ids = {c["id"] for c in data.get("categories", [])}

    for i, p in enumerate(data.get("products", [])):
        label = p.get("id", f"item #{i}")

        for field in REQUIRED_FIELDS:
            if field not in p or p[field] in (None, ""):
                errors.append(f"[{label}] missing required field '{field}'")

        if p.get("id") in ids_seen:
            errors.append(f"[{label}] duplicate id")
        ids_seen.add(p.get("id"))

        if "price" in p and not isinstance(p["price"], (int, float)):
            errors.append(f"[{label}] price must be a number, got {p['price']!r}")

        if "categoryId" in p and p["categoryId"] not in category_ids:
            errors.append(f"[{label}] categoryId '{p['categoryId']}' is not in categories[]")

        if "buyUrl" in p and not re.match(r"^https?://", str(p.get("buyUrl", ""))):
            errors.append(f"[{label}] buyUrl does not look like a URL")

    if not quiet:
        if errors:
            print(f"Found {len(errors)} problem(s):")
            for e in errors:
                print(f"  - {e}")
        else:
            print(f"OK — {len(data.get('products', []))} products, no problems found.")
    return errors


def add():
    data = load()
    print("Add a new product (Ctrl+C to cancel).\n")

    name = input("Name: ").strip()
    if not name:
        sys.exit("Cancelled — name is required.")

    slug = re.sub(r"[^a-z0-9]+", "-", name.lower()).strip("-")

    print("Existing categories:", ", ".join(c["id"] for c in data["categories"]))
    category_id = input("Category id: ").strip()

    scientific_name = input("Scientific name (optional): ").strip() or None
    description = input("Short description: ").strip()
    image_query = input(
        "Image search query (used to fetch a photo, e.g. 'monstera deliciosa plant'): "
    ).strip()
    price = float(input("Price (number only, e.g. 24.99): ").strip())
    currency = input("Currency [USD]: ").strip() or "USD"
    vendor = input("Vendor name (e.g. The Home Depot): ").strip()
    buy_url = input("Buy URL: ").strip()

    product = {
        "id": f"{category_id}-{slug}",
        "name": name,
        "categoryId": category_id,
        "description": description,
        "imageQuery": image_query,
        "price": price,
        "currency": currency,
        "vendor": vendor,
        "buyUrl": buy_url,
        "lastVerified": date.today().isoformat(),
    }
    if scientific_name:
        product["scientificName"] = scientific_name

    candidate = {**data, "products": data["products"] + [product]}
    errors = validate(candidate, quiet=True)
    if errors:
        print("\nThis entry has problems and was NOT saved:")
        for e in errors:
            print(f"  - {e}")
        sys.exit(1)

    data["products"].append(product)
    data["lastUpdated"] = date.today().isoformat()
    save(data)
    print(f"\nAdded '{name}' ({product['id']}).")


def list_products():
    data = load()
    for p in data["products"]:
        print(f"{p['id']:28} {p['name']:28} {p['price']:>8.2f} {p['currency']}  {p['vendor']}")


def check_links():
    """HEAD-requests every buyUrl and reports anything that doesn't
    resolve, so a dead 'Buy' button surfaces here instead of in front of a
    user. Status codes only — no page content is read or stored.
    """
    data = load()
    for p in data["products"]:
        url = p["buyUrl"]
        try:
            req = Request(url, method="HEAD", headers={"User-Agent": "Mozilla/5.0"})
            with urlopen(req, timeout=8) as resp:
                status = resp.status
        except HTTPError as e:
            status = e.code
        except URLError as e:
            status = f"ERROR ({e.reason})"
        flag = "" if status == 200 else "  <-- check this"
        print(f"{p['id']:28} {status}{flag}")


if __name__ == "__main__":
    command = sys.argv[1] if len(sys.argv) > 1 else "validate"
    if command == "validate":
        validate()
    elif command == "add":
        add()
    elif command == "list":
        list_products()
    elif command == "check-links":
        check_links()
    else:
        print(__doc__)
