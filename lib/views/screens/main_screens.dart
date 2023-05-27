part of 'screens.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  String? resi;

  @override
  Widget build(BuildContext context) {
    Widget buttonAdd() {
      return FloatingActionButton(
          onPressed: () async {
            try {
              resi = await FlutterBarcodeScanner.scanBarcode(
                  '#ff6666', 'Cancel', true, ScanMode.QR);
            } on PlatformException {
              resi = null;
              CustomWidgets.buildErrorSnackbar(context, 'Upss something wrong with scan');        
            }
            if (!mounted) return;
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
          backgroundColor: cBlue,
          child: Icon(Icons.add));
    }

    Widget buildContent(int screen) {
      switch (screen) {
        case 0:
          return HomeScreen();
        case 2:
          return HistoryScreen();
        default:
          return HomeScreen();
      }
    }

    Widget customNavbar() {
      return BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: navigationTapped,
          selectedLabelStyle: tPoppins.copyWith(
            color: cRed,
            fontSize: 12,
          ),
          unselectedLabelStyle: tPoppins.copyWith(
            color: cGrey,
            fontSize: 12,
          ),
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 20,
                color: currentIndex == 0 ? cBlue : cGrey,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Container(),
              label: '',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.receipt_long_sharp,
                  size: 20,
                  color: currentIndex == 2 ? cBlue : cGrey,
                ),
                label: 'History'),
          ],
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      floatingActionButton: buttonAdd(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: customNavbar(),
      body: buildContent(currentIndex),
    );
  }

  void navigationTapped(int page) {
    if (page == 1) {
      return;
    } else {
      setState(() {
        currentIndex = page;
      });
    }
  }
}