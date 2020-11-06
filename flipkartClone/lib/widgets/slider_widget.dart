import 'package:carousel_pro/carousel_pro.dart';
import 'package:flipkartClone/models/product.dart';
import 'package:flutter/material.dart';

class SliderWidget extends StatelessWidget {
  List<Product> ads = [];

  SliderWidget(this.ads);

  Size deviceSize;
  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;

    return Container(
      //to display carousel
      width: deviceSize.width,
      height: deviceSize.height / 3,
      child: Carousel(
        dotSize: 5.0,
        dotBgColor: Colors.blueAccent,
        animationCurve: Curves.bounceInOut,
        animationDuration: Duration(seconds: 2),
        autoplay: true,
        borderRadius: true,
        //dotSpacing: 4.0,//it mergers all the dots
        onImageTap: (int currentSlideNumber) {
          //it gives unique image that is currently viewing
          print('current slide number $currentSlideNumber');
        },
        //predefined widget

        //to add teh images dynamically we need to manipulate the list of products to images
        //cannot use ListView.builder because it is a widget and Carousel is already a widget
        /*
        images: [
          //AssetImage is for perfect pixel ratio
          //When perfect pixel image is not known use ExactAssetImage
          //pixel is adjusted and it will take less memory
          //As due to small size pixel perfection is gone thus it will save memory as we are not loading whole pixels 

          //for local images use
          //ExactAssetImage('')
           NetworkImage(
              'https://www.france-hotel-guide.com/en/blog/wp-content/uploads/2017/02/paris-shopping.jpg'),
          NetworkImage(
              'https://i0.wp.com/www.paisawapas.com/blog/wp-content/uploads/2017/08/shoes-offers-snapdeal-below-499.jpg'),
          NetworkImage(
              'https://review.chinabrands.com/chinabrands/seo/image/20190219/dubaionlineshoppingsites.png'),
          NetworkImage(
              'https://li0.rightinthebox.com/images/dfp/202010/LITB_13080_thxgus5_en.gif')
        ],
        */
        images: (ads != null && ads.length > 0)
            ? ads.map((currentAd) => NetworkImage(currentAd.imagePath)).toList()//to list because it requires a list of images
            : [NetworkImage('https://codemyui.com/wp-content/uploads/2017/09/rotate-pulsating-loading-animation.gif')],
            //loading image
      ),
    );
  }
}
