#!/bin/bash

# Exit the script if any of the commands fail
set -e

# Check if tools available

if ! command -v ssh-keygen &> /dev/null; then
    echo "ssh-keygen could not be found"
    exit 1
fi

if ! command -v openssl &> /dev/null; then
    echo "openssl could not be found"
    exit 1
fi


echo "Please enter your key name [default: plain]:"
read -r base_key_name_input

base_key_name=${base_key_name_input:=plain}
private_key_name="$base_key_name.key.pem"
public_key_name="$base_key_name.key.pem.pub"

if test -f "$private_key_name"; then
    echo "$private_key_name already exists, aborting."
    exit 1
fi

if test -f "$public_key_name"; then
    echo "$public_key_name already exists, aborting."
    exit 1
fi

echo "Generating 2048 bit RSA key"
echo "When asked for a passphrase don't enter anything if you're just testing. For production, decide if you need one or not."
echo ""
# We use ssh-keygen as it allows us to skip providing a passphrase (as opposed to openssl)
ssh-keygen -t rsa -b 2048 -m PEM -f "$private_key_name"

openssl rsa -in "$private_key_name" -pubout -outform PEM -out "$public_key_name"

echo ""
echo "Your $base_key_name keys are:"
echo -e "- Private (keep secret on your backend): $private_key_name"
echo -e "- Public (upload to https://app.plain.com): $public_key_name"
echo ""

if command -v pbcopy &> /dev/null; then
  pbcopy < "$public_key_name"
  echo "$public_key_name has been copied to your clipboard!"
else
  echo "Public key $public_key_name contents:"
  echo ""
  cat "$public_key_name"
  echo ""
fi