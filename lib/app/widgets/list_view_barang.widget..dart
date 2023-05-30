import 'package:food_xyz_project/repositories.dart';

class ListViewBarang extends StatefulWidget {
  const ListViewBarang({
    super.key,
    required this.barang,
    required this.controllers,
  });

  final List<Barang> barang;
  final List<TextEditingController> controllers;
  @override
  State<StatefulWidget> createState() => _ListViewBarangState();
}

class _ListViewBarangState extends State<ListViewBarang> {
  Timer? _debounceTimer;
  String formatCurrency(int value) {
    var format = NumberFormat.currency(locale: 'id_IDR', symbol: 'Rp');
    return format.format(value);
  }

  @override
  void dispose() {
    super.dispose();
    for (TextEditingController controller in widget.controllers) {
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.barang.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 5,
          child: Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Image.asset(
                      'assets/images/fast_food.png',
                      width: 100,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.barang[index].namaBarang,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.barang[index].rating.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 5.0,
                      ),
                      child: Row(
                        children: [
                          Text(
                              formatCurrency(widget.barang[index].hargaBarang)),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  int temp =
                                      int.parse(widget.controllers[index].text);
                                  if (temp > 0) {
                                    temp--;
                                    setState(() {
                                      widget.controllers[index].text =
                                          temp.toString();
                                    });
                                  }
                                },
                                icon: const Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: widget.controllers[index],
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    if (_debounceTimer?.isActive ?? false) {
                                      _debounceTimer?.cancel();
                                    }
                                    _debounceTimer = Timer(
                                      const Duration(milliseconds: 500),
                                      () => setState(() {
                                        if (value.isBlank ?? false) {
                                          widget.controllers[index].text = '0';
                                        } else {
                                          widget.controllers[index].text =
                                              value;
                                        }
                                      }),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 5),
                              IconButton(
                                onPressed: () {
                                  int temp =
                                      int.parse(widget.controllers[index].text);
                                  temp++;
                                  setState(() {
                                    widget.controllers[index].text =
                                        temp.toString();
                                  });
                                },
                                icon: const Icon(
                                  Icons.add_circle,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              String barangDipilih =
                                  widget.barang[index].namaBarang;
                              int hargaBarang =
                                  widget.barang[index].hargaBarang *
                                      int.parse(widget.controllers[index].text);

                              Get.snackbar(
                                'Kamu telah memilih $barangDipilih',
                                'Total Bayar $hargaBarang',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                            child: const Icon(Icons.shopping_cart),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/* Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.barang[index],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text('Rp.1000'),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.remove_circle,
                          color: Colors.red,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add_circle,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  )
                ],
              )*/
