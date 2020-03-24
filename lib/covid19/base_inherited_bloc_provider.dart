import 'package:flutter/widgets.dart';

class BaseInheritedBlockProvider<T extends BaseBloc> extends InheritedWidget {
  final T bloc;
  final Widget child;

  const BaseInheritedBlockProvider({ Key key, @required this.bloc, @required this.child}) :super(key: key);

  static T of<T extends BaseBloc>(BuildContext buildContext) {
    final type = _providerType<BaseInheritedBlockProvider<T>>();
    final BaseInheritedBlockProvider<T> provider = buildContext.inheritFromWidgetOfExactType(type);
    print("provider is $provider");

    return provider.bloc;
  }

  static Type _providerType<T>() => T;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}

abstract class BaseBloc {
  void dispose();
  void clearCache();
}