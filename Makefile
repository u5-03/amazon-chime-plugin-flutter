.PHONY: openIOS run-pigeon build-runner

openIOS:
	@open example/ios/Runner.xcworkspace
run-pigeon:
	@dart run pigeon --input lib/src/pigeon/message_data.dart
build-runner:
	@dart run build_runner build --delete-conflicting-outputs
