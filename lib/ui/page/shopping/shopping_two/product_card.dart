import 'package:flutter/material.dart';
import 'package:flutter_uikit/model/product.dart';
import 'package:flutter_uikit/ui/page/shopping/shopping_two/product_desc.dart';
import 'package:flutter_uikit/utils/uidata.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({super.key, required this.product});
  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  late Size deviceSize;
  late AnimationController controller;
  late Animation<double> animation;

  Widget productCard() {
    var cardHeight = deviceSize.height * 0.8;
    var cardWidth = deviceSize.width * 0.85;
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)),
      color: Colors.white,
      child: Ink(
        height: cardHeight,
        width: cardWidth,
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: cardHeight - cardHeight / 2 * 1.1,
              width: double.infinity,
              child: Image.network(
                widget.product.image,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: cardHeight / 2 * 1.2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: UIData.kitGradients),
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(30.0),
                      topRight: const Radius.circular(30.0)),
                  color: Colors.white,
                ),
                child: ProductDesc(product: widget.product),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
    animation.addListener(() => setState(() {}));
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return productCard();
  }
}
