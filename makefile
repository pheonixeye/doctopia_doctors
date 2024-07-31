run_prod:
	flutter run -d chrome -v --dart-define-from-file=.env
run_dev:
	flutter run -d chrome -v --dart-define-from-file=.dev.env