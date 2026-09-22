# plantpal product catalog

A maintainable shop/catalog module for plantpal: houseplants, fertilizer,
and plant-care products, each with a real photo, price, and an outbound
"Buy" link to the actual retailer. Built because there's no single free,
live shopping API that covers houseplants + fertilizer together — so
instead of scattering hardcoded URLs through your UI code, this keeps all
of that in one small, structured place that's easy to read, validate, and
grow.

## How it's organized, and why

```
assets/data/products.json   <- the ONLY place product data lives
lib/models/                 <- Product, ProductCategory (plain Dart classes)
lib/services/
  product_repository.dart   <- loads/parses the JSON, local or remote
  image_service.dart        <- fetches a photo per product (Unsplash API)
lib/widgets/product_card.dart
lib/screens/product_catalog_screen.dart   <- example grid UI, ready to use
tools/catalog_manager.py    <- add/validate/list products from the terminal
pubspec_additions.yaml      <- deps + asset line to merge into your pubspec.yaml
```

The core idea: **no product data is hardcoded in any widget.** Everything
UI-facing reads from `Product`/`ProductCategory` objects that come from
`products.json` through `ProductRepository`. To add, price-correct, or
remove a product, you touch one JSON file (or run the Python tool) —
never Dart code, never a screen file.

## Where the images come from

Rather than hotlinking scraped product photos (fragile — retailers change
CDN paths, block hotlinking, or redesign product pages, silently breaking
your images), each product stores an `imageQuery` string like
`"golden pothos plant"`. At runtime, `ImageService` looks that up via the
**Unsplash API**, which actually is a genuinely free, live, no-approval-
needed API for this purpose:

1. Create a free account at https://unsplash.com/developers
2. Click **New Application**, copy the **Access Key**
3. Pass it in: `ImageService(accessKey: 'your-key-here')`

The Demo tier allows 50 requests/hour, but since every result is cached on
the device after its first fetch (see `image_service.dart`), a 100-product
catalog only ever costs ~100 requests total per install — you won't hit
that limit in normal use. If you outgrow it, Unsplash's free "Apply for
Production" review raises the limit substantially.

If you leave the key blank, or a lookup fails (offline, rate-limited, no
match), the app shows a plain leaf-icon placeholder instead of breaking —
see the `errorBuilder` in `product_card.dart`.

## Where the prices and buy-links come from

These **are** hardcoded, by design, because no free live API reliably
covers plant/fertilizer pricing across retailers. The 8 seed products in
`products.json` are real listings (Home Depot and Ace Hardware, checked
22 Sept 2026) — a working starting point, not placeholders. But hardcoded
prices go stale, which is why every product has a `lastVerified` date and
`Product.isStale()` — wire that into a small "price may have changed"
badge if you want the UI to be honest about it.

**If your users aren't primarily US-based**, swap these out for local
nurseries/garden centers or a marketplace active in your market — the
schema doesn't care which vendor, only that `buyUrl` is a real product
page.

### If you want live prices later

Two options actually give you a free, *live* price + image + affiliate
link per product, which the hardcoded-JSON approach can't:

- **eBay Partner Network / Browse API** — free, no sales minimum to get
  started, plenty of plant/fertilizer listings: https://developer.ebay.com
- **Amazon Product Advertising API** — free once you're an Associate, but
  requires a small number of qualifying sales within 180 days to keep
  access: https://webservices.amazon.com/paapi5/documentation/

Either would replace `ProductRepository`'s JSON-loading with an API call —
the `Product` model and every widget above it wouldn't need to change,
because they only know about `Product` objects, not where they came from.
That's the payoff of the repository pattern here.

## Setup

1. Copy `assets/`, `lib/models`, `lib/services`, `lib/widgets`,
   `lib/screens`, and `tools/` into your existing plantpal project
   (merge into your current `lib/` rather than overwriting it).
2. Merge `pubspec_additions.yaml` into your real `pubspec.yaml`, then:
   ```
   flutter pub get
   ```
3. Get an Unsplash access key (see above).
4. Open the catalog from anywhere in your app:
   ```dart
   Navigator.push(context, MaterialPageRoute(
     builder: (_) => ProductCatalogScreen(
       repository: ProductRepository(),
       imageService: ImageService(accessKey: 'YOUR_UNSPLASH_KEY'),
     ),
   ));
   ```
   Construct `repository`/`imageService` once (e.g. in `main.dart` or
   your existing DI setup) and pass them down — they don't assume any
   particular state-management package.

## Updating the catalog

**Option A — hand-edit** `assets/data/products.json`. It's small and
flat on purpose.

**Option B — use the helper script** (no need to hand-write JSON):
```
cd tools
python3 catalog_manager.py add         # interactive prompts, validates before saving
python3 catalog_manager.py validate    # checks required fields, types, duplicate ids
python3 catalog_manager.py list        # quick table of everything in the catalog
python3 catalog_manager.py check-links # confirms every buyUrl still resolves (HEAD request only)
```

**Option C — over-the-air updates.** Host `products.json` somewhere static
(a raw GitHub URL works fine to start) and pass that URL to
`ProductRepository(remoteUrl: '...')`. The app fetches it on launch and
falls back to the bundled copy if that fails, so you can correct a price
or swap a dead link without an app store release.

## Honest limitations

- Retailer prices and links drift. Re-run `check-links` periodically and
  budget time to re-verify prices every month or two — that's inherent to
  hardcoding rather than using a live pricing API (see above).
- Unsplash photos are *representative* stock photos of the species/product,
  not photos of the exact item on the exact vendor page. That's a fair
  trade for "never a broken image," but worth knowing.
