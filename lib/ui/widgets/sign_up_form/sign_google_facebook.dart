import 'package:flutter/cupertino.dart';
import 'package:kyw_management/ui/widgets/sign_up_form/button_network.dart';

class SignGoogleFacebook extends StatelessWidget {
  const SignGoogleFacebook({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ButtonNetwork(
          text: 'Google',
          image: Image.asset(
            'assets/Google.webp',
            width: 30,
          ),
          width: 140,
        ),
        ButtonNetwork(
          text: 'Facebook',
          image: Image.asset(
            'assets/Facebook-logo.webp',
            width: 34,
          ),
        ),
      ],
    );
  }
}
