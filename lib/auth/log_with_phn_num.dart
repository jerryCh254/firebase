import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_project/auth/utils/utils.dart';
import 'package:firebase_project/auth/verify_phon.dart';
import 'package:firebase_project/widgets/round_button.dart';
import 'package:flutter/material.dart';

class loginwithphoneNum extends StatefulWidget {
  const loginwithphoneNum({super.key});

  @override
  State<loginwithphoneNum> createState() => _loginwithphoneNumState();
}

class _loginwithphoneNumState extends State<loginwithphoneNum> {
  bool loading = false;
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Column(
        children: [
          const SizedBox(height: 80),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              keyboardType: TextInputType.text,
              controller: phoneNumberController,
              decoration: const InputDecoration(hintText: '+92 312 7083254'),
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          RoundButton(
            title: 'login',
            loading: loading,
            onTap: () {
              setState(() {
                loading = true;
              });
              auth.verifyPhoneNumber(
                  phoneNumber: phoneNumberController.text,
                  verificationCompleted: (_) {
                    setState(() {
                      loading = false;
                    });
                  },
                  verificationFailed: (e) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage(e.toString());
                  },
                  codeSent: (String verficationId, int? token) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              VerifyCodeScreen(verificationId: verficationId),
                        ));
                    setState(() {
                      loading = false;
                    });
                  },
                  codeAutoRetrievalTimeout: (e) {
                    Utils().toastMessage(e.toString());
                    setState(() {
                      loading = false;
                    });
                  });
            },
          )
        ],
      ),
    );
  }
}
