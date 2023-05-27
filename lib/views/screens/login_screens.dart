part of 'screens.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.only(bottom: 47),
        child: Text(
          'Login',
          style: tPoppins.copyWith(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    Widget form() {
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email',
              style: tPoppins,
            ),
            SizedBox(height: 7),
            FieldComponent(
                hint: 'email@email.com', controller: emailController),
            SizedBox(height: 24),
            Text(
              'Password',
              style: tPoppins,
            ),
            SizedBox(height: 7),
            FieldComponent(hint: '*********', controller: passwordController),
          ],
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(),
            form(),
            Spacer(),
            BlocConsumer<UserBloc, UserState>(
              listener: (context, state) {
                if (state is UserSuccess) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/MainScreen', (route) => false);
                } else if (state is UserFailed) {
                  CustomWidgets.buildErrorSnackbar(context, state.msg);
                }
              },
              builder: (context, state) {
                if (state is UserLoading) {
                  return ButtonComponent(
                    text: 'Login',
                    color: cBlue,
                    onPressed: () {},
                    loading: true,
                  );
                }
                return ButtonComponent(
                  text: 'Login',
                  color: cBlue,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<UserBloc>().add(
                            SignInUser(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
