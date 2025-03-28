# A Google Fonts proxy as a Docker image for GDPR compliance

Recently, several GDPR Data Protection Authorities restricted the usage of Google Fonts in websites
receiving visits from European Union residents.

These new restrictions make it more illegal to use Google Fonts directly. This proxy is a plug-and-play
replacement for Google Fonts that can be hosted on a custom domain to proxy Google Fonts and thus comply
with GDPR (as no personal data will be transfered to Google Fonts).

This image only relies on nginx and its substitution module: it's extremely fast, privacy friendly and 
production ready.

## Supported CPU Architectures
This Docker image supports the following CPU architectures:

| Architecture | Supported |
|--------------|-----------|
| amd64        | ✔️         |
| arm64        | ✔️         |

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| FONTS_HOST | The FQDN you intend to use for your proxy. You will need to replace the url in your css files accordingly  | `fonts.example.com` |


## Usage

Once setup (for instance at BluetonicBeats we run an instance on https://fonts.bluetonicbeats.com), all requests done to 
the configured URL will be forwarded to Google Fonts with the same exact URL path and CSS responses
will be altered on-the-fly to change fonts files reference to use your own domain. 

**This forwarding will be done fully anonymously so that the client IP and personnal data won't ever 
be transmitted to Google.**

Once deployed, you can use the service by directly replacing the Google Fonts URL with your own:

```html
<link href="https://fonts.googleapis.com/css2?family=Assistant:ital,wght@0,400;0,700;0,800;1,400;1,700" rel="stylesheet" crossorigin="anonymous" />
<!-- becomes -->
<link href="https://fonts.bluetonicbeats.com/css2?family=Assistant:ital,wght@0,400;0,700;0,800;1,400;1,700" rel="stylesheet" crossorigin="anonymous" />
```

> In compliance to Google Fonts Terms of Service, this proxy doesn't cache the fonts locally, it only transfers
> the requests (https://github.com/google/fonts/issues/1637).

## Setup

With docker-compose:

```yaml
version: '3'

services:
    fonts:
        image: ghcr.io/bluetonicbeats/docker-google-fonts-proxy/alpine
        ports:
            # You can use a proxy (like https://github.com/nginx-proxy/nginx-proxy) 
            # to provide SSL
            - '80:80'
        environment:
            # The host you use for fonts: references to Google Fonts 
            # will be replaced to this host in CSS files
            - FONTS_HOST=fonts.bluetonicbeats.com
```

With Docker CLI:

```bash
docker run -d \ 
    -p 80:80 \
    -e FONTS_HOST=fonts.bluetonicbeats.com \
    ghcr.io/bluetonicbeats/docker-google-fonts-proxy/alpine
```

## For developers: what to tell you Data Protection Officer?

Your Data Protection Officer (the person responsible of GDPR in your company) may be curious about the details
of this tool, especially given the amount of media coverage the latest Google Fonts GDPR issues had.

To answer their questions, you can explain that this tool *anonymizes data* (in the GDPR meaning): it transforms
personal, indirectly identifiable data into fully anonymous requests towards Google. As long as you host this
service in your own infrastructure, no personal data is ever transfered to Google (or any other intermediate).

Data anonymization (which is different from pseudonymization) ensures that the data transfered to Google isn't
covered by GDPR, thus not being a compliance issue.

## Project Maintenance

This project was originally maintained by another repository. Due to the original repository appearing unmaintained, I have taken over its maintenance.
The project is set to auto-update once a week for security reasons.
Contributions from maintainers and pull requests are welcome.

## License
Since the original repository did not have a license, I have chosen to license this project under the MIT License. If you are the original author and would like to change the license, please contact me.
