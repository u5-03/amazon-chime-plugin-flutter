.PHONY: openIOS

openIOS:
	@open example/ios/Runner.xcworkspace
run-pigeon:
	@dart run pigeon --input lib/pigeon/message_data.dart
