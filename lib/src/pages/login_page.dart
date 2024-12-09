import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hawker_food/src/models/user_credential.dart';
import 'package:hawker_food/src/pages/map_page.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> signInWithGoogle() async {
    var scopes = [
      'https://www.googleapis.com/auth/userinfo.profile',
      'https://www.googleapis.com/auth/userinfo.email',
      'openid',
    ];
    var signin = GoogleSignIn(scopes: scopes);

    final GoogleSignInAccount? googleUser = await signin.signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    var credential = context.read<UserCredentialModel>();
    
    await credential.writeToken(googleAuth.idToken!);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return MapPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: FractionallySizedBox(
        widthFactor: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                "Hawker Food",
                style: TextStyle(
                  fontSize: 32,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: 220,
              child: SignInButton(
                Buttons.google,
                onPressed: signInWithGoogle,
                text: "Entrar com o Google",
                elevation: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
