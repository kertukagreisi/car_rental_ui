import 'package:flutter/foundation.dart';

/// Contains base functionality for implementing the MVVM pattern with the help of [ChangeNotifier] class.
abstract class ViewModel extends ChangeNotifier {
  /// Returns true if the view model has been already initialized.
  bool get isInitialized => _isInitialized;
  bool _isInitialized = false;

  /// Returns true if the view model has been disposed.
  bool get isDisposed => _isDisposed;
  bool _isDisposed = false;

  /// Returns true if currently a data loading function is in progress.
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  /// This method is called only the first time when the view model is initialized.
  /// Use it to run code that must be executed only once when this instance is created.
  @mustCallSuper
  void init() {
    if (_isInitialized) return;
    _isInitialized = true;
  }

  @mustCallSuper
  @protected
  @override
  void notifyListeners() {
    if (!isDisposed) super.notifyListeners();
  }

  @mustCallSuper
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  /// Call this method when you want to load some async data
  /// and also show a loading indicator on the screen.
  @protected
  Future<void> loadDataAsync<T>(Future<void> Function() loadData) async {
    isLoading.value = true;
    await loadData();
    isLoading.value = false;
  }
}
