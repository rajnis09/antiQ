import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import './validators.dart';
import '../theme/theme_data.dart';
import '../../widgets/custom_button.dart';
import '../../providers/profile_provider.dart';

class Registration extends StatefulWidget {
  final String phoneNumber;

  const Registration({Key key, this.phoneNumber}) : super(key: key);
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String _email,
      _name,
      _shopName,
      _shopOwnerName,
      _shopAddress,
      _shopDescription,
      _phoneNumber;
  bool _autoValidate = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileServiceProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Personal Details',
                textScaleFactor: 1.3,
                style: CustomThemeData.robotoFont
                    .copyWith(color: CustomThemeData.blackColorShade1),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: Column(
                  children: <Widget>[
                    _buildForm('Name', Icons.person, validator.validateStrings,
                        (val) => _name = val, TextInputType.text),
                    _buildForm('Email', Icons.email, validator.validateEmail,
                        (val) => _email = val, TextInputType.emailAddress),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        inputFormatters: [LengthLimitingTextInputFormatter(10)],
                        style: CustomThemeData.latoFont
                            .copyWith(color: Colors.grey),
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          prefixIcon: Icon(
                            Icons.phone,
                            color: CustomThemeData.blackColorShade2,
                          ),
                          prefix: Text("+91 "),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                                color: CustomThemeData.greyColorShade,
                                width: 2.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                                color: CustomThemeData.greyColorShade,
                                width: 2.0),
                          ),
                        ),
                        onSaved: (newValue) => _phoneNumber = newValue,
                        validator: validator.validatePhoneNumber,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Shop Details',
                        textScaleFactor: 1.3,
                        style: CustomThemeData.robotoFont
                            .copyWith(color: CustomThemeData.blackColorShade1),
                      ),
                    ),
                    SizedBox(height: 4),
                    _buildForm(
                        'Shop Name',
                        Icons.broken_image,
                        validator.isEmpty,
                        (val) => _shopName = val,
                        TextInputType.text),
                    _buildForm(
                        'Shop Owner Name',
                        Icons.person,
                        validator.validateStrings,
                        (val) => _shopOwnerName = val,
                        TextInputType.text),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        // enabled: false,
                        readOnly: true,
                        initialValue: widget.phoneNumber,
                        style: CustomThemeData.latoFont
                            .copyWith(color: Colors.grey),
                        decoration: InputDecoration(
                          labelText: 'Shop Phone Number',
                          prefixIcon: Icon(
                            Icons.phone,
                            color: CustomThemeData.greyColorShade,
                          ),
                          labelStyle: CustomThemeData.latoFont
                              .copyWith(color: Colors.grey),
                          prefix: Text("+91 "),
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
                        ),
                        validator: validator.validatePhoneNumber,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    _buildForm(
                        'Description',
                        Icons.assignment,
                        validator.isEmpty,
                        (val) => _shopDescription = val,
                        TextInputType.text),
                    _buildForm(
                        'Address',
                        Icons.location_city,
                        validator.isEmpty,
                        (val) => _shopAddress = val,
                        TextInputType.text),
                    SizedBox(height: size.height * 0.03),
                    CustomButton(
                      disabledColor: CustomThemeData.greyColorShade,
                      height: size.height * 0.055,
                      width: size.width * 0.7,
                      child: Text(
                        'Continue',
                        style: CustomThemeData.robotoFont.copyWith(
                          fontSize: size.width * 0.038,
                          color: CustomThemeData.whiteColor,
                        ),
                      ),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          provider.createNewSellerObject(
                              _name,
                              _email,
                              _phoneNumber,
                              _shopName,
                              _shopOwnerName,
                              widget.phoneNumber,
                              _shopDescription,
                              _shopAddress);
                          Navigator.of(context).pop(true);
                        } else {
                          setState(() {
                            _autoValidate = true;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(String title, IconData icon, Function validator,
      Function onSaved, TextInputType keyboardType) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: CustomThemeData.blackColorShade2,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide:
                BorderSide(color: CustomThemeData.blackColorShade2, width: 2.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide:
                BorderSide(color: CustomThemeData.blackColorShade2, width: 2.0),
          ),
          labelText: title,
          hintText: title,
        ),
        validator: validator,
        onSaved: onSaved,
        keyboardType: keyboardType,
      ),
    );
  }
}
