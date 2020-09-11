class SellerProfile {
  final String name;
  final String email;
  final String imageURL;
  final String phoneNumber;
  final String shopName;
  final String shopOwnerName;
  final String shopPhoneNumber;
  final String shopDescription;
  final String shopAddress;

  SellerProfile(
      this.name,
      this.email,
      this.imageURL,
      this.phoneNumber,
      this.shopName,
      this.shopOwnerName,
      this.shopPhoneNumber,
      this.shopDescription,
      this.shopAddress);

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'imageURL': imageURL,
        'phoneNumber': phoneNumber,
        'shopName': shopName,
        'shopOwnerName': shopOwnerName,
        'shopPhoneNumber': shopPhoneNumber,
        'shopDescription': shopDescription,
        'shopAddress': shopAddress
      };

  SellerProfile.fromMap(Map<String, dynamic> map)
      : this.name = map['name'],
        this.email = map['email'],
        this.imageURL = map['imageURL'],
        this.phoneNumber = map['phoneNumber'],
        this.shopName = map['shopName'],
        this.shopOwnerName = map['shopOwnerName'],
        this.shopPhoneNumber = map['shopPhoneNumber'],
        this.shopDescription = map['shopDescription'],
        this.shopAddress = map['shopAddress'];
}
