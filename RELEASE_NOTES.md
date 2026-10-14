KPG resource pack (Vanilla+ 24.0 with KPG fixes, pack format 88).

## Server setup

Put these lines in `server.properties`, then restart the server:

```properties
resource-pack=https://github.com/Kings-Gaming-Studio/my-minecraft-resource-pack-v1/releases/latest/download/KPG-ResourcePack.zip
resource-pack-sha1={{SHA1}}
require-resource-pack=true
```

The custom `moldomre` items only work if the server also runs the matching Vanilla+ data packs in `world/datapacks/`.

## What's in this build

{{CHANGES}}

## Updating

Every release lists its own SHA-1 above. Copy it into `resource-pack-sha1` each time, or players keep the old pack. Full setup notes are in `SERVER_SETUP.md`.
