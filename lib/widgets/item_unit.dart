import 'package:flutter/material.dart';

import 'all_Alert_Dialogs.dart';
import 'cached_donwloadable_image.dart';
import 'food_type_icon.dart';
import 'icon_label_button.dart';
import '../models/item_model.dart';

class ItemUnit extends StatefulWidget {
  const ItemUnit({
    Key key,
    @required this.itemName,
    @required this.price,
    @required this.imageURL,
    @required this.isVeg,
    this.customizables,
  }) : super(key: key);

  final String itemName;
  final double price;
  final String imageURL;
  final bool isVeg;
  final List<Customizables> customizables;

  @override
  _ItemUnitState createState() => _ItemUnitState();
}

class _ItemUnitState extends State<ItemUnit> {
  static const double CONTAINER_HEIGHT = 85;
  var _isEditMode = false;

  void _toggleEditMode() {
    setState(() {
      _isEditMode = !_isEditMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      padding: const EdgeInsets.all(2),
      height: CONTAINER_HEIGHT,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(0, 1.5),
            color: Colors.grey.shade300,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: _isEditMode ? _buildItemOptions() : _buildItem(mediaQuery),
    );
  }

  Widget _buildItem(MediaQueryData mediaQuery) => Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        clipBehavior: Clip.antiAlias,
        color: Colors.transparent,
        child: InkWell(
          onLongPress: _toggleEditMode,
          splashColor: Colors.grey.shade200,
          child: Row(
            children: <Widget>[
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                  // image: DecorationImage(
                  //   image: FileImage(File(widget.imageURL)),
                  //   fit: BoxFit.cover,
                  // ),
                ),
                height: CONTAINER_HEIGHT,
                width: CONTAINER_HEIGHT,
                child: cachedDownloadableImage(
                  imageURL: widget.imageURL,
                  height: CONTAINER_HEIGHT,
                  width: CONTAINER_HEIGHT,
                  fit: BoxFit.cover,
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width:
                                mediaQuery.size.width - CONTAINER_HEIGHT - 60,
                            child: Text(
                              widget.itemName,
                              style: TextStyle(
                                fontSize: 17,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          FoodTypeIcon(
                            color: widget.isVeg ? Colors.green : Colors.red,
                            size: 14,
                          ),
                        ],
                      ),
                      Divider(
                        height: 8.0,
                        color: Colors.transparent,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '\u20B9${widget.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Text(
                            widget.customizables.length > 0
                                ? 'Customized'
                                : 'Non Customized',
                            style: TextStyle(
                              fontSize: 14,
                              color: widget.customizables.length > 0
                                  ? Colors.orange
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildItemOptions() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconLabelButton(
            icon: Icons.edit,
            label: 'Edit',
            color: Colors.blue,
            onPressed: () {
              // TODO: Perform edit operation and then PUT into database
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Item Edit Sucessfully'),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {},
                  ),
                  duration: Duration(
                    seconds: 1,
                  ),
                ),
              );
            },
          ),
          IconLabelButton(
              icon: Icons.schedule,
              label: 'Auto Accept',
              color: Colors.orange,
              onPressed: () {
                // TODO: PUT changed time into databse
                scheduleDialog(context).then(
                  (value) {
                    if (value != null && value)
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Scheduled Sucessfully'),
                          duration: Duration(
                            seconds: 1,
                          ),
                        ),
                      );
                  },
                );
              }),
          IconLabelButton(
            icon: Icons.arrow_back,
            label: 'Back',
            onPressed: _toggleEditMode,
          ),
        ],
      );
}
