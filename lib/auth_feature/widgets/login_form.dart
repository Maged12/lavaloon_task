import 'package:flutter/material.dart';
import '../../Home/screens/home_screen.dart';
import '../providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _userNameController;
  late final TextEditingController _userPasswordController;
  bool _isPasswordObscure = true;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _userNameController = TextEditingController();
    _userPasswordController = TextEditingController();
    super.initState();
  }

  @override
  dispose() {
    _formKey.currentState?.dispose();
    _userNameController.dispose();
    _userPasswordController.dispose();
    super.dispose();
  }

  void unFocus() => FocusScope.of(context).unfocus();

  void _tryLogin() async {
    unFocus();
    final authProvider = context.read<AuthProvider>();
    await authProvider.getRequestedToken();
    await authProvider.validateLogin(
        _userNameController.text, _userPasswordController.text);
    if (authProvider.isValid ?? false) {
      await authProvider.createSession();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
    }
  }

  void onPressSkip() {
    unFocus();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final errorMessage = context
        .select((AuthProvider authProvider) => authProvider.errorMessage);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          if (errorMessage.isNotEmpty)
            Text(
              "*$errorMessage",
              style: const TextStyle(color: Colors.red),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _userNameController,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Username can't be Empty";
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Username',
                prefixIcon: Icon(
                  Icons.person,
                ),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _userPasswordController,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Password can't be Empty";
                }
                return null;
              },
              keyboardType: TextInputType.text,
              obscureText: _isPasswordObscure,
              decoration: InputDecoration(
                hintText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordObscure
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: _isPasswordObscure
                        ? Colors.black
                        : Theme.of(context).errorColor,
                  ),
                  onPressed: () {
                    setState(
                      () {
                        _isPasswordObscure = !_isPasswordObscure;
                      },
                    );
                  },
                ),
                prefixIcon: const Icon(
                  Icons.lock,
                ),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
          Consumer<AuthProvider>(builder: (context, authProvider, _) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: authProvider.isLoading
                  ? Container(
                      width: 250,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    )
                  : SizedBox(
                      width: 250,
                      height: 50,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        splashColor: Colors.black,
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        onPressed: _tryLogin,
                        child: const Center(
                          child: Text(
                            'LOGIN',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
            );
          }),
          TextButton(
              onPressed: onPressSkip,
              child: const Text("Skip",
                  style: TextStyle(
                    fontSize: 17,
                  )))
        ],
      ),
    );
  }
}
