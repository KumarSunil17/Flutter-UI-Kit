import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uikit/logic/bloc/cart_bloc.dart';
import 'package:flutter_uikit/model/product.dart';
import 'package:flutter_uikit/ui/page/shopping/shopping_two/product_card.dart';
import 'package:flutter_uikit/utils/uidata.dart';

class ProductDetailWidgets extends StatelessWidget {
  final Product product;

  const ProductDetailWidgets({super.key, required this.product});

  Widget appBarColumn(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  defaultTargetPlatform == TargetPlatform.android
                      ? Icons.arrow_back
                      : Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () =>
                    Navigator.canPop(context) ? Navigator.pop(context) : null,
              ),
              Text(
                "Product Detail",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              Opacity(
                opacity: 0.0,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          ProductCard(product: product)
        ],
      );
  Widget quantityCard(Size deviceSize, CartBloc cartBloc) => Positioned(
        top: (deviceSize.height - deviceSize.height * 0.1),
        left: deviceSize.width / 2 - deviceSize.width / 5,
        width: deviceSize.width / 2 - 30,
        child: Material(
          clipBehavior: Clip.antiAlias,
          shape: StadiumBorder(),
          shadowColor: Colors.black,
          elevation: 2.0,
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: UIData.kitGradients),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                  onPressed: () => cartBloc.subtractionController.add(true),
                ),
                StreamBuilder<int>(
                  stream: cartBloc.getCount,
                  initialData: 0,
                  builder: (context, snapshot) => Text(
                        snapshot.data.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () => cartBloc.additionalController.add(true),
                )
              ],
            ),
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    CartBloc cartBloc = CartBloc(product);
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        appBarColumn(context),
        quantityCard(deviceSize, cartBloc),
      ],
    );
  }
}
