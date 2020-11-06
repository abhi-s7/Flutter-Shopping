import 'package:flipkartClone/models/menu.dart';
import 'package:flipkartClone/utils/constants.dart';
import 'package:flutter/material.dart';

/*
Since Menu Data is fetched from server and when it is resolved then we have to render it on the screen
And menu_widget is whole sole responsible to display the information of the Menus 
so We have segregated this code 
*/
class MenuWidget extends StatelessWidget {
  List<Menu> menus = [];
  //List<double> loc = [];
  String loc;

  // MenuWidget(List<Menu> menus) {
  //   //menus i.e. data will be received from constructor
  //   this.menus = menus;
  // }
  MenuWidget(this.menus, this.loc);

  _getStyle(var size) {
    return TextStyle(fontSize: size, color: Colors.white);
  }

  Container _makeHeader() {
    return Container(
      color: Color(Constant.FLIPKART_BLUE),
      height: deviceSize.height / 10,
      child: Center(
        child: ListTile(
          leading: Icon(Icons.home_filled, color: Colors.white),
          title: Row(
            children: [
              Text('Home', style: _getStyle(20.0)),
              SizedBox(width: 10),
              Expanded(
                //IT WILL automatically adjust it according to available size otherwise would be overflowed due to the text size
                child: Text(
                  loc, //this is the String of location
                  // 'Lon: ${loc[0]} Lat: ${loc[1]}',
                  style: _getStyle(
                      12.0), //it should go in form of double otherwise it will give error
                ),
              )
            ],
          ),
          trailing: Image.asset(Constant.FLIPKART_LOGO),
        ),
      ),
    );
  }

  _makeBody() {
    //This is another listView inside the parent list view
    //thus it will give error as flutter doesnot support LIstView inside ListView and it will go boyond its size
    //Reason: The parent ListView will take whole available size and this ListView will also try to take whole of the size
    //thus rendering issue will come
    //Therefore it is mandate to use shrinkWrap: true as the property
    // it says the parent will wrap the child listview and it will not override the area of parent
    return ListView.builder(
        shrinkWrap: true,
        //because it will be creted dynamically according to the menu size
        itemCount: menus.length,
        itemBuilder: (BuildContext context, int index) {
          return _makeSingleMenu(index);
        });
  }

  Container _makeSingleMenu(int index) {
    //this will create one menu at a time
    int iconData = int.parse(menus[index].iconValue);
    //since iconValue is coming from firebase in form of String and IconData accepts int value

    return Container(
      child: ListTile(
        leading: Icon(
          IconData(iconData,
              fontFamily:
                  'MaterialIcons'), //1st arg - hexadecimal value 2nd arg - fontFamily
        ),
        title: Text(menus[index].name),
      ),
    );
  }

  Size deviceSize;
  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;

    return this.menus.length > 0
        //is menus comes then show the list otherwise show loading or waiting msg
        ? ListView(
            children: [_makeHeader(), _makeBody()],
          )
        : Container(
            child: Text('Waiting to load menus'),
          );
  }
}
