import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

// Future<List<double>> getLocation() async{
Future<String> getLocation() async {
  Position position = await Geolocator.getCurrentPosition(
      //getCurrentPosition gives future of Position
      desiredAccuracy: LocationAccuracy.high);
  print('Lat ${position.latitude}');
  print('Lon ${position.longitude}');

  // converting it into the country ?
  Coordinates cord = Coordinates(position.latitude, position.longitude);
  // TODO: Write description

  List<Address> list = await Geocoder.local.findAddressesFromCoordinates(cord);
  Address address = list.first;
  String fullAddress = '${address.countryName} ${address.countryCode}';
  //it maintains its own database according to lat and long
  //best api is google maps but it is paid

  // return {'logitude': position.longitude, 'latitude':position.latitude};
  //either map or list
  //::::::::://return [position.longitude, position.latitude];
  //longitutde and latitude are in double

  print('FullAddress : $fullAddress');
  return fullAddress; //String is wrapped under the future
}
