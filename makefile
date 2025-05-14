run_prod:
	flutter run -d chrome -v --dart-define-from-file=.env
run_dev:
	flutter run -d chrome -v --dart-define-from-file=.dev.env
run_build:
	flutter build web -v --release --dart-define-from-file=./.env --output "./cloudflare_deployment"		
