import 'package:flipkartClone/models/product.dart';
import 'package:flutter/material.dart';

class DealsWidget extends StatelessWidget {
  List<Product> deals = [];

  DealsWidget(this.deals);
  Size deviceSize;

  Container _buildSingleDeal(int index) {
    return Container(
      height: deviceSize.height / 8,
      child: Column(
        children: [
          Image.network(
            deals[index].imagePath,
            height: deviceSize.height / 5,
            width: deviceSize.width / 5,
          ),
          Text(deals[index].name),
          Text(deals[index].price ?? 900.toString()),
          //it price is null then make it 900
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          color: Colors.pink[100],
          //height should not be full screen just a portion of height
          height: deviceSize.height / 4,
        ),
        // Container(
        //   //this is to display the alarm clock

        //   padding: EdgeInsets.only(right: 10, top: 4, left: 10),
        //   width: deviceSize.width, //otherwise alignment won't work
        //   height: deviceSize.height / 10,
        //   alignment: Alignment.topCenter,
        //   child: Image.network(''),
        // ),
        // this will display the button to the right
        Container(
          alignment: Alignment.topRight,
          padding: EdgeInsets.all(20),
          child: MaterialButton(
            color: Colors.white,
            onPressed: () {},
            child: Text('View All'),
          ),
        ),

        //this will display the deals of the day and timer
        Positioned(
          top: deviceSize.height / 60,
          child: Column(
            //by default the cross axis alignment is center
            crossAxisAlignment: CrossAxisAlignment.start,

            //As there are two things
            //1. Deal of the day text
            //2. Timer
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Deals of the Day',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Row(
                //icons and text
                children: [
                  Icon(Icons.access_time),
                  Text('19H Remaining'),
                ],
              ),
              //to print the details dynamically
              //since it is column thus GridView will come last
              Container(
                width: deviceSize.width,
                height: deviceSize.height / 2,
                //since gridview is dynamic therefoe it will give RenderBox error
                //therefore give it widdth and height using container
                child: GridView.builder(
                  shrinkWrap: true,
                  // physics:
                  //     NeverScrollableScrollPhysics(), //this will make it non scrollable

                  //it can have bigger images as it is printing dynamically therefore fix the size of the content otherwise it would give error

                  gridDelegate: //tells how many things we want to show e.g. 2 items at a time
                      SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                  itemBuilder: (BuildContext ctx, int index) {
                    //here we are going to build this the deals dynamically
                    return _buildSingleDeal(index);
                  },
                  itemCount: deals.length,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
