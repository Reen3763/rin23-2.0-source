#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
if [ ! -f .env.json ]; then cp .env.example.json .env.json; fi
flutter pub get
flutter gen-l10n
flutter build apk --release --target-platform android-arm64 --dart-define-from-file=.env.json
