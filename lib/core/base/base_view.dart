import 'package:flutter/material.dart';
import 'package:happ/core/base/logger.dart';
import 'package:happ/core/models/theme_variant.dart';
import 'package:provider/provider.dart';

class BaseView<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget child) builder;
  final Function(T) onModelReady;
  final T viewModel;
  final Widget child;

  BaseView({this.builder, this.viewModel, this.child, this.onModelReady});

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends ChangeNotifier> extends State<BaseView<T>> {
  T model;

  @override
  void initState() {
    model = widget.viewModel;
    getLogger(this.runtimeType.toString()).i('initState');
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getLogger(this.runtimeType.toString()).i('build');
    return Theme(
      data: () {
        switch (Provider.of<ThemeVariant>(context).variant) {
          case Variant.dark:
            return ThemeData.dark();
          case Variant.light:
            return ThemeData.light();
          default:
            return ThemeData.dark();
        }
      }(),
      child: ChangeNotifierProvider<T>(
        builder: (context) => model,
        child: Consumer<T>(
          builder: widget.builder,
          child: widget.child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    getLogger(this.runtimeType.toString()).i('dispose');
    super.dispose();
  }
}
