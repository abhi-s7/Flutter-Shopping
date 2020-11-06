import 'package:flipkartClone/db/dbOperations.dart';
import 'package:flipkartClone/models/product.dart';
import 'package:flipkartClone/models/menu.dart';
import 'package:flipkartClone/utils/constants.dart';
import 'package:flipkartClone/utils/gps.dart';
import 'package:flipkartClone/widgets/category_widget.dart';
import 'package:flipkartClone/widgets/deals2.dart';
//import 'package:flipkartClone/widgets/deals_widget.dart';
import 'package:flipkartClone/widgets/menu_widget.dart';
import 'package:flipkartClone/widgets/slider_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _appBar() {
    return AppBar(
      backgroundColor: Color(Constant.FLIPKART_BLUE),
      //title  -Flipkart plus logo
      //leading - menu icon
      //action - icons for notication and cart
      title: Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Image.asset(
          Constant.FLIPKART_PLUS_LOGO,
          width: deviceSize.width / 3,
          height: deviceSize.height / 6,
        ),
      ),
      //leading: Icon(Icons.menu),//otherwise it will not be clickable as Drawer has it's own menu icon
      actions: [
        Icon(Icons.notifications),
        Padding(
            padding: EdgeInsets.only(right: 20, left: 20),
            child: Icon(Icons.shopping_cart))
      ],

      //now for the customazation to embedd the search bar increase the size of the appbar
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(deviceSize.height / 9),
        child: Container(
          padding: EdgeInsets.all(8),
          child: Container(
            //as the search bar in inside blue color box
            color: Colors.white,
            alignment: Alignment.center,
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  /*
                  Icon is not a string value it have hex code
                  If we want to create dynamic icon therefore use IconData as it contain numeric code for each Icon to be processed
                  */
                  hintText: 'Search For Porducts, Brands and More'),
            ),
          ),
        ),
        //this will make a more space to the the appbar vertically
      ),
    );
  }

  List<Menu> menus = [];
  //List<double> loc = []; because it just give lat and long
  String loc = '';
  List<Product> ads = [];
  List<Product> categories = [];
  List<Product> deals = [];

  @override
  void initState() {
    //initState is by default of void nature
    //but async needs something to be returned as a future
    super.initState();
    //menus = await DbOperations.fetchMenus();
    //also we cannot call setStates here
    _loadThings();
  }

  _loadThings() async {
    menus = await DbOperations.fetchMenus();
    print(menus);
    loc = await getLocation(); //it just gives the lat and lon not the city name
    ads = await DbOperations.fetchAds();
    print(ads);
    categories = await DbOperations.fetchCategories();
    deals = await DbOperations.fetchDeals();

    //otherwise we can use promise and it will not create Callback hell as it is not nested
    //because they all are seperate methods
    setState(() {
      //to rebuild the screen after getting menus
      //and it is not mandetory to put the ads loc menus in setState
      //because when specified setState it automatically re-renders
    });
  }

  Size deviceSize;
  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: MenuWidget(menus,
            loc), //data is coming from dbOperations thus call it in initState
      ),
      appBar: _appBar(),
      body: ListView(//to make a scrollable effect
          children: [
        SliderWidget(ads),
        CategoryWidget(categories),
        //DealsWidget(deals)
        DealsWidget(deals)
      ]),
    );
  }
}

/*
      Database - 
      1. Drawer Menu
      2. Customer - Products
      3. Categories
      
    */
