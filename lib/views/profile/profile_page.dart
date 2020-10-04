import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../../routes/routes.dart';
import '../../providers/profile_provider.dart';
import '../../models/profile_models.dart';
import '../../utils/auth/auth_handler.dart';
import '../../utils/theme/theme_data.dart';
import '../../models/list_profile_section.dart';
import '../../widgets/cached_donwloadable_image.dart';

class ProfilePage extends StatefulWidget {

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File _image;
  bool selected = false;
  bool isPersonal = true;
  String tag1, tag2;

  createSection(String title, IconData icon, Function onpressed) {
    return ListProfileSection(title, icon, onpressed);
  }

  final picker = ImagePicker();

  Future getImagefromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    Navigator.of(context).pop();

    setState(() {
      _image = File(pickedFile.path);
      selected = true;
    });
  }

  Future getImagefromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    Navigator.of(context).pop();

    setState(() {
      _image = File(pickedFile.path);
      selected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final SellerProfile profile =
        Provider.of<ProfileServiceProvider>(context).profile;
    List<bool> data = ModalRoute.of(context).settings.arguments;
    isPersonal = data[0];
    tag1 = data[1] ? 'bigger' : 'smaller';
    tag2 = data[2] ? 'bigger' : 'smaller';
    final List<ListProfileSection> listSection = [
      isPersonal
          ? createSection(
              'Notes',
              Icons.mode_edit,
              () {
                print('Notes');
              },
            )
          : createSection(
              'Policies',
              Icons.insert_drive_file,
              () {
                print("Policies");
              },
            ),
      createSection(
        'Logout',
        Icons.exit_to_app,
        () {
          authHandler.signOut();
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.splashScreenPage, (route) => false);
        },
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Builder(builder: (context) {
          return Container(
            child: Stack(
              children: <Widget>[
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xff0F2027),
                        Color(0xff203A43),
                        Color(0xff2C5364)
                      ]),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Text(
                      isPersonal ? "Profile" : "Shop Profile",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    margin: EdgeInsets.only(top: 85, left: 24),
                  ),
                ),
                Container(
                  // color:Colors.red,
                  // height: MediaQuery.of(context).size.height * .35,
                  margin: EdgeInsets.only(
                    top: 150,
                  ),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: Card(
                          margin: EdgeInsets.only(top: 50, left: 16, right: 16),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          )),
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    left: 8, top: 8, right: 8, bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    GestureDetector(
                                      child: Hero(
                                        tag: tag1,
                                        child: isPersonal
                                            ? cachedDownloadableImage(
                                                imageURL: profile.shop.imageURL,
                                                height: 40,
                                                width: 40,
                                                fit: BoxFit.cover,
                                                border: Border.all(
                                                    color: Colors.grey.shade400,
                                                    width: 2),
                                                shape: BoxShape.circle)
                                            : cachedDownloadableImage(
                                                imageURL: profile.user.imageURL,
                                                height: 40,
                                                width: 40,
                                                fit: BoxFit.cover,
                                                border: Border.all(
                                                    color: Colors.grey.shade400,
                                                    width: 2),
                                                shape: BoxShape.circle),
                                      ),
                                      onTap: () =>
                                          Navigator.pushReplacementNamed(
                                              context, Routes.profilePage,
                                              arguments: [
                                            !data[0],
                                            !data[1],
                                            !data[2]
                                          ]),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      color: Colors.black,
                                      iconSize: 24,
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/editprofileinfo');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                isPersonal
                                    ? profile.user.name
                                    : profile.shop.name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900),
                              ),
                              Text(
                                isPersonal
                                    ? profile.user.phoneNumber
                                    : profile.shop.phoneNumber,
                                style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900),
                              ),
                              Text(
                                isPersonal
                                    ? profile.user.email
                                    : profile.shop.address,
                                style: TextStyle(
                                    color: Colors.grey.shade700, fontSize: 14),
                              ),
                              Container(
                                  child: !isPersonal
                                      ? Text(
                                          profile.shop.description,
                                          style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: 14),
                                        )
                                      : null),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                height: 2,
                                width: double.infinity,
                                color: Colors.grey.shade200,
                              ),
                              Container(
                                //  color:Colors.blue,
                                child: MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Builder(builder: (context) {
                                        return InkWell(
                                          splashColor: Colors.grey.shade200,
                                          onTap: listSection[index].onpressed,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: 16, right: 12),
                                            padding: EdgeInsets.only(
                                                top: 12, bottom: 12),
                                            child: Row(
                                              children: <Widget>[
                                                Icon(listSection[index].icon),
                                                SizedBox(
                                                  width: 12,
                                                ),
                                                Text(
                                                  listSection[index].title,
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade500),
                                                ),
                                                Spacer(
                                                  flex: 1,
                                                ),
                                                Icon(
                                                  Icons.navigate_next,
                                                  color: Colors.grey.shade500,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                    itemCount: listSection.length,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Stack(
                              children: <Widget>[
                                Hero(
                                  tag: tag2,
                                  child: isPersonal
                                      ? cachedDownloadableImage(
                                          imageURL: profile.user.imageURL,
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                          border: Border.all(
                                              color: Colors.grey.shade400,
                                              width: 2),
                                          shape: BoxShape.circle)
                                      : cachedDownloadableImage(
                                          imageURL: profile.shop.imageURL,
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                          border: Border.all(
                                              color: Colors.grey.shade400,
                                              width: 2),
                                          shape: BoxShape.circle),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: GestureDetector(
                                    child: CircleAvatar(
                                      backgroundColor:
                                          CustomThemeData.blackColorShade1,
                                      radius: 18.0,
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: () => {
                                      _presentBottomSheet(context),
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
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
          _buildBottomSheetRow(
            context,
            Icons.delete,
            'Remove',
            () {
              setState(() {
                selected = false;
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
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
