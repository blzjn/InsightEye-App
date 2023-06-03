import 'package:flutter/material.dart';
import 'package:insighteye_app/constants/constants.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:insighteye_app/Screens/Auth/login_src.dart';

class LoadingSrc extends StatelessWidget {
  const LoadingSrc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primarybg,
      body: SafeArea(
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20, top: 20),
                  child: InkWell(
                     onTap: () => logout(context),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        color: redbg,
                        shape: BoxShape.circle,
                      ),
                      child: const Text("X", style: TextStyle(fontFamily: "Nunito", color: redfg, fontWeight: FontWeight.bold, fontSize: 18),)
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: s.height,
              width: s.width,
              child: Center(
                child: Image.asset(
                  "assets/Icons/imaicon.png",
                  width: 150,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: s.height * 0.7),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.redAccent,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

    // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginSrc()));
  }
}
