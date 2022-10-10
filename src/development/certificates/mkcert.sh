#!/bin/sh
THIS=$(dirname "$(readlink -f "$0")")

create() {
    NAME="$1"
    shift
    CONTENT=$*

    path="$THIS/$NAME"
    certfile="$path.crt"
    keyfile="$path.key"

    # shellcheck disable=SC2086
    mkcert \
        -cert-file "$certfile" \
        -ecdsa \
        -key-file "$keyfile" $CONTENT

    cat "$(mkcert -CAROOT)/rootCA.pem" >> "$certfile"
}

rm "$THIS"/*.key "$THIS"/*.crt

create "localhost" "localhost" "127.0.0.1"
create "maevsi" "maevsi.test" "www.maevsi.test" "alpha.maevsi.test"
create "traefik" "*.maevsi.test"
