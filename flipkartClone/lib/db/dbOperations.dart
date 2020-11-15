import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flipkartClone/models/menu.dart';
import 'package:flipkartClone/models/product.dart';

class DbOperations {
  _DbOperations() {} // this is required by firebase

  static Future<String> addProduct(Product product) async{
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('products');
    Map<String, dynamic> map = {

      "name": product.name,
      "desc": product.desc,
      "price":product.price,
      "image":product.imagePath,
    };
    //we get Document Reference
    DocumentReference docRef;
    try{
    docRef = await collectionReference.add(map);
    //::: add() method requires a map - Future<DocumentReference>

    }catch(e){
      return "Error in Record Add $e";
    }
    return 'Record added ${docRef.id}';
  }

  static Query fetchProducts() { //Future<List<Product>>
    Query query = FirebaseFirestore.instance.collection('products');
    String filterOrder = 'ascending';
    return query;
     
  }

  static Future<List<Menu>> fetchMenus() async {
    //:::::::Whenever async is used it should always return a Future

    List<Menu> menus = []; //to store all the menu object

    //static so that we won't have to make object of it
    QuerySnapshot querysnapshot =
        await FirebaseFirestore.instance.collection('menus').get();
    //as it gives a future
    querysnapshot.docs.forEach((doc) {
      //this gives one doc at one time
      //Therefore sotre it in an object
      //create a model for it to store JSON to Object
      //every doc represents one json
      Menu menu = Menu();
      menu.name = doc['name'];
      menu.url = doc['url'];
      menu.iconValue = doc['iconValue'];
      menu.status = doc['status'];
      //all the values must be same as that of in Firestore
      menus.add(menu);
    });
    return menus; //this will return as Future of List of Menu
  }

  static Future<List<Product>> fetchAds() async {
    List<Product> ads = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('ads').get();
    querySnapshot.docs.forEach((doc) {
      Product product = Product();
      product.name = doc['name'];
      product.url = doc['url'];
      product.imagePath = doc['imagePath'];
      ads.add(product);
    });
    print(ads);
    return ads;
  }

  static Future<List<Product>> fetchCategories() async {
    List<Product> category = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('categories').get();
    querySnapshot.docs.forEach((doc) {
      Product product = Product();
      product.name = doc['name'];
      product.url = doc['url'];
      product.imagePath = doc['image'];
      category.add(product);
    });
    return category;
  }

  static Future<List<Product>> fetchDeals() async {
    List<Product> deals = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('deals').get();
    querySnapshot.docs.forEach((doc) {
      Product product = Product();
      product.name = doc['name'];
      product.url = doc['url'];
      product.imagePath = doc['image'];
      deals.add(product);
      print(product);
    });

    return deals;
  }
}
