class User {
  String name;
  String email;
  String bio;
  String profileImage;

  User({
    required this.name,
    required this.email,
    required this.bio,
    required this.profileImage,
  });

  // Getter
  String get getName => name;
  String get getEmail => email;
  String get getBio => bio;
  String get getProfileImage => profileImage;

  // Setter
  set setName(String newName) => name = newName;
  set setEmail(String newEmail) => email = newEmail;
  set setBio(String newBio) => bio = newBio;
  set setProfileImage(String newProfileImage) => profileImage = newProfileImage;
}
