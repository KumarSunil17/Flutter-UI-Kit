import 'package:flutter/material.dart';
import 'package:flutter_uikit/logic/bloc/product_bloc.dart';

class ProductProvider extends InheritedWidget {
  final ProductBloc productBloc;

  const ProductProvider({
    super.key,
    required this.productBloc,
    required super.child,
  });

  static ProductProvider of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<ProductProvider>();
    assert(provider != null, 'ProductProvider not found in context');
    return provider!;
  }

  @override
  bool updateShouldNotify(ProductProvider oldWidget) =>
      productBloc != oldWidget.productBloc;
}
