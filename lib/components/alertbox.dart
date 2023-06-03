import 'package:flutter/material.dart';
import 'package:insighteye_app/constants/constants.dart';

import 'package:insighteye_app/screens/Admin/homeadminsrc.dart';

// ignore: must_be_immutable
class CustomeAlertbx extends StatelessWidget {
  String? techuid;
  final String? titles;
  final Color colorr;
  final String? done;
  CustomeAlertbx(this.titles, this.colorr, this.done, this.techuid, {super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: colorr,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: SizedBox(
        height: 200,
        width: 450,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: primarybg,
                    size: 30,
                  ),
                  Text(
                    done!,
                    style: const TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              titles!,
              style: const TextStyle(
                fontFamily: "Nunito",
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            InkWell(
              onTap: ()=>Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeAdmin()),
                ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: white),
                child: Text(
                  "Okay",
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: colorr,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
