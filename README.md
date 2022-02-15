# A Google Fonts proxy as a Docker image for GDPR compliance

Recently, several GDPR Data Protection Authorities restricted the usage of Google Fonts in websites
receiving visits from European Union residents.

These new restrictions make it more illegal to use Google Fonts directly. This proxy is a plug-and-play
replacement for Google Fonts that can be hosted on a custom domain to proxy Google Fonts and thus comply
with GDPR (as no personal data will be transfered to Google Fonts).

This image only relies on nginx and its substitution module: it's extremely fast, privacy friendly and 
production ready.

## Usage

With docker-compose:

```yaml
version: '3'

services:
    fonts:
        image: docker.pkg.github.com/citipo/docker-google-fonts-proxy/alpine
        ports:
            # You can use a proxy (like https://github.com/nginx-proxy/nginx-proxy) 
            # to provide SSL
            - '80:80'
        environment:
            # The host you use for fonts: references to Google Fonts 
            # will be replaced to this host in CSS files
            - FONTS_HOST=fonts.citipo.com
```

With Docker CLI:

```bash
docker run -d \ 
    -p 80:80 \
    -e FONTS_HOST=fonts.citipo.com \
    docker.pkg.github.com/citipo/docker-google-fonts-proxy/alpine
```
