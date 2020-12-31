class UserModel {

  String appLanguage;
  String userType;
  String deviceToken;
  String profilePic;
  String firstName;


  //<editor-fold desc="Data Methods" defaultstate="collapsed">


  UserModel({
    this.appLanguage,
    this.userType,
    this.deviceToken,
    this.profilePic,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNumber,
    this.address,
  });


  UserModel copyWith({
    String appLanguage,
    String userType,
    String deviceToken,
    String profilePic,
    String firstName,
    String lastName,
    String email,
    String mobileNumber,
    String address,
  }) {
    return new UserModel(
      appLanguage: appLanguage ?? this.appLanguage,
      userType: userType ?? this.userType,
      deviceToken: deviceToken ?? this.deviceToken,
      profilePic: profilePic ?? this.profilePic,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      address: address ?? this.address,
    );
  }


  @override
  String toString() {
    return 'UserModel{appLanguage: $appLanguage, userType: $userType, deviceToken: $deviceToken, profilePic: $profilePic, firstName: $firstName, lastName: $lastName, email: $email, mobileNumber: $mobileNumber, address: $address}';
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is UserModel &&
              runtimeType == other.runtimeType &&
              appLanguage == other.appLanguage &&
              userType == other.userType &&
              deviceToken == other.deviceToken &&
              profilePic == other.profilePic &&
              firstName == other.firstName &&
              lastName == other.lastName &&
              email == other.email &&
              mobileNumber == other.mobileNumber &&
              address == other.address
          );


  @override
  int get hashCode =>
      appLanguage.hashCode ^
      userType.hashCode ^
      deviceToken.hashCode ^
      profilePic.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      email.hashCode ^
      mobileNumber.hashCode ^
      address.hashCode;


  factory UserModel.fromMap(Map<String, dynamic> map) {
    return new UserModel(
      appLanguage: map['appLanguage'] as String,
      userType: map['userType'] as String,
      deviceToken: map['deviceToken'] as String,
      profilePic: map['profilePic'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      mobileNumber: map['mobileNumber'] as String,
      address: map['address'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'appLanguage': this.appLanguage,
      'userType': this.userType,
      'deviceToken': this.deviceToken,
      'profilePic': this.profilePic,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'email': this.email,
      'mobileNumber': this.mobileNumber,
      'address': this.address,
    } as Map<String, dynamic>;
  }


  //</editor-fold>


  String lastName;
  String email;
  String mobileNumber;
  String address;




}
