import 'package:flutter/material.dart';
import 'package:my_finance/core/theme.dart';
import 'package:my_finance/services/auth_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLogin = true;
  bool _isLoading = false;

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: w16),
        backgroundColor: errorClr,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _submitAuthForm() async {
    setState(() => _isLoading = true);

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty || password.length < 6) {
      _showErrorSnackBar("Authentication Failed");
    }

    final authService = AuthService();
    final user =
        _isLogin
            ? await authService.signIn(email, password)
            : await authService.signUp(email, password);

    if (user != null) {
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      _showErrorSnackBar("Account does not exists.");
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_isLogin ? "Login" : "Register", style: g18),
              Txtfield(
                controller: _emailController,
                hinttext: "Email",
                obscureText: false,
              ),
              Txtfield(
                hinttext: "Password",
                controller: _passwordController,
                obscureText: true,
              ),
              SizedBox(height: 10),
              _isLoading
                  ? CircularProgressIndicator(color: gClr)
                  : ElevatedButton(
                    onPressed: _submitAuthForm,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(gClr),
                    ),
                    child: Text(_isLogin ? "Login" : "Register", style: w16),
                  ),
              SizedBox(height: 16),
              _isLogin
                  ? TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Colors.transparent,
                      ),
                    ),
                    onPressed: () {
                      _emailController.clear();
                      _passwordController.clear();
                      setState(() => _isLogin = !_isLogin);
                    },
                    child: Text("Create an account", style: g16),
                  )
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?", style: g16),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            Colors.transparent,
                          ),
                        ),
                        onPressed: () {
                          _emailController.clear();
                          _passwordController.clear();
                          setState(() => _isLogin = !_isLogin);
                        },
                        child: Text("Login", style: g16),
                      ),
                    ],
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class Txtfield extends StatelessWidget {
  final String hinttext;
  final TextEditingController controller;
  final bool obscureText;

  const Txtfield({
    super.key,
    required this.hinttext,
    required this.controller,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        enableSuggestions: false,
        autocorrect: false,
        style: g16,
        decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: g16,
          prefixIconColor: gClr,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: gClr, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: gClr, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: gClr, width: 2),
          ),
        ),
      ),
    );
  }
}
