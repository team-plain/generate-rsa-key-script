# generate-rsa-key-script

Script to generate RSA private and public key pairs for Plain.

## Usage

To run the script without cloning this repository:

```shell
bash <(curl -fsSL https://raw.githubusercontent.com/team-plain/generate-rsa-key-script/main/generate_rsa_key_pairs.sh)
```

To run this script after cloning out this repository:

```shell
./generate_rsa_key_pairs.sh
```

You can provide a custom key name, but by default it will use `plain`.

When the script finishes it will either copy the public key onto your clipboard or echo it to your terminal so you can
paste it into your workspace app's public key section.

## Dependencies

- ssh-keygen
- openssl
- pbcopy (optional)
