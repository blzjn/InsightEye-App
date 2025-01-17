import 'package:flutter/material.dart';
import 'package:insighteye_app/Screens/models/user_model.dart';
import 'package:insighteye_app/components/circularprogress.dart';
import 'package:insighteye_app/components/techpgmcard.dart';
import 'package:insighteye_app/constants/constants.dart';
import 'package:insighteye_app/screens/Technician/todaysreportsrc.dart';

import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insighteye_app/screens/Technician/profilesrc.dart';
import 'package:insighteye_app/screens/Technician/reportsubmissionsrc.dart';
// Loading indicator
import "package:loading_indicator/loading_indicator.dart";

import 'package:iconsax/iconsax.dart';

// ignore: must_be_immutable
class HomeTech extends StatefulWidget {
  const HomeTech({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeTechState createState() => _HomeTechState();
}

class _HomeTechState extends State<HomeTech> {
  final user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore fb = FirebaseFirestore.instance;

  String? name;
  String? techuid;
  int pgmSize = -1;
  String? orgId;
  String? uid;
  UserModel profile = UserModel();

  int a = 0;
  int p = 0;
  int c = 0;
  int pro = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    String displayName = user?.displayName ?? '';
    if (user != null && displayName != "") {
      setState(() {
        orgId = displayName.substring(1);
        uid = user?.uid;
      });
      FirebaseFirestore.instance
          .collection("organizations")
          .doc("$orgId")
          .collection("technician")
          .doc(uid)
          .get()
          .then((value) {
        setState(() {
          profile = UserModel.fromMap(value.data());
        });
      });
    }
  }

  // report visiblity
  bool rp_viz = false;

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;

    // Tech vihicle docname
    DateTime now = DateTime.now();
    String techvdoc = DateFormat('MM d').format(now);
    // Report
    String day = DateFormat('d').format(now);
    String month = DateFormat('MM').format(now);
    String year = DateFormat('y').format(now);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: white,
      drawer: Drawer(
          backgroundColor: techbg,
          child: Builder(
            builder: (context) => SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: s.height * 0.2,
                      child: Padding(
                        padding: EdgeInsets.all(s.height * 0.01),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: profile.imgUrl != null
                                  ? CircleAvatar(
                                      radius: s.height * 0.06,
                                      backgroundImage:
                                          NetworkImage("${profile.imgUrl}"),
                                    )
                                  : Image.asset(
                                      "assets/Icons/tech_avatar1.png",
                                      height: s.height * 0.12,
                                    ),
                            ),
                            Center(
                              child: profile.name != null
                                  ? Text(
                                      "${profile.name}",
                                      style: const TextStyle(
                                          fontFamily: "Nunito",
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                    )
                                  : const SizedBox(
                                      height: 18,
                                      width: 18,
                                      child: CircularProgressIndicator(
                                        color: white,
                                      )),
                            )
                          ],
                        ),
                      ),
                    ),
                    // Navigation List

                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: s.width * 0.04,
                              right: s.width * 0.1,
                              bottom: s.height * 0.03,
                              top: s.height * 0.03),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(s.width * 0.02),
                                child: InkWell(
                                  onTap: () =>
                                      Scaffold.of(context).closeDrawer(),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: white),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Iconsax.home,
                                          color: white,
                                        ),
                                        SizedBox(
                                          width: s.width * 0.04,
                                        ),
                                        const Text(
                                          "Home",
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            color: white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(s.width * 0.02),
                                child: InkWell(
                                  onTap: () {
                                    Scaffold.of(context).closeDrawer();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Profilesrc(
                                                orgId: orgId,
                                                uid: uid,
                                                name: profile.name,
                                                img: user?.photoURL,
                                                techuid: uid,
                                              )),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: white),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Iconsax.personalcard,
                                          color: white,
                                        ),
                                        SizedBox(
                                          width: s.width * 0.04,
                                        ),
                                        const Text(
                                          "Profile",
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            color: white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(s.width * 0.02),
                                child: InkWell(
                                  onTap: () {
                                    Scaffold.of(context).closeDrawer();
                                    if (pgmSize == -1) {
                                      // something is wrong
                                      showDialog(
                                          context: context,
                                          builder: (context) => Dialog(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: s
                                                                      .width *
                                                                  0.02,
                                                              vertical:
                                                                  s.width *
                                                                      0.02),
                                                      child: Column(
                                                        children: [
                                                          const Text(
                                                            "Something went wrong :(",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: Color(
                                                                  0XFF607cf2),
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          const Text(
                                                            "try again later?",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: Color(
                                                                  0XFF607cf2),
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25),
                                                              color: white,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  offset:
                                                                      const Offset(
                                                                          2, 4),
                                                                  blurRadius:
                                                                      20,
                                                                  color: secondbg
                                                                      .withOpacity(
                                                                          0.23),
                                                                ),
                                                              ],
                                                            ),
                                                            clipBehavior:
                                                                Clip.hardEdge,
                                                            child: Image.asset(
                                                                "assets/Icons/something_w.jpg"),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ));
                                    }
                                    if (pgmSize == 0) {
                                      // Dialog box for confirmation
                                      fb
                                          .collection("organizations")
                                          .doc("$orgId")
                                          .collection("Reports")
                                          .doc(year)
                                          .collection("Month")
                                          .doc(month)
                                          .collection(day)
                                          .doc("Tech")
                                          .collection("Reports")
                                          .doc("$uid")
                                          .get()
                                          .then(
                                        (DocumentSnapshot doc) {
                                          if (!doc.exists) {
                                            // Report submit screen wrappping when there is no data exists
                                            showDialog(
                                                context: context,
                                                builder: (context) => Dialog(
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            s.width * 0.03),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            SizedBox(
                                                              width: s.width *
                                                                  0.25,
                                                              height: s.width *
                                                                  0.25,
                                                              child:
                                                                  Image.asset(
                                                                "assets/Icons/q_mark.png",
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            ),
                                                            const Text(
                                                              "Are you sure?",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Montserrat",
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            const Text(
                                                              "Would you like to submit your daily report?",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "Montserrat",
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Flexible(
                                                                  flex: 1,
                                                                  fit: FlexFit
                                                                      .tight,
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () =>
                                                                        Navigator.pop(
                                                                            context),
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(15),
                                                                        color: const Color(
                                                                            0XFF5963d5),
                                                                      ),
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              10),
                                                                      child:
                                                                          const Center(
                                                                        child:
                                                                            Text(
                                                                          "Cancel",
                                                                          style: TextStyle(
                                                                              fontFamily: "Montserrat",
                                                                              fontSize: 16,
                                                                              color: white,
                                                                              fontWeight: FontWeight.w600),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                Flexible(
                                                                  flex: 1,
                                                                  fit: FlexFit
                                                                      .tight,
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) => ReportSubmissionSrc(
                                                                              techuid: uid,
                                                                              techname: profile.name,
                                                                              orgId: orgId),
                                                                        ),
                                                                      );
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(15),
                                                                        color: const Color(
                                                                            0XFF5963d5),
                                                                      ),
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              10),
                                                                      child:
                                                                          const Center(
                                                                        child:
                                                                            Text(
                                                                          "Ok",
                                                                          style: TextStyle(
                                                                              fontFamily: "Montserrat",
                                                                              fontSize: 16,
                                                                              color: white,
                                                                              fontWeight: FontWeight.w600),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: s.width *
                                                                  0.035,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ));
                                          } else {
                                            try {
                                              bool nested = doc.get(
                                                  FieldPath(const ['submit']));
                                              if (nested) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Todaysreportsrc(
                                                              techuid: techuid,
                                                              orgId: orgId,
                                                            )));
                                              } else {
                                                // Update when the submit is flase
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (context) => Dialog(
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .all(s.width *
                                                                        0.03),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    SizedBox(
                                                                      width: s.width *
                                                                          0.25,
                                                                      height:
                                                                          s.width *
                                                                              0.25,
                                                                      child: Image
                                                                          .asset(
                                                                        "assets/Icons/q_mark.png",
                                                                        fit: BoxFit
                                                                            .contain,
                                                                      ),
                                                                    ),
                                                                    const Text(
                                                                      "Are you sure?",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "Montserrat",
                                                                          fontSize:
                                                                              17,
                                                                          fontWeight:
                                                                              FontWeight.w700),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            10),
                                                                    const Text(
                                                                      "Would you like to submit your daily report?",
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            "Montserrat",
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        Flexible(
                                                                          flex:
                                                                              1,
                                                                          fit: FlexFit
                                                                              .tight,
                                                                          child:
                                                                              InkWell(
                                                                            onTap: () =>
                                                                                Navigator.pop(context),
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(15),
                                                                                color: const Color(0XFF5963d5),
                                                                              ),
                                                                              padding: const EdgeInsets.symmetric(vertical: 10),
                                                                              child: const Center(
                                                                                child: Text(
                                                                                  "Cancel",
                                                                                  style: TextStyle(fontFamily: "Montserrat", fontSize: 16, color: white, fontWeight: FontWeight.w600),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            width:
                                                                                10),
                                                                        Flexible(
                                                                          flex:
                                                                              1,
                                                                          fit: FlexFit
                                                                              .tight,
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.of(context).pop();
                                                                              Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                  builder: (context) => ReportSubmissionSrc(
                                                                                    techuid: uid,
                                                                                    techname: profile.name,
                                                                                    orgId: orgId,
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(15),
                                                                                color: const Color(0XFF5963d5),
                                                                              ),
                                                                              padding: const EdgeInsets.symmetric(vertical: 10),
                                                                              child: const Center(
                                                                                child: Text(
                                                                                  "Ok",
                                                                                  style: TextStyle(fontFamily: "Montserrat", fontSize: 16, color: white, fontWeight: FontWeight.w600),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height: s
                                                                              .width *
                                                                          0.035,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ));
                                              }
                                            } on StateError {
                                              print(
                                                  'Feild is not exist error!');
                                            }
                                          }
                                        },
                                        onError: (e) => print(
                                            "Assigned Counter update Error: $e"),
                                      );
                                    }
                                    if (pgmSize > 0) {
                                      // You have more work to do
                                      showDialog(
                                          context: context,
                                          builder: (context) => Dialog(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: s
                                                                      .width *
                                                                  0.02,
                                                              vertical:
                                                                  s.width *
                                                                      0.02),
                                                      child: Column(
                                                        children: [
                                                          const Text(
                                                            "You have more work to do",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: Color(
                                                                  0XFF9bdffe),
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25),
                                                              color: white,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  offset:
                                                                      const Offset(
                                                                          2, 4),
                                                                  blurRadius:
                                                                      20,
                                                                  color: secondbg
                                                                      .withOpacity(
                                                                          0.23),
                                                                ),
                                                              ],
                                                            ),
                                                            clipBehavior:
                                                                Clip.hardEdge,
                                                            child: Image.asset(
                                                                "assets/Icons/not_completed.jpg"),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ));
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: white),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Iconsax.receipt,
                                          color: white,
                                        ),
                                        SizedBox(
                                          width: s.width * 0.04,
                                        ),
                                        const Text(
                                          "Report status",
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            color: white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(s.width * 0.02),
                                child: InkWell(
                                  onTap: () {
                                    Scaffold.of(context).closeDrawer();
                                    showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: s.height * 0.03,
                                                    horizontal: s.width * 0.02),
                                                child: FutureBuilder<
                                                    DocumentSnapshot>(
                                                  future: fb
                                                      .collection(
                                                          "organizations")
                                                      .doc("$orgId")
                                                      .collection("technician")
                                                      .doc(techuid)
                                                      .collection("Vehicle")
                                                      .doc(techvdoc)
                                                      .get(),
                                                  builder: (BuildContext
                                                          context,
                                                      AsyncSnapshot<
                                                              DocumentSnapshot>
                                                          snapshot) {
                                                    if (snapshot.hasError) {
                                                      return const Text(
                                                          "Something went wrong");
                                                    }

                                                    if (snapshot.hasData &&
                                                        !snapshot
                                                            .data!.exists) {
                                                      return Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        s.width *
                                                                            0.02,
                                                                    vertical:
                                                                        s.width *
                                                                            0.02),
                                                            child: Column(
                                                              children: [
                                                                const Text(
                                                                  "No Vehicle Assigned",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Montserrat",
                                                                      fontSize:
                                                                          17,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      color: Colors
                                                                          .blueGrey),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            25),
                                                                    color:
                                                                        white,
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        offset: const Offset(
                                                                            2,
                                                                            4),
                                                                        blurRadius:
                                                                            20,
                                                                        color: secondbg
                                                                            .withOpacity(0.23),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  clipBehavior:
                                                                      Clip.hardEdge,
                                                                  child: Image
                                                                      .asset(
                                                                          "assets/Icons/empty_garage.jpg"),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }

                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState.done) {
                                                      Map<String, dynamic>
                                                          data =
                                                          snapshot.data!.data()
                                                              as Map<String,
                                                                  dynamic>;
                                                      return Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Text(
                                                            "Vehicle Status",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Montserrat",
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: bluebg),
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          Container(
                                                            height:
                                                                s.width * 0.5,
                                                            clipBehavior:
                                                                Clip.hardEdge,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              color: redbg,
                                                            ),
                                                            child: Image.asset(
                                                              'assets/gif/delivery.gif',
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            "${data["name"]}",
                                                            style:
                                                                const TextStyle(
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Text(
                                                                    "${data["upTime"]}",
                                                                    style:
                                                                        const TextStyle(
                                                                      fontFamily:
                                                                          "Montserrt",
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "${data["upDate"]}",
                                                                    style:
                                                                        const TextStyle(
                                                                      fontFamily:
                                                                          "Montserrt",
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      );
                                                    }

                                                    return Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25),
                                                            color: white,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                offset:
                                                                    const Offset(
                                                                        0, 10),
                                                                blurRadius: 20,
                                                                color: secondbg
                                                                    .withOpacity(
                                                                        0.23),
                                                              ),
                                                            ],
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        s.width *
                                                                            0.1),
                                                            child: Center(
                                                              child: SizedBox(
                                                                width: s.width *
                                                                    0.15,
                                                                height:
                                                                    s.width *
                                                                        0.15,
                                                                child:
                                                                    const LoadingIndicator(
                                                                  indicatorType:
                                                                      Indicator
                                                                          .ballClipRotateMultiple,
                                                                  colors: [
                                                                    bluebg
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ),
                                            ));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: white),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Iconsax.truck,
                                          color: white,
                                        ),
                                        SizedBox(
                                          width: s.width * 0.04,
                                        ),
                                        const Text(
                                          "Vehicle Status",
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            color: white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
      appBar: AppBar(
        centerTitle: true,
        leading: Builder(
          builder: (context) => InkWell(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Padding(
              padding: EdgeInsets.all(s.width * 0.03),
              child: Image.asset(
                "assets/Icons/menu.png",
                color: techbg,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Profilesrc(
                          orgId: orgId,
                          uid: uid,
                          name: profile.name,
                          img: user?.photoURL,
                          techuid: uid,
                        )),
              );
            },
            icon: const Icon(Icons.person),
            color: techbg,
            iconSize: 30,
          ),
        ],
        elevation: 0,
        title: const Text(
          "WorkZone",
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: techbg,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: fb
                    .collection("organizations")
                    .doc("$orgId")
                    .collection("Reports")
                    .doc(year)
                    .collection("Month")
                    .doc(month)
                    .collection(day)
                    .doc("Tech")
                    .collection("Reports")
                    .doc("$uid")
                    .collection("Activity")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {}
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressBar(
                      strokeWidth: 18.0,
                      progress: 0,
                      totalCount: 0,
                      completedCount: 0,
                    );
                  }

                  // fetched data assigning phase
                  final List rpactivity = [];
                  snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map a = document.data() as Map<String, dynamic>;
                    rpactivity.add(a);
                  }).toList();

                  List pendingpgms = rpactivity
                      .where((i) => i['status'] == 'pending')
                      .toList();

                  List completedpgm = rpactivity
                      .where((i) => i['status'] == 'completed')
                      .toList();

                  List processingpgm = rpactivity
                      .where((i) => i['status'] == 'processing')
                      .toList();

                  List assigned = rpactivity
                      .where((i) => i['status'] == 'assigned')
                      .toList();

                  a = assigned.length;
                  p = pendingpgms.length;
                  pro = processingpgm.length;
                  c = completedpgm.length;

                  int total = p + pro + c;
                  double progress = 0;

                  if (a != 0) {
                    progress = (total / a) * 100;
                  } else if (a < total) {
                    a = total;
                    progress = 100;
                  }

                  return CircularProgressBar(
                    strokeWidth: 18.0,
                    progress: progress,
                    totalCount: a,
                    completedCount: total,
                  );
                }),
            const SizedBox(
              height: 40,
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Color(0XFF9643D6),
                ),
                clipBehavior: Clip.hardEdge,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 17,
                      ),
                      const Text(
                        "Today’s Work",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("organizations")
                              .doc("$orgId")
                              .collection("technician")
                              .doc("$uid")
                              .collection("Assignedpgm")
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              pgmSize = -1;
                              return const Center(
                                  child: Text("Something Went Wrong :(",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 20,
                                          color: cheryred)));
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              pgmSize = -1;
                              return SizedBox(
                                height: s.height * 0.535,
                                child: const Center(
                                  child: SizedBox(
                                    width: 50,
                                    child: LoadingIndicator(
                                      indicatorType: Indicator.ballBeat,
                                      colors: [white],
                                      strokeWidth: 10,
                                    ),
                                  ),
                                ),
                              );
                            }

                            List allpgm = [];
                            snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map a = document.data() as Map<String, dynamic>;
                              allpgm.add(a);
                              a['uid'] = document.id;
                            }).toList();

                            pgmSize = allpgm.length;

                            // Report button visiblity
                            if (allpgm.isEmpty) {
                              rp_viz = true;
                            }

                            allpgm.sort((a, b) =>
                                a["priority"].compareTo(b["priority"]));
                            return Container(
                              child: allpgm.length > 0
                                  ? Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        for (var i = 0;
                                            i < allpgm.length;
                                            i++) ...[
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          TechPgmCard(
                                            uid: allpgm[i]['uid'],
                                            name: allpgm[i]['name'],
                                            address: allpgm[i]['address'],
                                            loc: allpgm[i]['loc'],
                                            phn: allpgm[i]['phn'],
                                            pgm: allpgm[i]['pgm'],
                                            chrg: allpgm[i]['chrg'],
                                            type: allpgm[i]['type'],
                                            upDate: allpgm[i]['upDate'],
                                            upTime: allpgm[i]['upTime'],
                                            docname: allpgm[i]['docname'],
                                            status: allpgm[i]['status'],
                                            techuid: allpgm[i]['techuid'],
                                            techname: allpgm[i]['techname'],
                                            assignedtime: allpgm[i]
                                                ['assignedtime'],
                                            prospec: allpgm[i]['prospec'],
                                            instadate: allpgm[i]['instadate'],
                                            assigneddate: allpgm[i]
                                                ['assigneddate'],
                                            priority: allpgm[i]['priority'],
                                            custdocname: allpgm[i]
                                                ['custdocname'],
                                            orgId: orgId,
                                          ),
                                        ],
                                        const SizedBox(
                                          height: 30,
                                        ),
                                      ],
                                    )
                                  : Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 20),
                                        child: Container(
                                          height: s.height * 0.07,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: const Color.fromARGB(
                                                  255, 255, 244, 252),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ]),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Icon(
                                                Iconsax.briefcase,
                                                color: techbg,
                                                size: 30,
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                "No More Tasks",
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: techbg,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
