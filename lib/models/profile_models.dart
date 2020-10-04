import 'package:cloud_firestore/cloud_firestore.dart';

class SellerProfile {
  final User user;
  final Shop shop;
  final menuItemsCounter;
  DocumentReference reference;

  SellerProfile({this.user, this.shop, this.menuItemsCounter});

  Map<String, dynamic> toJson() =>
      {'user': this.user.toJson(), 'shop': this.shop.toJson()};

  SellerProfile.fromMap(Map<String, dynamic> map, int menuItemsCounter,
      {this.reference})
      : this.user = User.fromMap(map['user']),
        this.shop = Shop.fromMap(map['shop']),
        this.menuItemsCounter = menuItemsCounter;

  // SellerProfile.fromSnapshot(DocumentSnapshot snapshot)
  //     : this.fromMap(snapshot.data(), reference: snapshot.reference);
}

class User {
  final String name;
  final String imageURL;
  final String phoneNumber;
  final String email;

  User({this.name, this.imageURL, this.phoneNumber, this.email});

  User.fromMap(Map<String, dynamic> map)
      : this.name = map['name'],
        this.imageURL = map['imageURL'],
        this.email = map['email'],
        this.phoneNumber = map['phoneNumber'];

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'imageURL': this.imageURL,
        'email': this.email,
        'phoneNumber': this.phoneNumber
      };
}

class Shop {
  final String name;
  final String ownerName;
  final String imageURL;
  final String phoneNumber;
  final String description;
  final String address;

  Shop(
      {this.name,
      this.ownerName,
      this.imageURL,
      this.phoneNumber,
      this.description,
      this.address});

  Shop.fromMap(Map<String, dynamic> map)
      : this.name = map['name'],
        this.imageURL = map['imageURL'],
        this.phoneNumber = map['phoneNumber'],
        this.ownerName = map['ownerName'],
        this.description = map['description'],
        this.address = map['address'];

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'imageURL': this.imageURL,
        'phoneNumber': this.phoneNumber,
        'ownerName': this.ownerName,
        'description': this.description,
        'address': this.address
      };
}
