format:
	dart format --line-length=140 --set-exit-if-changed lib test

analyze:
	flutter analyze --no-pub .

repair:
	flutter clean
	flutter pub get
	flutter pub cache repair