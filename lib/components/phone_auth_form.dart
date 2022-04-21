import 'package:firebase_auth/firebase_auth.dart';
import 'package:girl_hackathon/app_theme.dart';
import 'package:girl_hackathon/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:girl_hackathon/utils/constants.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PhoneAuthForm extends StatefulWidget {
  PhoneAuthForm({Key? key}) : super(key: key);

  @override
  _PhoneAuthFormState createState() => _PhoneAuthFormState();
}

class _PhoneAuthFormState extends State<PhoneAuthForm> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController otpCode = TextEditingController();

  OutlineInputBorder border = OutlineInputBorder(
      borderSide: BorderSide(color: Constants.kBorderColor, width: 3.0));

  bool isLoading = false;
  bool stage = false;
  String? verificationId;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   title: Text("Sign In"),
        //   systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blue),
        // ),
        backgroundColor: Constants.kPrimaryColor,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.1,
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: height * 0.03,
                      left: width * 0.05,
                      right: width * 0.1),
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    "lib/images/logo.png",
                    width: 100,
                    height: 100,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                      top: height * 0.025,
                      bottom: height * 0.01,
                      left: width * 0.1,
                      right: width * 0.1),
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                        color: AppTheme.dark_grey,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1),
                  ),
                ),
                // SizedBox(
                //   height: height * 0.01,
                // ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin:
                      EdgeInsets.only(left: width * 0.1, right: width * 0.1),
                  child: Text(
                    '''Let's get started...''',
                    style: TextStyle(
                      color: AppTheme.dark_grey,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                (!stage)
                    ? SizedBox(
                        height: height * 0.05,
                      )
                    : Container(),
                (!stage)
                    ? Center(
                        child: SizedBox(
                          width: width * 0.8,
                          child: TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: phoneNumber,
                              decoration: InputDecoration(
                                labelText: "Enter Phone Number",
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: height * 0.035,
                                    horizontal: width * 0.025),
                                border: border,
                              )),
                        ),
                      )
                    : Container(),
                (stage)
                    ? SizedBox(
                        height: size.height * 0.05,
                      )
                    : Container(),
                (stage)
                    ? Center(
                        child: SizedBox(
                          width: width * 0.8,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: otpCode,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Enter OTP",
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: height * 0.035,
                                  horizontal: width * 0.025),
                              border: border,
                              suffixIcon: Padding(
                                child: FaIcon(
                                  FontAwesomeIcons.eye,
                                  size: 15,
                                ),
                                padding: EdgeInsets.only(top: 15, left: 15),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
                Padding(padding: EdgeInsets.only(bottom: size.height * 0.05)),
                !isLoading
                    ? SizedBox(
                        width: width * 0.8,
                        child: OutlinedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              if (!stage)
                                await phoneSignIn(
                                    phoneNumber: "+91"+phoneNumber.text);
                              if (stage) {
                                AuthService service = AuthService();
                                await service.signInWithPhone(
                                    verificationId!, otpCode.text);
                              }

                              // Navigator.pushNamedAndRemoveUntil(context, Constants.homeNavigate, (route) => false);
                            }
                          },
                          child: SizedBox(
                            width: width * 0.75,
                            height: height * 0.075,
                            child: Center(
                              child: Text(
                                'Sign in',
                                style: TextStyle(
                                    color: AppTheme.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1),
                              ),
                            ),
                          ),
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  AppTheme.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppTheme.blue),
                              side: MaterialStateProperty.all<BorderSide>(
                                  BorderSide.none)),
                        ),
                      )
                    : CircularProgressIndicator(),
              ],
            ),
          ),
        ));
  }

  void showMessage(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(errorMessage),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () async {
                  Navigator.of(builderContext).pop();
                },
              )
            ],
          );
        }).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> phoneSignIn({required String phoneNumber}) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: _onVerificationCompleted,
        verificationFailed: _onVerificationFailed,
        codeSent: _onCodeSent,
        codeAutoRetrievalTimeout: _onCodeTimeout);
  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    print("verification completed ${authCredential.smsCode}");

    setState(() {
      this.otpCode.text = authCredential.smsCode!;
    });
    if (authCredential.smsCode != null) {
      await FirebaseAuth.instance.signInWithCredential(authCredential);
      setState(() {
        isLoading = false;
      });
      Navigator.pushNamedAndRemoveUntil(
          context, Constants.homeNavigate, (route) => false);
    }
  }

  _onVerificationFailed(FirebaseAuthException exception) {
    if (exception.code == 'invalid-phone-number') {
      showMessage("The phone number entered is invalid!");
    }
  }

  _onCodeSent(String verificationId, int? forceResendingToken) {
    this.verificationId = verificationId;
    setState(() {
      isLoading = false;
      stage = true;
    });
    print(forceResendingToken);
    print("code sent");
  }

  _onCodeTimeout(String timeout) {
    return null;
  }
}
