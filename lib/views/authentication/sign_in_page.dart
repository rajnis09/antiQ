import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../../routes/routes.dart';
import '../../widgets/logo_widget.dart';
import '../../widgets/custom_button.dart';
import '../../utils/theme/theme_data.dart';
import '../../utils/forms/validators.dart';
import '../../utils/auth/auth_handler.dart';
import '../../widgets/all_Alert_Dialogs.dart';
import '../../providers/profile_provider.dart';
import '../../providers/menu_items_provider.dart';
import '../../utils/forms/registration_form.dart';
import '../../utils/database/profile_database_handler.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with TickerProviderStateMixin {
  AnimationController _phoneNumberController;
  Animation<Offset> _phoneNumberOffset;
  AnimationController _otpController;
  Animation<Offset> _otpOffset;
  TextEditingController _phoneNumberTextEditingController =
      TextEditingController();
  TextEditingController _otpTextEditingController = TextEditingController();
  final GlobalKey<FormState> _phoneFormKey = GlobalKey<FormState>();
  bool _autovalidate = false, _isNetworkCall = false;
  int _currentActive = 1;
  String _phoneNumber, _verificationId;

  @override
  void initState() {
    super.initState();
    _phoneNumberController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _phoneNumberOffset =
        Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 1.0))
            .animate(_phoneNumberController);
    _otpController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _otpOffset = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
        .animate(_otpController);

    _phoneNumberController.addStatusListener((status) {
      if (_currentActive == 1) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _currentActive = 0;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ProfileServiceProvider provider =
        Provider.of<ProfileServiceProvider>(context);
    final menuProvider = Provider.of<MenuItemsProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.16),
                LogoWidget(),
                SizedBox(height: size.height * 0.05),
                Text('Intro will be added Here'),
                SizedBox(height: size.height * 0.05),
                Container(
                  child: CustomButton(
                    disabledColor: CustomThemeData.greyColorShade,
                    height: size.height * 0.055,
                    width: size.width * 0.7,
                    child: Text(
                      'Tap Here to continue',
                      style: CustomThemeData.robotoFont.copyWith(
                        fontSize: size.width * 0.038,
                        color: CustomThemeData.whiteColor,
                      ),
                    ),
                    onPressed: () {
                      _phoneNumberController.reverse();
                      setState(() {
                        _currentActive = 1;
                      });
                    },
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
          Stack(
            children: [
              _currentActive != 0
                  ? Container(
                      height: size.height,
                      width: double.infinity,
                      color: Colors.black54,
                    )
                  : Container(),
              Align(
                alignment: Alignment.bottomCenter,
                child: SlideTransition(
                  position: _phoneNumberOffset,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(size.width * 0.1),
                        topRight: Radius.circular(size.width * 0.1),
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: size.height * 0.02),
                        Container(
                          alignment: Alignment.center,
                          width: size.width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Enter Mobile Number to Continue',
                                textAlign: TextAlign.start,
                                style: CustomThemeData.robotoFont.copyWith(
                                  fontSize: size.height * 0.022,
                                  fontWeight: FontWeight.bold,
                                  color: CustomThemeData.blackColorShade1,
                                ),
                              ),
                              IconButton(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  icon: Icon(
                                    Icons.clear,
                                    color: CustomThemeData.blueColorShade1,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    _phoneFormKey.currentState.reset();
                                    setState(() {
                                      _phoneNumberTextEditingController.clear();
                                      _autovalidate = false;
                                    });
                                    _phoneNumberController.forward();
                                  }),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                          child: Form(
                            key: _phoneFormKey,
                            autovalidate: _autovalidate,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _phoneNumberTextEditingController,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.phone,
                                      color: CustomThemeData.blackColorShade2,
                                    ),
                                    prefixText: '+91 ',
                                    suffixIcon: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          end: 8.0),
                                      child: Container(
                                        height: size.width * 0.03,
                                        width: size.width * 0.03,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/icons/india.png'),
                                              fit: BoxFit.contain),
                                        ),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                          color:
                                              CustomThemeData.blackColorShade2,
                                          width: 2.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                          color:
                                              CustomThemeData.blackColorShade2,
                                          width: 2.0),
                                    ),
                                    labelText: 'Mobile Number',
                                    hintText: 'Mobile Number',
                                  ),
                                  validator: validator.validatePhoneNumber,
                                  onSaved: (newValue) =>
                                      _phoneNumber = newValue,
                                  keyboardType: TextInputType.phone,
                                ),
                                SizedBox(height: size.height * 0.01),
                                SizedBox(height: 15),
                                _isNetworkCall
                                    ? Container(
                                        height: size.height * 0.055,
                                        alignment: Alignment.center,
                                        child: CircularProgressIndicator(),
                                      )
                                    : Container(
                                        child: CustomButton(
                                          disabledColor:
                                              CustomThemeData.greyColorShade,
                                          height: size.height * 0.055,
                                          width: size.width * 0.7,
                                          child: Text(
                                            'Continue',
                                            style: CustomThemeData.robotoFont
                                                .copyWith(
                                              fontSize: size.width * 0.038,
                                              color: CustomThemeData.whiteColor,
                                            ),
                                          ),
                                          onPressed: () async {
                                            FocusScope.of(context).unfocus();
                                            if (_phoneFormKey.currentState
                                                .validate()) {
                                              setState(() {
                                                _isNetworkCall = true;
                                              });
                                              print(
                                                  _phoneNumberTextEditingController
                                                      .text);
                                              int result =
                                                  await profileDataBaseHandler
                                                      .nextRoute(
                                                          _phoneNumberTextEditingController
                                                              .text);
                                              if (result == 0) {
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                        builder: (context) =>
                                                            Registration(
                                                                phoneNumber:
                                                                    _phoneNumberTextEditingController
                                                                        .text),
                                                        fullscreenDialog: true))
                                                    .then((value) {
                                                  print('he value is $value');
                                                  if (value != null) {
                                                    _phoneFormKey.currentState
                                                        .save();
                                                    print(
                                                        'Validated +91$_phoneNumber');
                                                    _phoneNumberLogin(
                                                        provider, menuProvider);
                                                  } else {
                                                    setState(() {
                                                      _isNetworkCall = false;
                                                    });
                                                  }
                                                });
                                              } else if (result == 2) {
                                                _phoneFormKey.currentState
                                                    .reset();
                                                notificationDialog(
                                                    context,
                                                    'Error',
                                                    'You are a Customer\nPlease use Everly app');
                                                setState(() {
                                                  _isNetworkCall = false;
                                                });
                                              } else {
                                                _phoneFormKey.currentState
                                                    .save();
                                                print(
                                                    'Validated +91$_phoneNumber');
                                                _phoneNumberLogin(
                                                    provider, menuProvider);
                                              }
                                            } else {
                                              setState(() {
                                                _autovalidate = true;
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                SizedBox(height: 5),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SlideTransition(
                  position: _otpOffset,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(size.width * 0.1),
                        topRight: Radius.circular(size.width * 0.1),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: size.height * 0.02),
                        Container(
                          alignment: Alignment.center,
                          width: size.width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Enter OTP sent to your number',
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: CustomThemeData.robotoFont.copyWith(
                                  fontSize: size.height * 0.022,
                                  fontWeight: FontWeight.bold,
                                  color: CustomThemeData.blackColorShade1,
                                ),
                              ),
                              IconButton(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  tooltip: 'Back',
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: CustomThemeData.blueColorShade1,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    _phoneNumberController.reverse();
                                    _otpController.reverse();
                                    _currentActive = 1;
                                  }),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _otpTextEditingController,
                                enableSuggestions: false,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(6),
                                ],
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: CustomThemeData.blackColorShade2,
                                  ),
                                  labelText: 'OTP',
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                        color: CustomThemeData.blackColorShade2,
                                        width: 2.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                        color: CustomThemeData.blackColorShade2,
                                        width: 2.0),
                                  ),
                                  hintText: 'Enter OTP',
                                ),
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(height: 15),
                              _isNetworkCall
                                  ? Container(
                                      height: size.height * 0.055,
                                      alignment: Alignment.center,
                                      child: CircularProgressIndicator(),
                                    )
                                  : Container(
                                      child: CustomButton(
                                        disabledColor:
                                            CustomThemeData.greyColorShade,
                                        height: size.height * 0.055,
                                        width: size.width * 0.7,
                                        child: Text(
                                          'Log In',
                                          style: CustomThemeData.robotoFont
                                              .copyWith(
                                            fontSize: size.width * 0.038,
                                            color: CustomThemeData.whiteColor,
                                          ),
                                        ),
                                        onPressed: () async {
                                          FocusScope.of(context).unfocus();
                                          setState(() {
                                            _isNetworkCall = true;
                                          });
                                          print('In verification');
                                          print(
                                              'code is ${_otpTextEditingController.text}');
                                          AuthCredential credential =
                                              PhoneAuthProvider.credential(
                                            verificationId: _verificationId,
                                            smsCode:
                                                _otpTextEditingController.text,
                                          );
                                          int response = await authHandler
                                              .phoneUserLoginOrRegister(
                                                  credential);
                                          print('Response is $response');
                                          switch (response) {
                                            case 0:
                                              await provider
                                                  .fetchLatestProfile();
                                              menuProvider.setMenuDBHandler(
                                                  provider.profile.shop
                                                      .phoneNumber);
                                              Navigator.pushReplacementNamed(
                                                  context, Routes.homePage);
                                              break;
                                            case 1:
                                              await provider.createSeller();
                                              menuProvider.setMenuDBHandler(
                                                  provider.profile.shop
                                                      .phoneNumber);
                                              Navigator.pushReplacementNamed(
                                                  context, Routes.homePage);
                                              break;
                                            case 2:
                                              notificationDialog(
                                                  context,
                                                  'Error',
                                                  'The Account exists with different credentials');
                                              break;
                                            case 3:
                                              notificationDialog(
                                                  context,
                                                  'Error',
                                                  'Invalid Credentials');
                                              break;
                                            case 4:
                                              notificationDialog(
                                                  context,
                                                  'Error',
                                                  'The Account is disabled\nContact support team');
                                              break;
                                            case 5:
                                              notificationDialog(
                                                  context,
                                                  'Error',
                                                  'This operation is not allowed');
                                              break;
                                            case 6:
                                              notificationDialog(
                                                  context,
                                                  'Error',
                                                  'The verification code is invalid\nTry again');
                                              break;
                                            case 7:
                                              notificationDialog(
                                                  context,
                                                  'Error',
                                                  'Phone Number verification failed, Try Again');
                                              break;
                                            default:
                                              notificationDialog(
                                                  context,
                                                  'Error',
                                                  'Contact support team');
                                              break;
                                          }
                                          setState(() {
                                            _isNetworkCall = false;
                                          });
                                        },
                                      ),
                                    ),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _phoneNumberLogin(
      ProfileServiceProvider provider, MenuItemsProvider menuProvider) async {
    int response = 0;
    await authHandler.auth.verifyPhoneNumber(
      phoneNumber: '+91$_phoneNumber',
      timeout: Duration(seconds: 60),
      verificationCompleted: (credential) async {
        print('verified');
        setState(() {
          _isNetworkCall = true;
        });
        response = await authHandler.phoneUserLoginOrRegister(credential);
        print('Response is in verification completed $response');
        switch (response) {
          case 0:
            await provider.fetchLatestProfile();
            menuProvider.setMenuDBHandler(provider.profile.shop.phoneNumber);
            Navigator.pushReplacementNamed(context, Routes.homePage);
            break;
          case 1:
            await provider.createSeller();
            menuProvider.setMenuDBHandler(provider.profile.shop.phoneNumber);
            Navigator.pushReplacementNamed(context, Routes.homePage);
            break;
          case 2:
            notificationDialog(context, 'Error',
                'The Account exists with different credentials');
            break;
          case 3:
            notificationDialog(context, 'Error', 'Invalid Credentials');
            break;
          case 4:
            notificationDialog(context, 'Error',
                'The Account is disabled\nContact support team');
            break;
          case 5:
            notificationDialog(
                context, 'Error', 'This operation is not allowed');
            break;
          case 6:
            notificationDialog(
                context, 'Error', 'The operation code is invalid');
            break;
          case 8:
            notificationDialog(context, 'Error',
                'Phone Number verification failed, Try later');
            break;
          default:
            notificationDialog(context, 'Error', 'Contact support team');
            break;
        }
        setState(() {
          _isNetworkCall = false;
        });
      },
      verificationFailed: (exception) async {
        print(
            'Phone Number Verification failed with ${exception.code} and ${exception.message} with ${exception.phoneNumber}');
        notificationDialog(context, 'Error',
            'Phone Number verification failed \n${exception.message}');
        setState(() {
          _isNetworkCall = false;
        });
      },
      codeSent: (verificationId, forceResendingToken) {
        _verificationId = verificationId;
        print('code Sent');
        _phoneNumberController.forward();
        _currentActive = 2;
        _otpController.forward();
        setState(() {
          _isNetworkCall = false;
        });
      },
      codeAutoRetrievalTimeout: (verificationId) {
        print('Auto Retrieval failed');
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _phoneNumberTextEditingController.dispose();
    _phoneNumberController.dispose();
    _otpTextEditingController.dispose();
    _otpController.dispose();
  }
}
