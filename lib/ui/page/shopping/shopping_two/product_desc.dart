import 'package:flutter/material.dart';
import 'package:flutter_uikit/model/product.dart';

class ProductDesc extends StatelessWidget {
  final Product product;

  const ProductDesc({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListTile(
              title: Text(
                product.name,
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                product.brand,
                style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
              ),
              trailing: Text(product.price,
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow)),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Text(
              product.description,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "Your Size",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      RawChip(
                          label: Text(
                            "M",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.cyan)
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("Color",
                          style: TextStyle(fontWeight: FontWeight.w700)),
                      RawChip(
                        label: Text(
                          "Red Blue",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("Product ID",
                          style: TextStyle(fontWeight: FontWeight.w700)),
                      RawChip(
                        label: Text(
                          "PQ1001",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.green,
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
