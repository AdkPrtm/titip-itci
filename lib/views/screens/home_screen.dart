part of 'screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<ResiBloc>().add(LoadResiEvent());
    super.initState();
  }

  String returnMonth() {
    return new DateFormat.MMMM().format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    Widget header(String profit, String jumlahPaket) {
      return Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 45,
              left: 23,
              right: 23,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Halo',
                  style: tPoppins.copyWith(
                    color: cBackground,
                  ),
                ),
                Text(
                  'Andhika Pratama',
                  style: tPoppins.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height: 5),
                RichText(
                  text: TextSpan(
                    style: tPoppins.copyWith(
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(text: 'Kamu telah menerima sebanyak '),
                      TextSpan(
                        text: jumlahPaket,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: ' Paket pada bulan ${returnMonth()} ini!'),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 24),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    // border: Border.all(color: cGrey, width: 0.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(1, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Profit Fee',
                            style: tPoppins.copyWith(
                              color: cBlack1,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            NumberFormat.currency(
                                    locale: "id_ID",
                                    decimalDigits: 0,
                                    symbol: "Rp ")
                                .format(int.parse(profit)),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () async {
                          final url =
                              'http://192.168.1.50/exportexcel.php?month=${DateTime.now().month}&year=${DateTime.now().year}';
                          if (await canLaunch(url)) {
                            await launch(url);
                          }
                        },
                        child: Text(
                          'Download Laporan',
                          style: tPoppins.copyWith(
                            color: cBlack1,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      );
    }

    Widget iconBubble() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x1A00C7A1),
              ),
              child: Icon(
                Icons.location_on,
                color: Color(0xFF00C7A1),
              ),
            ),
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x1A32C0E9),
              ),
              child: Icon(
                Icons.tram,
                color: Color(0xFF00C7A1),
              ),
            ),
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x1AFDC02A),
              ),
              child: Icon(
                Icons.refresh_rounded,
                color: Color(0xFFFDC02A),
              ),
            ),
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x1AFF5F3E),
              ),
              child: Icon(
                Icons.menu,
                color: Color(0xFFFF5F3E),
              ),
            ),
          ],
        ),
      );
    }

    Widget dataResi(List<ResiModel>? resiModel) {
      return Column(
        children: resiModel!
            .map((ResiModel resiModel) =>
                CardDataComponent(resiModel: resiModel))
            .toList(),
      );
    }

    return Scaffold(
      body: BlocConsumer<ResiBloc, ResiState>(
        listener: (context, state) {
          if (state is ResiFailedCRUD) {
            CustomWidgets.buildErrorSnackbar(context, state.msg);
          }
        },
        builder: (context, state) {
          if (state is GetResiSuccess) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  header(state.profit, state.jumlahPaket),
                  iconBubble(),
                  dataResi(state.resiModel),
                  SizedBox(height: 93),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
