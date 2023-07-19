import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class MyOtp extends StatefulWidget {
  const MyOtp({Key? key}) : super(key: key);

  @override
  State<MyOtp> createState() => _MyOtpState();
}

class _MyOtpState extends State<MyOtp> {
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Scaffold(
        body: Container(
      margin: EdgeInsets.only(left: 25, right: 25),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            'assets/banner.jpg',
            height: 150,
            width: 150,
          ),
          SizedBox(
            height: 25,
          ),
          Text("Sign Up/ Sign In ",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 10,
          ),
          Text(
            "Welcome to the world of Guessing !",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Pinput(
            showCursor: true,
          ),
          SizedBox(height: 20),
          SizedBox(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Verify Phone Number"),
                style: ElevatedButton.styleFrom(
                    primary: Colors.green.shade600,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
              )),
          SizedBox(height: 15),
          Row(
            children: [
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "Resend the OTP ?",
                    style: TextStyle(color: Colors.black),
                  )),
              SizedBox(width: 50),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, '/phone');
                  },
                  child: Text(
                    "Go Back >",
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          )
        ]),
      ),
    ));
  }
}

//FingerPrint Not added due to .gradlew file not found
// COMMAND (cd to android folder ) : ./gradlew signingReport
//Add SHA1 and SHA256 fingerprint generated on terminal in firebase project
