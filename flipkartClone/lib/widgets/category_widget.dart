import 'package:flipkartClone/models/product.dart';
import 'package:flipkartClone/utils/constants.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  //this will be called from the home screen
  List<Product> categories = [];

  CategoryWidget(this.categories);

  Size deviceSize;
  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;

    return Wrap(
        //it is in form of the Grid
        //it's a wrapper on Grid and List
        children: categories != null && categories.length > 0
            ? categories
                .map(
                  (category) => GestureDetector(
                    // ::::: This will provide onTap feature as there is not such feature in Container or Image
                    onTap: (){
                      Navigator.of(context).pushNamed(Constant.LIST_OF_PRODUCT_ROUTE);
                    },
                    child: Container(
                      width: deviceSize.width / 4,
                      height: deviceSize.height / 8,
                      child: Image.network(category.imagePath),
                    ),
                  ),
                )
                .toList()
            : [
                Container(
                  width: deviceSize.width / 4,
                  height: deviceSize.height / 8,
                  child: Text('No Category Found...'),
                )
              ]);
  }
}
