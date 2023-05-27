part of 'screens.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/image/background.png'),
                    fit: BoxFit.cover),
              ),
            ),
            backgroundColor: Colors.transparent,
            title: Text(
              'Riwayat Transaksi',
              style: tPoppins.copyWith(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    'DALAM PROSES',
                    style: tPoppins.copyWith(color: Colors.white),
                  ),
                ),
                Tab(
                  child: Text(
                    'SELESAI',
                    style: tPoppins.copyWith(color: Colors.white),
                  ),
                ),
              ],
              indicatorColor: Colors.white,
              indicatorWeight: 2,
              indicatorPadding: EdgeInsets.symmetric(horizontal: 5),
            ),
          ),
          body: TabBarView(
            children: [
              BlocProvider(
                create: (context) => ResiBloc()..add(ResiBelumDiTerimaFetch()),
                child: BelumDiTerimaTab(),
              ),
              BlocProvider(
                create: (context) => ResiBloc()..add(ResiSudahDiTerimaFetch()),
                child: SudahDiTerimaTab(),
              ),
            ],
          )),
    );
  }
}

