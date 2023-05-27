part of 'components.dart';

class FieldComponent extends StatefulWidget {
  const FieldComponent({
    Key? key,
    required this.hint,
    required this.controller,
    this.warning = '',
    this.enable = true,
    this.number = false,
  }) : super(key: key);

  final String hint, warning;
  final TextEditingController controller;
  final bool enable, number;

  @override
  _FieldComponentState createState() => _FieldComponentState();
}

class _FieldComponentState extends State<FieldComponent> {
  bool _showPassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorColor: cBlack1,
      enabled: widget.enable,
      obscureText: widget.hint == '*********' ? _showPassword : false,
      decoration: InputDecoration(
        suffixIcon: widget.hint == '*********'
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
                child: Icon(
                  _showPassword ? Icons.visibility_off : Icons.visibility,
                  color: cGrey,
                ),
              )
            : SizedBox(),
        suffixIconConstraints: widget.hint == '*********'
            ? BoxConstraints(
                minWidth: 40,
                minHeight: 24,
              )
            : BoxConstraints(),
        hintText: widget.hint,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: cGrey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: cGrey),
        ),
        filled: true,
        fillColor: widget.enable
            ? Colors.white.withOpacity(0.1)
            : cGrey.withOpacity(0.2),
      ),
      validator: widget.hint == 'email@email.com'
          ? (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your email address";
              } else if (!RegExp(
                      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                  .hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            }
          : widget.hint == '*********'
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password";
                  } else if (value.length < 9) {
                    return "Minimum length password 8";
                  }
                  return null;
                }
              : (value) {
                  if (value == null || value.isEmpty) {
                    return "Mohon untuk mengisi ${widget.warning}";
                  }
                  return null;
                },
      keyboardType: widget.number
          ? TextInputType.number
          : widget.hint == 'email@email.com'
              ? TextInputType.emailAddress
              : TextInputType.text,
    );
  }
}
