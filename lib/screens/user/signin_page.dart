import 'package:flutter/material.dart';
import 'package:home_vault/screens/user/signup_page.dart';
import 'package:home_vault/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:home_vault/screens/main/landing_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:home_vault/auth/generate_access_token.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final String loginUrl =
      'https://b6d9-115-98-217-224.ngrok-free.app/api/token/';
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    print('message HAHHAHAHAHAHHAHA ******* AGAINNNN CAME TO THIS PAGE');
  }

// currently commented
  Future<void> checkLoggedIn() async {
    print('message im in chjeckloggedin ');
    final accessToken = await storage.read(key: 'access_token');
    final refreshToken = await storage.read(key: 'refresh_token');

    print('access_tokennnn  $accessToken');
    print('refreshToken  $refreshToken');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Helloo Unknown error $accessToken  $refreshToken'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    if (accessToken != null) {
      print('verifyinnining access token');
      final isValid = await verifyAccessToken(accessToken);
      if (isValid) {
        // Token is still valid, proceed to the LandingPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LandingPage()),
        );
      } else if (refreshToken != null) {
        // Token has expired, attempt to refresh it
        // String newAccessToken = await GenerateAccessToken();
        String result = await GenerateAccessToken.refreshToken();

        if (result == 'success') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LandingPage()),
          );
        } else {
          print('Something went wrong');
        }
      }
    }
  }

// currently commented
  Future<bool> verifyAccessToken(String accessToken) async {
    print('calling verify aopiiiipipipi');
    final verifyUrl =
        'https://b6d9-115-98-217-224.ngrok-free.app/api/verify-token/';
    final response = await http.post(
      Uri.parse(verifyUrl),
      headers: {'Authorization': 'Token $accessToken'},
    );

    return response.statusCode == 200;
  }

  Future<void> signinUser(
    BuildContext context,
    String username,
    String password,
  ) async {
    print('heyyuuuu imim clickedd');
    print('message  $loginUrl');
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // final
      final resp = jsonDecode(response.body);
      print('respresp*********** $resp');
      final access_token = resp['access'];
      final resp_username = resp['username'];
      // final refresh_token = resp['refresh'];
      // await storage.write(key: 'access_token', value: access_token);
      // await storage.write(key: 'refresh_token', value: refresh_token);
      try {
        await storage.write(key: 'access_token', value: access_token);
        await storage.write(key: 'username', value: resp_username);
        print(
            'aaa writing tokens to storage ++++||||||>>>>>refresh_tokenacess: $access_token');
      } catch (e) {
        print('Error writing tokens to storage ++++||||||>>>>>: $e');
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LandingPage()),
      );
    } else {
      final error = jsonDecode(response.body);
      final err = error['detail'];
      final password_err = error['password'];
      final username_err = error['username'];

      String? err_context;

      if (err != null) {
        err_context = err;
      } else if (password_err != null && password_err.isNotEmpty) {
        err_context = password_err[0];
      } else if (username_err != null && username_err.isNotEmpty) {
        err_context = username_err[0];
      }

      print("errorerror $error");
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(err_context ?? 'Unknown error'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              _forgotPassword(context),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Enter your credential to login"),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: usernameController,
          decoration: InputDecoration(
              hintText: "Username",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: secondaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.person)),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: secondaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.password),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            signinUser(
              context,
              usernameController.text,
              passwordController.text,
            );
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: secondaryColor,
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        )
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        "Forgot password?",
        style: TextStyle(color: secondaryColor),
      ),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Dont have an account? "),
        TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        // ImagePreviewScreen(imageUrl: imageFile.path),
                        SignupPage()),
              );
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(color: secondaryColor),
            ))
      ],
    );
  }
}
