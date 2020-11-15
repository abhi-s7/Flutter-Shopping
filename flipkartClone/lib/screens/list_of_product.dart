import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flipkartClone/db/dbOperations.dart';
import 'package:flipkartClone/models/product.dart';
import 'package:flutter/material.dart';

class ListOfProduct extends StatefulWidget {
  @override
  _ListOfProductState createState() => _ListOfProductState();
}

class _ListOfProductState extends State<ListOfProduct> {
  final NumberFormat numberFormat = NumberFormat('#,##,###.0#', 'en_US');
  Size deviceSize;

  _displayBottomSheet() {
    // showModalBS - requires context and builder
    // but it will take the whole screen therefore set height to half in the container
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext ctx) {
          return Container(
            height: deviceSize.height / 2,
            child: Column(
              children: [
                Container(
                  child: Text(
                    'SORT BY',
                    style: TextStyle(fontSize: 32),
                  ),
                ),
                // List of Radion widgets
                RadioListTile(
                  value: 'Descending',// by default it is ascending
                  groupValue: 'group1',// it must be same then it will pick unique radio button
                  onChanged: (value){

                  },
                  // but to display text use title:
                  title: Text('Descending'),
                ),
                RadioListTile(
                  value: 'Price Low to High',// by default it is ascending
                  groupValue: 'group1',// it must be same then it will pick unique radio button
                  onChanged: (value){
                    
                  },
                  title: Text('Price Low to High'),
                ),
                RadioListTile(
                  value: 'Price High to Low',// by default it is ascending
                  groupValue: 'group1',// it must be same then it will pick unique radio button
                  onChanged: (value){
                    
                  },
                  title: Text('Price High to Low'),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    Query query = DbOperations.fetchProducts();

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround, //to align the buttons
            children: [
              //for flatbutton with icon use FlatButton.icon
              //FlatButton - doesnot have icon and label
              FlatButton.icon(
                onPressed: () {
                  _displayBottomSheet();
                },
                icon: Icon(Icons.sort),
                label: Text('Sort'),
              ),
              // or use VerticalDivider
              Container(
                width: 2,
                height: 10,
                color: Colors.blueGrey,
              ),

              FlatButton.icon(
                onPressed: () {
                  _displayBottomSheet();
                },
                icon: Icon(Icons.filter),
                label: Text('Filter'),
              ),

              Divider(
                color: Colors.blueGrey,
                height: 20,
                thickness: 3,
              ),
              Expanded(
                child: StreamBuilder(
                  // it works on contineous real time data
                  // it is a list of Future
                  stream: query.snapshots(), //this opens up a stream of data
                  // :: snapshots() gives Stream<QuerySnapshot>

                  builder: (BuildContext ctx, AsyncSnapshot stream) {
                    //i.e. it is giving a stream of data
                    if (stream.connectionState == ConnectionState.waiting) {
                      // i.e. it is waiting for the data and data hasn't been received
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (stream.hasError) {
                      return Center(
                        child: Text(
                          'Some Error Occur',
                          style: TextStyle(fontSize: 24, color: Colors.red),
                        ),
                      );
                    }
                    // now if any of the above condition isn't satisfied then data has come
                    // i.e. getting the data using stream.data and this data is QuerySnapshot
                    QuerySnapshot querySnapshot = stream.data;
                    // stream has other arguments - connectionState{Type - ConnectionState}, error{Type Object}
                    // QuerySnapshot have a size
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: deviceSize.width /
                            deviceSize
                                .height, //this is very important if size is greater then it auto adjust them
                        // ::: it will be proportionate according to device size
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot documentSnapshot = querySnapshot.docs[
                            index]; //we get current document - this is row or a document
                        Map<String, dynamic> dataMap = documentSnapshot
                            .data(); // it gives a key:value pair - > it is always a map -> inside of a document
                        Product product = Product();
                        product.name = dataMap['name'];
                        product.imagePath = dataMap['image'];
                        product.desc = dataMap['desc'];
                        product.price = dataMap['price'];

                        return Card(
                          child: Column(
                            children: [
                              Image.network(product.imagePath),
                              Text(product.name),
                              Text(product.desc),
                              // Text(product.price
                              //     .toString()), //since price is of double
                              Text(
                                  '\u{20B9} ${numberFormat.format(product.price.toString())}'),
                              // or ctrl+alt+4 - ₹
                              //for rupees sign - '\u{20B9}
                            ],
                          ),
                        );
                      },
                      itemCount: querySnapshot.size,
                    );
                  },
                ),
                /*
                StreamBuilder is a [subscriber] of the Stream
                Firebase is [Publisher] of the Stream - i.e. it gives a stream of data

                When the Fireabase publishes the stream it is listened by StreamBuilder for the data
                and since it is contineous any change in data is reflected on realtime

                StreamBuilder is a type of Pub_Subscribe in Flutter which is created in RX Programming
                */
              )
            ],
          ),
        ],
      ),
    );
  }
}
