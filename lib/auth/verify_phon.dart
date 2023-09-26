import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/Ui/post/home_screen.dart';
import 'package:firebase_project/auth/utils/utils.dart';
import 'package:firebase_project/widgets/round_button.dart';
import 'package:flutter/material.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({super.key, required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading = false;
  final verifycodecontroler = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("verified"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: verifycodecontroler,
              decoration: const InputDecoration(hintText: "Enter 6 digit code"),
            ),
            const SizedBox(
              height: 80,
            ),
            RoundButton(
                title: 'Verify',
                loading: loading,
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  final Credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: verifycodecontroler.text.toString());
                  try {
                    await auth.signInWithCredential(Credential);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostScreen(),
                        ));
                  } catch (e) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage(e.toString());
                  }
                })
          ],
        ),
      ),
    );
  }
}
