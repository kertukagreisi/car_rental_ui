import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/loading_indicator.dart';
import 'view_model.dart';

/// A widget that provides base functionality for implementing the MVVM pattern with the help of the [Provider] package.
class ViewModelBuilderWidget<T extends ViewModel> extends StatefulWidget {
  /// Use to construct a widget that won't rebuild when [ViewModel.notifyListeners] is called.
  /// The widget returned from the [builder] function will be used as a static child and won't rebuild.
  const ViewModelBuilderWidget.simple({
    required this.viewModelBuilder,
    required this.builder,
    this.disposeViewModel = true,
    Key? key,
  })  : staticChildBuilder = null,
        _rebuildOnChange = false,
        super(key: key);

  /// Use to construct a widget that is going to rebuild when [ViewModel.notifyListeners] is called.
  /// The widget returned from the [builder] function is the one that is going to be rebuild.
  /// This behavior is implemented with the help of the [Consumer] widget.
  const ViewModelBuilderWidget.withConsumer({
    required this.viewModelBuilder,
    required this.builder,
    this.staticChildBuilder,
    this.disposeViewModel = true,
    Key? key,
  })  : _rebuildOnChange = true,
        super(key: key);

  /// {@template viewModelBuilder_doc}
  ///
  /// A builder function that is used to build the view model for this widget.
  ///
  /// {@endtemplate}
  final T Function() viewModelBuilder;

  /// {@template builder_doc}
  ///
  /// A builder function that is used to build the UI for this widget.
  ///
  /// Params:
  /// - [context] - the [BuildContext] for the widget
  /// - [viewModel] - the actual view model for this widget. At this point the view model is initialized and may be used.
  /// - [child] - used only when this widget is build with [ViewModelBuilderWidget.withConsumer] constructor
  /// and a [staticChildBuilder] is passed as a parameter to the constructor. In this case the [child] parameter refers
  /// to the widget that is returned from the [staticChildBuilder] function and it will be included in the UI.
  /// In other cases this parameter is going to be null.
  ///
  /// {@endtemplate}
  final Widget Function(BuildContext context, T viewModel, Widget? child) builder;

  /// {@template staticChild_doc}
  ///
  /// Builder function for a static child to be included in the widget tree. Keep in mind this function will be invoked
  /// only the first time this widget is build. The child will have access to the view model
  /// but it won't get rebuild when [ViewModel.notifyListeners] is called.
  /// This property is only used when this widget is build with the [ViewModelBuilderWidget.withConsumer] constructor.
  ///
  /// {@endtemplate}
  final Widget? Function(T viewModel)? staticChildBuilder;

  /// {@template disposeViewModel_doc}
  ///
  /// Indicates if you want [Provider] to dispose the view model automatically when it is removed from the widget tree.
  /// This is useful for example when you want to have a single instance of a view model that needs to live through the entire lifespan
  /// of the application or to continue to live after the widget has been disposed.
  ///
  /// Default value is set to true.
  ///
  /// {@endtemplate}
  final bool disposeViewModel;

  /// Use internally to decide if the widget content should be wrapped with [Consumer] or not.
  final bool _rebuildOnChange;

  @mustCallSuper
  @override
  State<StatefulWidget> createState() => _ViewModelBuilderWidgetState<T>();
}

class _ViewModelBuilderWidgetState<T extends ViewModel> extends State<ViewModelBuilderWidget<T>> {
  late final T _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = widget.viewModelBuilder();
    _viewModel.init();
  }

  @override
  Widget build(BuildContext context) => _buildChangeNotifierProvider(_buildLoadingIndicatorListener(context));

  Widget _buildChangeNotifierProvider(Widget child) => widget.disposeViewModel
      ? ChangeNotifierProvider<T>(
          create: (_) => _viewModel,
          child: child,
        )
      : ChangeNotifierProvider<T>.value(
          value: _viewModel,
          child: child,
        );

  Widget _buildLoadingIndicatorListener(BuildContext context) => ValueListenableBuilder<bool>(
        valueListenable: _viewModel.isLoading,
        builder: (_, isLoading, child) => isLoading ? const LoadingIndicator() : child!,
        child: _buildWidgetContent(context),
      );

  Widget _buildWidgetContent(BuildContext context) => widget._rebuildOnChange
      ? Consumer<T>(
          builder: widget.builder,
          child: widget.staticChildBuilder?.call(_viewModel),
        )
      : widget.builder(context, _viewModel, widget.staticChildBuilder?.call(_viewModel));
}
