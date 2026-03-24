#!/bin/bash

# macOS Policy Banner Deployment Script
# Deploys a login banner using a Base64 encoded RTF file

set -e

# -------- CONFIG --------
BANNER_PATH="/Library/Security/PolicyBanner.rtf"
TMP_PATH="/tmp/PolicyBanner.rtf"

# Base64 encoded RTF content (Generic Security Banner)
B64_CONTENT="e1xydGYxXGFuc2lcYW5zaWNwZzEyNTJcY29jb2FydGYyODIyClxjb2NvYXRleHRzY2FsaW5nMFxjb2NvYXBsYXRmb3JtMHtcZm9udHRibFxmMFxmc3dpc3NcZmNoYXJzZXQwIEFyaWFsLUJvbGRNVDtcZjFcZnN3aXNzXGZjaGFyc2V0MCBBcmlhbE1UO30KXHBhcmRccWNcZjBcYlxmczI0IFNlY3VyaXR5IE5vdGljZVxmMVxiMCBcZnMyMlxwYXIKClRoaXMgY29tcHV0ZXIgc3lzdGVtIGlzIGludGVuZGVkIGZvciBhdXRob3JpemVkIHVzZXJzIG9ubHkuIEFsbCBhY3Rpdml0aWVzIG1heSBiZSBtb25pdG9yZWQgYW5kIGxvZ2dlZC4gVW5hdXRob3JpemVkIHVzZSBpcyBwcm9oaWJpdGVkIGFuZCBtYXkgcmVzdWx0IGluIGRpc2NpcGxpbmFyeSBhY3Rpb24uIFBsZWFzZSBlbnN1cmUgdGhhdCB5b3UgY29tcGx5IHdpdGggb3JnYW5pemF0aW9uYWwgcG9saWNpZXMuXHBhcg=="

# -------- SCRIPT --------

echo "🔧 Creating temporary banner file..."

echo "$B64_CONTENT" | base64 -d > "$TMP_PATH"

if [ -f "$TMP_PATH" ]; then
    echo "🚀 Deploying banner..."

    sudo mv "$TMP_PATH" "$BANNER_PATH"
    sudo chmod 644 "$BANNER_PATH"
    sudo chown root:wheel "$BANNER_PATH"

    echo "✅ Banner successfully deployed at $BANNER_PATH"
else
    echo "❌ Failed to create banner file"
    exit 1
fi
