class Menu {
  final String image, title, navigation;

  Menu({required this.navigation, required this.image, required this.title});
}

List<Menu> menu = [
  Menu(
      image: 'assets/images/Group 49.png',
      title: 'Refill/Isi Ulang',
      navigation: '/RefillScreen'),
  Menu(
      image: 'assets/images/Group 50.png',
      title: 'Tabung Baru',
      navigation: '/TabungbaruScreen'),
  Menu(
      image: 'assets/images/Group 51.png',
      title: 'Pinjam Tabung',
      navigation: '/PinjamTabungScreen'),
  Menu(
    image: 'assets/images/Penjualan.png',
    title: 'Transaksi',
    navigation: '/TransaksiScreen',
  )
];
