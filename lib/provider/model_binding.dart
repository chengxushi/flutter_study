import 'package:flutter/material.dart';

/// @description
/// @Created by huang
/// @Date   2020/9/16
/// @email  a12162266@163.com

class _ModelBindingScope<T> extends InheritedWidget {
  final _ModelBindingState<T> modelBindingState;

  const _ModelBindingScope({Key key, this.modelBindingState, Widget child}) : super(key: key, child: child);
  
  @override
  bool updateShouldNotify(_ModelBindingScope oldWidget) => true;
}

class ModelBinding<T> extends StatefulWidget {
  final T initialModel;
  final Widget child;

  const ModelBinding({
    Key key,
    this.initialModel,
    this.child
  }) : assert(initialModel != null), super(key: key);

  _ModelBindingState<T> createState() => _ModelBindingState<T>();

  static T of<T>(BuildContext context) {
    final _ModelBindingScope<T> scope = context.dependOnInheritedWidgetOfExactType<_ModelBindingScope<T>>();
    return scope.modelBindingState.currentModel;
  }

  static void update<T>(BuildContext context, T newModel) {
    final _ModelBindingScope<T> scope = context.dependOnInheritedWidgetOfExactType<_ModelBindingScope<T>>();
    scope.modelBindingState.updateModel(newModel);
  }
}

class _ModelBindingState<T> extends State<ModelBinding<T>> {
  T currentModel;
  
  @override
  void initState() {
    super.initState();
    currentModel = widget.initialModel;
  }
  
  void updateModel(T newModel){
    if(newModel != currentModel){
      setState(() {
        currentModel = newModel;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return _ModelBindingScope<T>(
      modelBindingState: this,
      child: widget.child,
    );
  }
  
}
