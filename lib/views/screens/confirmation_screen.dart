part of 'screens.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int totalCod = 0;
    int totalFee = 10000;
    String? resi;
    Widget header() {
      return Center(
        child: Text(
          'Konfirmasi Data Pengiriman',
          style: tPoppins.copyWith(
            fontSize: 18,
            color: cBlack1,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    Widget boxTotal({required List<ResiModel> resiModel}) {
      if (resiModel.length > 1) {
        totalFee = 7000 * resiModel.length;
      }
      for (var ctr in resiModel) {
        totalCod += int.parse(ctr.hargaCod);
      }
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: 23,
          vertical: 10,
        ),
        padding: EdgeInsets.symmetric(horizontal: 26, vertical: 26),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFF4F7FF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Jumlah Transaksi',
                  style: tPoppins.copyWith(
                    color: Color(0xFF656565),
                  ),
                ),
                Text(
                  '${resiModel.length} Transaksi',
                  style: tPoppins.copyWith(
                    color: cBlack1,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pembayaran Cod',
                  style: tPoppins.copyWith(
                    color: Color(0xFF656565),
                  ),
                ),
                Text(
                  NumberFormat.currency(
                          locale: "id_ID", decimalDigits: 0, symbol: "Rp ")
                      .format(totalCod),
                  style: tPoppins.copyWith(
                    color: cBlack1,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Fee Jastip',
                  style: tPoppins.copyWith(
                    color: Color(0xFF656565),
                  ),
                ),
                Text(
                  NumberFormat.currency(
                          locale: "id_ID", decimalDigits: 0, symbol: "Rp ")
                      .format(totalFee),
                  style: tPoppins.copyWith(
                    color: cBlack1,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Semuanya',
                  style: tPoppins.copyWith(
                    color: Color(0xFF656565),
                  ),
                ),
                Text(
                  NumberFormat.currency(
                          locale: "id_ID", decimalDigits: 0, symbol: "Rp ")
                      .format(totalFee + totalCod),
                  style: tPoppins.copyWith(
                    color: cBlack1,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ],
        ),
      );
    }

    Widget listData({required List<ResiModel> resiModel}) {
      return Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 23,
            vertical: 10,
          ),
          padding: EdgeInsets.symmetric(horizontal: 26),
          width: double.infinity,
          child: ListView.builder(
              itemCount: resiModel.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actionsPadding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            title: SvgPicture.asset(
                              svgTrash,
                              width: 40,
                              height: 40,
                            ),
                            content: Text(
                              'Apakah yakin ingin menghapus resi?',
                              textAlign: TextAlign.center,
                            ),
                            actions: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: cRed,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          context.read<CartBloc>().add(
                                              DeleteResiFromCart(
                                                  resiModel: resiModel[index]));
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Hapus',
                                          style: tPoppins.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: cBlue,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: tPoppins.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          );
                        });
                  },
                  child: KonfirmasiDataCard(
                    resiModel: resiModel[index],
                  ),
                );
              }),
        ),
      );
    }

    Widget customButtonNavbar({required List<ResiModel> resiModel}) {
      return Positioned(
        bottom: 16.0,
        right: 0.0,
        left: 0.0,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          color: Colors.white,
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  try {
                    resi = await FlutterBarcodeScanner.scanBarcode(
                        '#ff6666', 'Cancel', true, ScanMode.QR);
                  } on PlatformException {
                    resi = null;
                    CustomWidgets.buildErrorSnackbar(
                        context, 'Upss something wrong with scan');
                  }
                  // if (!mounted) return;
                  if (resi != '-1') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddResiScreen(resi: resi!)));
                  } else {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/MainScreen', (route) => false);
                  }
                },
                child: Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0xFF4F61ED),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'TAMBAH TRANSAKSI',
                      style: tPoppins.copyWith(
                        fontWeight: FontWeight.w600,
                        color: cBlue,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 9),
              ButtonComponent(
                text: 'Checkout',
                color: cBlue,
                onPressed: () {
                  for (var data in resiModel) {
                    context.read<ResiBloc>().add(
                          EditPengambilanResiEvent(
                            resi: data.resi,
                            status: 'Sudah diambil',
                            hargaCod: int.parse(data.hargaCod),
                            fee: totalFee,
                          ),
                        );
                    Future.delayed(Duration(seconds: 1));
                  }
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/MainScreen', (route) => false);
                },
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          header(),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoaded) {
                return Expanded(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          boxTotal(resiModel: state.resiModel),
                          listData(resiModel: state.resiModel),
                        ],
                      ),
                      customButtonNavbar(resiModel: state.resiModel),
                    ],
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
