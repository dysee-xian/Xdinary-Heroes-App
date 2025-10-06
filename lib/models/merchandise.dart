class Merchandise {
  final String _name;
  int _price;
  final String _image;
  final String _category;
  final String _description;

  Merchandise(
    this._name,
    this._price,
    this._image,
    this._category,
    this._description,
  );

  // Getter
  String get name => _name;
  int get price => _price;
  String get image => _image;
  String get category => _category;
  String get description => _description;

  // Setter
  set price(int value) {
    if (value > 0) {
      _price = value;
    }
  }
}

final List<Merchandise> allItems = [
  Merchandise(
    "6st Mini Album Beautiful Mind Special ver",
    200000,
    "assets/image/beauifulmind.jpg",
    "Album",
    "6st Mini Album Special ver. This product is sold in limited quantities and may sell out early once the prepared stock is gone.",
  ),
  Merchandise(
    "1st Full Album Trouble Shooting",
    190000,
    "assets/image/TroubleShooting.jpg",
    "Album",
    "Full Album pertama Xdinary Heroes dengan musik lebih energik dan eksperimental.",
  ),
  Merchandise(
    "T-Shirt XDH",
    120000,
    "assets/image/tshirt.png",
    "Baju",
    "Kaos official XDH dengan desain logo eksklusif. Nyaman untuk aktivitas sehari-hari.",
  ),
  Merchandise(
    "Hoodie XDH",
    250000,
    "assets/image/hoodie.png",
    "Baju",
    "Hoodie tebal dan hangat dengan desain khas XDH. Cocok untuk musim hujan.",
  ),
  Merchandise(
    "Gantungan Kunci",
    30000,
    "assets/image/keychain.png",
    "Aksesoris",
    "Gantungan kunci karakter XDH. Ringan, lucu, dan bisa dipasang di tas atau kunci.",
  ),
  Merchandise(
    "Ham-Il",
    200000,
    "assets/image/album.png",
    "Monster",
    "Boneka maskot Ham-Il, karakter imut dari XDH yang menjadi favorit fans.",
  ),
  Merchandise(
    "Nyangduu",
    190000,
    "assets/image/album2.png",
    "Monster",
    "Boneka karakter Nyangduu dengan desain menggemaskan untuk koleksi.",
  ),
  Merchandise(
    "JiDuck",
    120000,
    "assets/image/tshirt.png",
    "Monster",
    "Boneka karakter JiDuck berbentuk bebek unik. Wajib dimiliki oleh penggemar XDH.",
  ),
  Merchandise(
    "Fox.De",
    250000,
    "assets/image/hoodie.png",
    "Monster",
    "Boneka rubah bernama Fox.De dengan desain elegan dan bulu lembut.",
  ),
  Merchandise(
    "Tyonen",
    180000,
    "assets/image/doll.png",
    "Monster",
    "Boneka Tyonen dengan ekspresi ceria, cocok jadi teman tidur maupun pajangan.",
  ),
  Merchandise(
    "Jjuf",
    30000,
    "assets/image/keychain.png",
    "Monster",
    "Mini boneka Jjuf yang mungil, bisa dijadikan gantungan kunci atau koleksi.",
  ),
];
