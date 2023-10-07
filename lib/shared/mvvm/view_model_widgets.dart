import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'view_model.dart';
import 'view_model_builder_widget.dart';

/// A widget that wraps the [ViewModelBuilderWidget] class in a less boiler plate usage.
abstract class ViewModelWidget<T extends ViewModel> extends StatelessWidget {
  const ViewModelWidget({Key? key}) : super(key: key);

  /// Indicates if the [builder] function should be called when [ViewModel.notifyListeners] is called.
  ///
  /// If set to false the [builder] will be called only once and the widget will be used as
  /// a static child.
  ///
  /// Default value is set to true.
  @protected
  bool get rebuildOnChange => true;

  /// {@macro disposeViewModel_doc}
  @protected
  bool get disposeViewModel => true;

  /// {@macro viewModelBuilder_doc}
  @protected
  T viewModelBuilder();

  /// {@macro builder_doc}
  @protected
  Widget builder(BuildContext context, T viewModel, Widget? child);

  /// {@macro staticChild_doc}
  /// The [ViewModelBuilderWidget.withConsumer] constructor will be used only if
  /// the [rebuildOnChange] property is set to true.
  @protected
  Widget? staticChildBuilder(T viewModel) => null;

  @override
  Widget build(BuildContext context) {
    if (rebuildOnChange) {
      return ViewModelBuilderWidget.withConsumer(
        viewModelBuilder: viewModelBuilder,
        builder: builder,
        staticChildBuilder: staticChildBuilder,
        disposeViewModel: disposeViewModel,
      );
    } else {
      return ViewModelBuilderWidget.simple(
        viewModelBuilder: viewModelBuilder,
        builder: builder,
        disposeViewModel: disposeViewModel,
      );
    }
  }
}

/// A widget that wraps the [ViewModelBuilderWidget] class and uses the [Selector] widget internally to respond to changes in the viewModel.
abstract class ViewModelSelectorWidget<T extends ViewModel, S>
    extends StatelessWidget {
  const ViewModelSelectorWidget({Key? key}) : super(key: key);

  /// {@macro disposeViewModel_doc}
  @protected
  bool get disposeViewModel => true;

  /// {@macro viewModelBuilder_doc}
  @protected
  T viewModelBuilder();

  /// A function that is used to select on which property change, in the viewModel, the widget should rebuild.
  /// Params:
  /// - [context] - the [BuildContext] for the widget
  /// - [viewModel] - the actual view model for this widget. At this point the view model is initialized and may be used.
  @protected
  S selector(BuildContext context, T viewModel);

  /// A builder function that is used to build the UI for this widget.
  ///
  /// Params:
  /// - [context] - the [BuildContext] for the widget
  /// - [value] - the actual property from the viewModel on which the [Selector] widget is listening for changes.
  /// - [child] - Refers to the widget that is returned from the [staticChildBuilder] function and it will be included in the UI.
  @protected
  Widget builder(BuildContext context, S value, Widget? child);

  /// {@macro staticChild_doc}
  @protected
  Widget? staticChildBuilder(T viewModel) => null;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilderWidget.simple(
      viewModelBuilder: viewModelBuilder,
      builder: _buildSelector,
      disposeViewModel: disposeViewModel,
    );
  }

  Selector<T, S> _buildSelector(
      BuildContext context, T viewModel, Widget? child) {
    return Selector<T, S>(
      selector: selector,
      builder: builder,
      child: staticChildBuilder(viewModel),
    );
  }
}
