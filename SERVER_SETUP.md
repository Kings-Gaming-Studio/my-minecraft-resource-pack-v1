# Using this pack on a multiplayer server

This is a Vanilla+ resource pack with KPG fixes. The `moldomre` items only show up
when the server also runs the matching Vanilla+ **data packs**, so the server needs both.

## 1. Build or download the pack

- Automatic: every push to `main` runs `.github/workflows/release-pack.yml`, which
  publishes `KPG-ResourcePack.zip` and its SHA-1 as the latest GitHub release.
- By hand: run `bash scripts/build-pack.sh`. It checks every JSON file, writes
  `dist/KPG-ResourcePack.zip`, and prints the SHA-1.

## 2. Point the server at it (`server.properties`)

```properties
resource-pack=https://github.com/Kings-Gaming-Studio/my-minecraft-resource-pack-v1/releases/latest/download/KPG-ResourcePack.zip
resource-pack-sha1=<sha1 from the release notes>
require-resource-pack=true
resource-pack-prompt={"text":"KPG needs its resource pack for custom items."}
```

Update `resource-pack-sha1` after each release. Clients cache the pack by its hash,
so a stale hash means players keep the old pack or get a download error.

## 3. Install the Vanilla+ data packs

Copy the matching Vanilla+ data packs into `world/datapacks/` and run `/reload`
(or restart). Pack format here is 88, so the data packs must target the same
Minecraft version.

## Mods and plugins

The pack itself is client side. Server features go in one of two places:

- **Plugins (Paper or Purpur server):** players join with a normal client. Good for
  gameplay rules, custom items with `item_model` components that use this pack's
  models, and server tools like `kpg-antilag`. Recommended default.
- **Mods (Fabric or NeoForge):** every player installs the same mod list. Use only
  when a feature needs new client code. Ship a Modrinth `.mrpack` modpack so
  friends install it in one click.

New custom items should go under the `kpg` namespace (`assets/kpg/...`) so they never
collide with the upstream `moldomre` files when Vanilla+ updates.
