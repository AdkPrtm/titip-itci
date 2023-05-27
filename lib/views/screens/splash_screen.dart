part of 'screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      getInit();
    });
    super.initState();
  }

  getInit() async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    var json = _preferences.getString('user');
    if (json != null) {
      UserModel user = UserModel.fromJson(jsonDecode(json));
      context.read<UserBloc>().add(SignInUser(userModel: user));
      Navigator.pushReplacementNamed(context, '/MainScreen');
    } else {
      Navigator.pushReplacementNamed(context, '/LoginScreen');
    }
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Lottie.asset('assets/lottie/splash.json'),
        ),
      ),
    );
  }
}
