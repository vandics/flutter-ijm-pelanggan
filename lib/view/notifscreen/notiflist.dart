class Notifikasi {
  final String image, description, title;

  Notifikasi(
      {required this.image, required this.description, required this.title});
}

List<Notifikasi> notif = [
  Notifikasi(
      image: 'assets/images/illustrasi IJM a 1.png',
      description:
          'Oops...\nKamu belum memiliki pesanan.\nSilakan pesan terlebih dahulu.',
      title: 'Belum ada pesanan'),
  Notifikasi(
      image: 'assets/images/illustrasi IJM c.png',
      description: 'Sabar yaa...\nPesananmu sedang diproses',
      title: 'Pesanan sedang diproses'),
  Notifikasi(
      image: 'assets/images/illustrasi IJM b.png',
      description: 'Tabung oksigenmu sedang diisi',
      title: 'Tabung oksigen sedang diisi'),
  Notifikasi(
      image: 'assets/images/illustrasi IJM d.png',
      description:
          'Tabung oksigemu sudah siap diambil,\nTerima kasih sudah berlangganan dengan kami.',
      title: 'Tabung oksigen siap diambil'),
  Notifikasi(
      image: 'assets/images/illustrasi IJM e.png',
      description: 'Tunggu yaa...\nTabung oksigenmu sedang diantar',
      title: 'Tabung oksigen sedang diantar'),
];
