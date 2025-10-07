import '../state/notifier.dart';

void addError(String error) {
  final updatedErrors = [...errorsNotifier.value, error];
  errorsNotifier.value = updatedErrors;
}

void clearErrors() {
  errorsNotifier.value = [];
}