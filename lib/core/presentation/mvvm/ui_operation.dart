/// Lifecycle state of an individual user operation.
enum UiOperationStatus { idle, running, succeeded, failed }

extension UiOperationStatusX on UiOperationStatus {
  bool get isRunning => this == UiOperationStatus.running;
  bool get hasFailed => this == UiOperationStatus.failed;
}
