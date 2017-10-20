# alpine-keeweb

Forked from viossat/docker-keeweb-webdav & antelle/keeweb

Free cross-platform password manager compatible with KeePass.
https://keeweb.info/

This image supports WebDAV, this makes possible to store/sync password files on the same container.

Note: Over WebDAV, KeeWeb can update files but can't currently create them, the files must exist.

- Alpine-based
- no TLS support, reverse proxy with TLS recommended

## Usage

First, start KeeWeb (`/my/keepass-files/` must contain the .kdbx password file):
```bash
docker run -d -p 80:80 -e WEBDAV_USERNAME=webdav -e WEBDAV_PASSWORD=secret -v /my/keepass-files:/keeweb/webdav jbbodart/alpine-keeweb
```

Then, go to KeeWeb through your browser, click on `More`, click on `WebDAV` and enter your configuration:
```
URL: https://example.com/webdav/filenanme
Username: webdav
Password: secret
```

You can also open you kdbx file with the keepass desktop client (file -> Open -> Open URL).
