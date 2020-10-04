import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../models/item_model.dart';
import '../utils/forms/validators.dart';
import '../providers/profile_provider.dart';
import '../providers/menu_items_provider.dart';
import '../widgets/network_builder.dart';

class AddMenuItems extends StatefulWidget {
  @override
  _AddMenuItemsState createState() => _AddMenuItemsState();
}

class _AddMenuItemsState extends State<AddMenuItems> {
  String _categoryName,
      _itemName,
      _description,
      _imagePath,
      _dropdownValue,
      _type;
  bool _isVeg, _autoValidate = false, _isNetworkCall = false, _avail = false;
  double _price, _quantity, _availPrice;
  final _customizablesWidgets = <Widget>[];
  final _availabilityPrice = <double>[];
  final _availabilityQty = <double>[];
  final _availabilityType = <String>[];
  final List<String> _customizablesName = [];
  final List<double> _customizablesPrice = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final picker = ImagePicker();

  Future getImagefromCamera() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 60);
    Navigator.of(context).pop();
    setState(() {
      if (pickedFile != null) _imagePath = pickedFile.path;
    });
  }

  Future getImagefromGallery() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 60);
    Navigator.of(context).pop();
    setState(() {
      if (pickedFile != null) _imagePath = pickedFile.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileServiceProvider>(context);
    final menuItemsProvider = Provider.of<MenuItemsProvider>(context);
    return NetworkBuilder(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Add Menu Item'),
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
                                              borderSide: BorderSide(
                                                  color: Colors.green),
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
                                              borderSide: BorderSide(
                                                  color: Colors.green),
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
                            // maxLines: 2,
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
                            onSaved: (newValue) =>
                                _price = double.parse(newValue),
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
                                          ? !_isVeg
                                              ? Colors.white
                                              : Colors.black
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
                        SizedBox(height: 10),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: createWidgetList(
                            'Customizable detail',
                            _customizablesWidgets,
                            rest: [
                              _customizablesName,
                              _customizablesPrice,
                            ],
                          ).toList(),
                        ),
                        SizedBox(height: 15),
                        OutlineButton.icon(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          borderSide:
                              BorderSide(color: Colors.green, width: 1.8),
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
                        SizedBox(
                          height: 10,
                        ),

                        /// [Availabilities widget]
                        Column(
                          children: List.generate(
                            _availabilityType.length,
                            (index) {
                              final flag =
                                  index == _availabilityType.length - 1;
                              return Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(
                                    width: 2,
                                    color: Colors.green,
                                  ),
                                ),
                                child: ListTile(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          '${_availabilityQty[index].floor()} ${_availabilityType[index]}'),
                                      Text(
                                          '\u20B9 ${_availabilityPrice[index]}')
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      color: flag
                                          ? Colors.grey
                                          : Colors.transparent,
                                    ),
                                    onPressed: flag
                                        ? () {
                                            setState(() {
                                              // _availabilityWidgets.removeLast();
                                              _availabilityType.removeLast();
                                              _availabilityPrice.removeLast();
                                              _availabilityQty.removeLast();
                                            });
                                          }
                                        : null,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        /// [Availabilities form]
                        if (_avail)
                          Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.green,
                              ),
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  width: double.infinity,
                                  color: Colors.green,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Add Availabilities',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.cancel,
                                          color: Colors.white,
                                        ),
                                        onPressed: () =>
                                            setState(() => _avail = false),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      DropdownButton<String>(
                                        hint: Text('Select any value'),
                                        value: _dropdownValue,
                                        onChanged: (value) {
                                          setState(
                                              () => _dropdownValue = value);
                                        },
                                        selectedItemBuilder:
                                            (BuildContext context) {
                                          return [
                                            'Grams',
                                            'Plate',
                                            'Pieces',
                                            'Other'
                                          ].map<Widget>((String item) {
                                            return Text(item);
                                          }).toList();
                                        },
                                        items: [
                                          'Grams',
                                          'Plate',
                                          'Pieces',
                                          'Other'
                                        ].map((String item) {
                                          return DropdownMenuItem<String>(
                                            child: Text(item),
                                            value: item,
                                          );
                                        }).toList(),
                                      ),
                                      if (_dropdownValue == "Other")
                                        TextFormField(
                                          decoration: InputDecoration(
                                            labelText: 'Type',
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.green),
                                            ),
                                          ),
                                          validator: validator.validateStrings,
                                          onChanged: (value) =>
                                              setState(() => _type = value),
                                        ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Quantity',
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.green),
                                          ),
                                        ),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          final val = double.parse(value);
                                          validator.isEmpty(value);
                                          if (val == 0)
                                            return "Quantity cannot be 0";
                                          else if (val < 0)
                                            return "Quantity cannot be negative";

                                          return null;
                                        },
                                        onChanged: (value) => setState(() =>
                                            _quantity = double.parse(value)),
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          prefixText: '\u20B9 ',
                                          labelText: 'Availability Price',
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.green),
                                          ),
                                        ),
                                        validator: validator.validatePrice,
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) => setState(
                                          () =>
                                              _availPrice = double.parse(value),
                                        ),
                                      ),
                                      RaisedButton(
                                        onPressed: () {
                                          setState(() {
                                            _availabilityType.add(
                                                _dropdownValue == "Other"
                                                    ? _type
                                                    : _dropdownValue);
                                            _availabilityQty.add(_quantity);
                                            _availabilityPrice.add(_availPrice);
                                            _avail = false;
                                          });
                                        },
                                        child: Text('Add'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        // SizedBox(height: 5),
                        OutlineButton.icon(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          borderSide:
                              BorderSide(color: Colors.green, width: 1.8),
                          splashColor: Colors.greenAccent,
                          icon: Icon(Icons.add),
                          label: Text('Add Availabilities'),
                          onPressed: () {
                            setState(() {
                              _avail = true;
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
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        if (_isVeg == null) {
                                          _scaffoldKey.currentState
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                            'Food type must be selected',
                                            style:
                                                TextStyle(color: Colors.yellow),
                                          )));
                                        } else if (_imagePath == null) {
                                          _scaffoldKey.currentState
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Select an image by pressing on it',
                                                style: TextStyle(
                                                    color: Colors.yellow),
                                              ),
                                            ),
                                          );
                                        } else if (_availabilityQty.length ==
                                            0) {
                                          _scaffoldKey.currentState
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Availability can\'t be empty. Please add atleast one availability',
                                                style: TextStyle(
                                                    color: Colors.yellow),
                                              ),
                                            ),
                                          );
                                        } else {
                                          _formKey.currentState.save();
                                          final List<Customizables>
                                              customizables = [];
                                          final List<ItemAvailibilty>
                                              availabilities = [];
                                          for (int i = 0;
                                              i < _customizablesName.length;
                                              i++) {
                                            final item = Customizables(
                                              _customizablesName[i],
                                              _customizablesPrice[i],
                                            );
                                            customizables.add(item);
                                          }
                                          for (int i = 0;
                                              i < _availabilityQty.length;
                                              i++) {
                                            final item = ItemAvailibilty(
                                              _availabilityType[i],
                                              _availabilityQty[i],
                                              _availabilityPrice[i],
                                            );
                                            availabilities.add(item);
                                          }
                                          final item = Item(
                                            itemId:
                                                '${profileProvider.profile.shop.phoneNumber}${profileProvider.profile.menuItemsCounter + 1}',
                                            categoryName: _categoryName,
                                            itemName: _itemName,
                                            description: _description,
                                            // imageURL: _imagePath,
                                            imageURL:
                                                'https://www.fabhotels.com/blog/wp-content/uploads/2018/10/1000x650-29.jpg',
                                            isVeg: _isVeg,
                                            price: _price,
                                            customizables: customizables,
                                            differentAvailibility:
                                                availabilities,
                                          );
                                          // Adding item to the database using a unique key
                                          profileProvider.updateMenuCounter();
                                          menuItemsProvider.addMenuItem(item)
                                            ..then(
                                              (_) =>
                                                  Navigator.of(context).pop(),
                                            );
                                        }
                                      } else {
                                        setState(() {
                                          _autoValidate = true;
                                        });
                                      }
                                    }),
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
      ),
    );
  }

  List<Widget> createWidgetList(String title, List<Widget> widgetList,
          {List<List> rest}) =>
      List.generate(
        widgetList.length,
        (index) {
          bool flag = index == widgetList.length - 1;
          return Card(
            elevation: 3.0,
            child: Column(
              children: [
                Container(
                  color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.cancel,
                            color: flag ? Colors.white : Colors.transparent,
                          ),
                          onPressed: flag
                              ? () {
                                  setState(() {
                                    widgetList.removeLast();
                                    rest[0].removeLast();
                                    rest[1].removeLast();
                                  });
                                }
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
                widgetList[index],
              ],
            ),
          );
        },
      );

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
