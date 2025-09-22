import '/models/user.dart';

class UserRepository {
  User getUserProfile() {
    return User(
      name: "Desinta Dian",
      email: "desinta@unesa.com",
      bio: "Pusing pak tolongg",
      profileImage: "assets/image/me when pbp.jpg",
    );
  }
}
