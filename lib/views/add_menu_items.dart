import 'dart:io';

import 'package:antiq/models/menu_items.dart';
import 'package:flutter/material.dart';

import 'package:antiq/utils/auth/auth_handler.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/forms/validators.dart';

class AddMenuItems extends StatefulWidget {
  @override
  _AddMenuItemsState createState() => _AddMenuItemsState();
}

class _AddMenuItemsState extends State<AddMenuItems> {
  String _categoryName, _itemName, _description, _imagePath;
  bool _isVeg, _autoValidate = false, _isNetworkCall = false;
  double _price;
  final _customizablesWidgets = <Widget>[];
  final List<String> _customizablesName = [];
  final List<double> _customizablesPrice = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final picker = ImagePicker();

  Future getImagefromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    Navigator.of(context).pop();
    setState(() {
      if (pickedFile != null) _imagePath = pickedFile.path;
    });
  }

  Future getImagefromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    Navigator.of(context).pop();
    setState(() {
      if (pickedFile != null) _imagePath = pickedFile.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Add Menu Item'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              authHandler.signOut();
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    //     // Category name field to be added
                                    //     // temp code start
                                    Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Category Name',
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.green),
                                          ),
                                        ),
                                        keyboardType: TextInputType.text,
                                        validator: validator.validateStrings,
                                        onSaved: (newValue) =>
                                            _categoryName = newValue,
                                      ),
                                    ),
                                    //     // end

                                    Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Item Name',
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.green),
                                          ),
                                        ),
                                        keyboardType: TextInputType.text,
                                        validator: validator.validateStrings,
                                        onSaved: (newValue) =>
                                            _itemName = newValue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 5),
                              GestureDetector(
                                onTap: () => _presentBottomSheet(context),
                                child: Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.5),
                                    image: DecorationImage(
                                      image: _imagePath == null
                                          ? AssetImage(
                                              'assets/icons/addImage.png')
                                          : FileImage(File(_imagePath)),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          maxLength: 100,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          validator: validator.validateDescription,
                          onSaved: (newValue) => _description = newValue,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixText: '\u20B9 ',
                            labelText: 'Item Price',
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          validator: validator.validatePrice,
                          onSaved: (newValue) => _price = double.parse(newValue),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Choose food type',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Wrap(
                            children: [
                              FilterChip(
                                label: Text('Veg'),
                                labelStyle: TextStyle(
                                    color: _isVeg != null
                                        ? _isVeg ? Colors.white : Colors.black
                                        : Colors.black),
                                selected: _isVeg != null ? _isVeg : false,
                                onSelected: (bool selected) {
                                  setState(() {
                                    _isVeg = true;
                                  });
                                },
                                selectedColor: Colors.green,
                                checkmarkColor: Colors.white,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              FilterChip(
                                label: Text('non-veg'),
                                labelStyle: TextStyle(
                                    color: _isVeg != null
                                        ? !_isVeg ? Colors.white : Colors.black
                                        : Colors.black),
                                selected: _isVeg != null ? !_isVeg : false,
                                onSelected: (bool selected) {
                                  setState(() {
                                    _isVeg = false;
                                  });
                                },
                                selectedColor: Colors.red[400],
                                checkmarkColor: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                      ),
                      SizedBox(height: 5),
                      // Customizables
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          _customizablesWidgets.length,
                          (index) {
                            bool flag =
                                index == _customizablesWidgets.length - 1;
                            return Card(
                              elevation: 3.0,
                              child: Column(
                                children: [
                                  Container(
                                    color: Colors.green,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Customizable detail',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.cancel,
                                              color: flag
                                                  ? Colors.white
                                                  : Colors.transparent,
                                            ),
                                            onPressed: flag
                                                ? () {
                                                    setState(() {
                                                      _customizablesWidgets
                                                          .removeLast();
                                                      _customizablesName
                                                          .removeLast();
                                                      _customizablesPrice
                                                          .removeLast();
                                                    });
                                                  }
                                                : null,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  _customizablesWidgets[index],
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 15),
                      OutlineButton.icon(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        borderSide: BorderSide(color: Colors.green, width: 1.8),
                        splashColor: Colors.greenAccent,
                        icon: Icon(Icons.add),
                        label: Text('Customizables'),
                        onPressed: () {
                          setState(() {
                            _customizablesWidgets.add(customizableItemField(
                                _customizablesWidgets.length));
                            _customizablesName.add('');
                            _customizablesPrice.add(0.0);
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      _isNetworkCall
                          ? Container(
                              height: 45.0,
                              width: 300,
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(),
                            )
                          : Container(
                              height: 45,
                              width: 300,
                              child: MaterialButton(
                                splashColor: Colors.white30,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                color: Theme.of(context).primaryColor,
                                elevation: 5.0,
                                child: Center(
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    if (_isVeg == null) {
                                      _scaffoldKey.currentState
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                        'Food type must be selected',
                                        style: TextStyle(color: Colors.yellow),
                                      )));
                                    } else if (_imagePath == null) {
                                      _scaffoldKey.currentState
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                        'Select an image by pressing on it',
                                        style: TextStyle(color: Colors.yellow),
                                      )));
                                    } else {
                                      _formKey.currentState.save();
                                      menuItem.addMenuItem(
                                          _categoryName,
                                          _itemName,
                                          _description,
                                          _imagePath,
                                          _price,
                                          _isVeg,
                                          _customizablesName,
                                          _customizablesPrice);
                                      print('validated');
                                    }
                                  } else {
                                    setState(() {
                                      _autoValidate = true;
                                    });
                                  }
                                },
                              ),
                            ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customizableItemField(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Customizable Name',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
            ),
            keyboardType: TextInputType.text,
            validator: validator.validateStrings,
            onSaved: (newValue) => _customizablesName[index] = newValue,
          ),
          TextFormField(
            decoration: InputDecoration(
              prefixText: '\u20B9 ',
              labelText: 'Customizable Price',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
            ),
            validator: validator.validatePrice,
            keyboardType: TextInputType.number,
            onSaved: (newValue) =>
                _customizablesPrice[index] = double.parse(newValue),
          ),
        ],
      ),
    );
  }

  void _presentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: <Widget>[
          SizedBox(height: 8),
          _buildBottomSheetRow(
            context,
            Icons.camera_alt,
            'Take Photo',
            getImagefromCamera,
          ),
          _buildBottomSheetRow(
            context,
            Icons.image,
            'Choose from Gallery',
            getImagefromGallery,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheetRow(
    BuildContext context,
    IconData icon,
    String text,
    Function ontap,
  ) =>
      InkWell(
        onTap: ontap,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Icon(
                icon,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(width: 8),
            Text(text),
          ],
        ),
      );
}
