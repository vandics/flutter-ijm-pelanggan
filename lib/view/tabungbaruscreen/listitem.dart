class Item {
  final String tabungsize, tabugprice;
  int amount;

  Item(
      {required this.tabungsize,
      required this.tabugprice,
      required this.amount});
}

List<Item> item = [
  Item(tabungsize: "Tabung 0,5m\u00B3", tabugprice: "Rp. 45.000", amount: 0),
  Item(tabungsize: "Tabung 1m\u00B3", tabugprice: "Rp. 45.000", amount: 0),
  Item(tabungsize: "Tabung 2m\u00B3", tabugprice: "Rp. 45.000", amount: 0),
  Item(tabungsize: "Tabung 6m\u00B3", tabugprice: "Rp. 45.000", amount: 0),
];
