import 'package:flutter/cupertino.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoPageScaffold(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
              Container(
                height: 40,
                width: 300,
                child: CupertinoTextField(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  placeholder: 'E-mail or Numer',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
