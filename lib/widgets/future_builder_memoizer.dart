import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';

/// Implementation of the [FutureBuilder] where we keep the state of the
/// async operation until requested for refresh.
class FutureBuilderMemoizer<T> extends StatefulWidget {
  const FutureBuilderMemoizer({
    Key? key,
    this.initialData,
    this.refreshInstance,
    required this.future,
    required this.builder,
  }) : super(key: key);

  final Future<T> Function() future;
  final AsyncWidgetBuilder<T> builder;
  final T? initialData;
  final dynamic refreshInstance;

  @override
  State<FutureBuilderMemoizer<T>> createState() => _FutureBuilderMemoizerState<T>();
}

class _FutureBuilderMemoizerState<T> extends State<FutureBuilderMemoizer<T>> {
  late AsyncMemoizer<T> _asyncMemoizer;

  @override
  void initState() {
    super.initState();
    _asyncMemoizer = AsyncMemoizer();
  }

  @override
  void didUpdateWidget(covariant FutureBuilderMemoizer<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.refreshInstance != widget.refreshInstance) {
      _asyncMemoizer = AsyncMemoizer();
    }
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<T>(
        initialData: widget.initialData,
        future: _asyncMemoizer.runOnce(() async => await widget.future()),
        builder: widget.builder,
      );
}
