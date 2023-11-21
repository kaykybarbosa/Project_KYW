import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:go_router/go_router.dart';
import 'package:kyw_management/app/screens/widgets/button_main.dart';
import 'package:kyw_management/app/screens/widgets/button_network.dart';
import 'package:kyw_management/app/screens/widgets/input_email_valid.dart';
import 'package:kyw_management/app/screens/widgets/input_password_%20valid.dart';
import 'package:kyw_management/app/screens/widgets/my_title.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CustomScrollView(slivers: [
      SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return Container();
        }),
      ),
    ]));
  }
}

// SafeArea(
//           child: Form(
//             key: formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 40),
//                 // Title
//                 const MyTitle(title: 'REGISTER'),
//                 const SizedBox(height: 40),
//                 // Form
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: CupertinoTextFormFieldRow(
//                     autovalidateMode: AutovalidateMode.onUserInteraction,
//                     textInputAction: TextInputAction.next,
//                     placeholder: 'Nome',
//                     placeholderStyle: const TextStyle(
//                         fontSize: 20,
//                         color: CupertinoColors.placeholderText,
//                         fontWeight: FontWeight.w400),
//                     decoration: BoxDecoration(
//                         border: Border.all(
//                             width: 2, color: CupertinoColors.inactiveGray),
//                         borderRadius: BorderRadius.circular(10)),
//                   ),
//                 ),
//                 const InputEmailValid(placeHolder: 'E-mail'),
//                 const InputPasswordValid(placeHolder: 'Senha'),
//                 const SizedBox(height: 20),
//                 // Continue with account
//                 SizedBox(
//                   width: 350,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       ButtonNetwork(
//                         text: 'Google',
//                         image: Image.asset(
//                           'assets/Google.webp',
//                           width: 30,
//                         ),
//                         width: 140,
//                       ),
//                       ButtonNetwork(
//                         text: 'Facebook',
//                         image: Image.asset(
//                           'assets/Facebook-logo.webp',
//                           width: 34,
//                         ),
//                         width: 160,
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Button register
//                 ButtonMain(
//                   onTap: () {},
//                   text: 'Registre-se',
//                 ),
//                 // Information for create account
//                 SizedBox(
//                   width: 200,
//                   child: RichText(
//                     textAlign: TextAlign.center,
//                     text: TextSpan(
//                       text: 'Já tem uma conta?',
//                       style: const TextStyle(
//                           color: CupertinoColors.black, fontSize: 18),
//                       children: [
//                         TextSpan(
//                             text: ' Clique aqui',
//                             style: const TextStyle(color: CupertinoColors.link),
//                             recognizer: TapGestureRecognizer()
//                               ..onTap = () => context.go("/")),
//                         const TextSpan(text: ' para entrar'),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
