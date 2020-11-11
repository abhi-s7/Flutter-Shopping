import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Razorpay _razorpay; //it requried min sdk to be 19
  String msg = '';

  _payNow() {
    const options = {
      'key': 'rzp_test_fJN31j9uLhF7sW',
      'amount': '1000',
      'name': 'Brain Mentors',
      'description': 'Test Payment',
      'prefill': {
        //i.e. some of the information can be prefilled
        'contact': '8888888888',
        'email': 'test@razorpay.com'
      }
    };

    // 3. to make transaction
    _razorpay.open(options); //options must be a Map
  }

  _initiateRazorpay() {
    // 1. Instantiate razor pay object
    _razorpay = Razorpay();

    // 2. attact the handlers (callback) to various transactions events
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _successPayment);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _errorInPayment);
  }

  _errorInPayment(
      PaymentFailureResponse response) //::PaymentFailureResponse is a class
  {
    setState(() {
      msg = 'Payment Fail $response';
      print('Runtimetype of response ${response.runtimeType}');
    });
  }

  _successPayment(PaymentSuccessResponse response) {
    //response of Success will give paymentId and orderId and signature
    String payId = response.paymentId;
    String orderId = response.orderId;
    msg = 'Payment successs $payId $orderId';
  }

  @override
  void initState() {
    super.initState();
    _initiateRazorpay(); //this should be loaded at the time of initStates
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Razor Pay Demo',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Column(
        children: [
          RaisedButton(
            onPressed: () {
              _payNow();
            },
            child: Text('PayNow'),
          ),
          Text('Result of Transaction $msg'),
        ],
      ),
    );
  }
}
