import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackernews/Login/splash_page.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OtpPage extends StatefulWidget {
  final String phone;
  OtpPage(this.phone);
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Colors.black12,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: Colors.white10,
    ),
  );

  @override
  void initState() {
    super.initState();
    _verifyPhone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Center(
              child: Text(
                'Verify +91-${widget.phone}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: PinPut(
              fieldsCount: 6,
              textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
              eachFieldWidth: 40.0,
              eachFieldHeight: 55.0,
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              submittedFieldDecoration: pinPutDecoration,
              selectedFieldDecoration: pinPutDecoration,
              followingFieldDecoration: pinPutDecoration,
              pinAnimationType: PinAnimationType.fade,
              onSubmit: (pin) async {
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: _verificationCode, smsCode: pin))
                      .then(
                    (value) async {
                      if (value.user != null) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SplashPage(),
                          ),
                          (route) => false,
                        );
                      }
                    },
                  );
                } catch (e) {
                  FocusScope.of(context).unfocus();
                  _scaffoldkey.currentState.showSnackBar(
                    SnackBar(
                      content: Text('Invalid OTP'),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91${widget.phone}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential).then(
          (value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => SplashPage(),
                ),
                (route) => false,
              );
            }
          },
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verficationID, int resendToken) {
        setState(() {
          _verificationCode = verficationID;
        });
      },
      codeAutoRetrievalTimeout: (String verificationID) {
        setState(() {
          _verificationCode = verificationID;
        });
      },
      timeout: Duration(seconds: 120),
    );
  }
}
