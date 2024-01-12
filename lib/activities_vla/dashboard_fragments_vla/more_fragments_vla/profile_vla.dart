import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:vel_app_online/constants_vla/constant_values_vla.dart';
import 'dart:async';

import '../../../main.dart';
import '../../../models_vla/profile_model_vla.dart';
import '../../../translation_vla/tr.dart';
import '../../../vidwath_custom_widgets/button_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/divider_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/edittext_label_icon_custom_vidwath.dart';
import '../../../vidwath_custom_widgets/text_custom_vidwath.dart';

class ProfileVLA extends StatefulWidget {
  var thisSetNewScreenFunc;

  ProfileVLA(this.thisSetNewScreenFunc, {Key? key}) : super(key: key);

  @override
  State<ProfileVLA> createState() => _ProfileVLAState();
}

class _ProfileVLAState extends State<ProfileVLA> {
  String userNamePVLA = "", emailPVLA = "", dobPVLA = "", cityPVLA = "";

  ProfileModelVLA profileModelVLA = ProfileModelVLA("bloodgroup", "", "DOB", "",
      "mobile", "", "school", "school_id", "status");

  double screenWidth = 0, screenHeight = 0;
  DateTime dobDateTime = DateTime(
    DateTime.now().year -
        int.parse(
            prefs.getString(ConstantValuesVLA.classnameJsonKey).toString()) -
        6,
    DateTime.now().month,
    DateTime.now().day,
  );

  bool wasDateChanged = false;

  DateTime? _selectedDate;
  String birthDateInString = "";

  //Method for showing the date picker
  void _pickDateDialog() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            //which date will display when user open the picker
            firstDate: DateTime(1900),
            //what will be the previous supported year in picker
            lastDate: DateTime
                .now()) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        _selectedDate = pickedDate;

        birthDateInString =
            "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}";
      });
    });
  }

  @override
  void initState() {
    super.initState();
    //showAlert();
    callGenerateOTPAPI();
    Future.delayed(const Duration(seconds: 0), () {
      appBarTitle = "My Profile";
      widget.thisSetNewScreenFunc(
        Container(),
        addToQueue: true,
        changeAppBar: true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2,
                            color: Colors.orangeAccent,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Image.asset(
                          "assets/dumm1.png",
                          height: screenWidth * .29,
                          width: screenWidth * .29,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          DividerCustomVidwath(
                            dividerHeight: 4,
                          ),
                          TextCustomVidwath(
                            textTCV: profileModelVLA.name == null ||
                                    profileModelVLA.name == ""
                                ? "Usern name"
                                : profileModelVLA.name,
                            fontSizeTCV: 20,
                            textColorTCV: ConstantValuesVLA.splashBgColor,
                            maxLines: 2,
                            fontWeightTCV: FontWeight.w700,
                          ),
                          DividerCustomVidwath(
                            dividerHeight: 5,
                          ),
                          TextCustomVidwath(
                            textTCV: profileModelVLA.mobile
                                .replaceAll("null", TR.mobile2[languageIndex]),
                            textColorTCV: ConstantValuesVLA.splashBgColor,
                            fontWeightTCV: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                DividerCustomVidwath(),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      TextCustomVidwath(
                        textTCV: "Name",
                        fontSizeTCV: 12,
                      ),
                    ],
                  ),
                ),
                EdittextLabelIconCustomVidwath(
                  initial_value: prefs
                              .getString(ConstantValuesVLA.usernameJsonKey)
                              .toString() ==
                          "null"
                      ? ""
                      : prefs
                          .getString(ConstantValuesVLA.usernameJsonKey)
                          .toString(),
                  onChangedECV: (tempOnChangedText) {
                    userNamePVLA = tempOnChangedText;
                    setState(() {
                      userNamePVLA;
                    });
                  },
                  maximumCharsECV: 50,
                  textInputTypeECV: TextInputType.name,
                  labelIConECV: Icons.account_circle_outlined,
                  titleECV: profileModelVLA.name
                      .replaceAll("null", TR.name[languageIndex]),
                  hintTextECV: TR.name[languageIndex],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      TextCustomVidwath(
                        textTCV: "Email",
                        fontSizeTCV: 12,
                      ),
                    ],
                  ),
                ),
                EdittextLabelIconCustomVidwath(
                  initial_value: prefs
                              .getString(ConstantValuesVLA.emailJsonKey)
                              .toString() ==
                          "null"
                      ? ""
                      : prefs
                          .getString(ConstantValuesVLA.emailJsonKey)
                          .toString(),
                  onChangedECV: (tempOnChangedText) {
                    emailPVLA = tempOnChangedText;
                    setState(() {
                      emailPVLA;
                    });
                  },
                  maximumCharsECV: 30,
                  textInputTypeECV: TextInputType.emailAddress,
                  labelIConECV: Icons.email_outlined,
                  titleECV: profileModelVLA.email
                      .replaceAll("null", TR.email[languageIndex]),
                  hintTextECV: TR.email[languageIndex],
                ),
                /*    Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  TextCustomVidwath(
                    textTCV: "  " + TR.date_of_birth[languageIndex],
                  )
                ],
              ),
            ),*/
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      TextCustomVidwath(
                        textTCV: "Date of Birth",
                        fontSizeTCV: 12,
                      )
                    ],
                  ),
                ),

                /* Container(
              color: const Color.fromRGBO(207, 207, 207, 1.0),
              height: 126,
              width: MediaQuery.of(context).size.width - 81,
              child: ScrollDatePicker(
                // date range from 2yrs to 27yrs
                minimumDate: DateTime(DateTime.now().year - 27),
                maximumDate: DateTime(DateTime.now().year - 2),
                options: const DatePickerOptions(isLoop: true),
                selectedDate: dobDateTime,
                onDateTimeChanged: (DateTime value) {
                  wasDateChanged = true;
                  setState(() {
                    dobDateTime = value;
                  });
                },
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: screenWidth / 1.53,
                padding: const EdgeInsets.fromLTRB(0, 0, 32, 0),
                child: Text(
                  (profileModelVLA.DOB.contains("dd/mm/yy") &&
                          (!wasDateChanged))
                      ? TR.youHaveNotEntered[languageIndex]
                      : DateFormat('E dd MMM y')
                              .format(dobDateTime)
                              .toString() +
                          "      ",
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.right,
                ),
              ),
            ),*/

                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: InkWell(
                    onTap: _pickDateDialog,
                    child: Container(
                      height: 53,
                      margin: const EdgeInsets.fromLTRB(2, 5, 2, 0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 8,
                          ),
                          Icon(
                            Icons.date_range,
                            size: 30,
                            color: ConstantValuesVLA.splashBgColor,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          _selectedDate == null
                              ? TextCustomVidwath(
                                  textTCV: prefs
                                                  .getString(ConstantValuesVLA
                                                      .dobJsonKey)
                                                  .toString() ==
                                              null ||
                                          prefs
                                                  .getString(ConstantValuesVLA
                                                      .dobJsonKey)
                                                  .toString() ==
                                              "null" ||
                                          prefs
                                                  .getString(ConstantValuesVLA
                                                      .dobJsonKey)
                                                  .toString() ==
                                              "" ||
                                          prefs
                                                  .getString(ConstantValuesVLA
                                                      .dobJsonKey)
                                                  .toString() ==
                                              "dd/mm/yy"
                                      ? "dd/mm/yy"
                                      : prefs
                                          .getString(
                                              ConstantValuesVLA.dobJsonKey)
                                          .toString(),
                                  fontSizeTCV: 14,
                                  textColorTCV: prefs
                                                  .getString(ConstantValuesVLA
                                                      .dobJsonKey)
                                                  .toString() ==
                                              "null" ||
                                          prefs
                                                  .getString(ConstantValuesVLA
                                                      .dobJsonKey)
                                                  .toString() ==
                                              "" ||
                                          prefs
                                                  .getString(ConstantValuesVLA
                                                      .dobJsonKey)
                                                  .toString() ==
                                              "dd/mm/yy"
                                      ? Colors.grey.shade600
                                      : Colors.black,
                                )
                              : TextCustomVidwath(
                                  textTCV: '${birthDateInString}',
                                  fontSizeTCV: 14,
                                  textColorTCV: Colors.black,
                                )
                        ],
                      ),
                    ),
                  ),
                ),
                DividerCustomVidwath(),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      TextCustomVidwath(
                        textTCV: "City",
                        fontSizeTCV: 12,
                      )
                    ],
                  ),
                ),
                EdittextLabelIconCustomVidwath(
                  initial_value: prefs
                              .getString(ConstantValuesVLA.districtJsonKey)
                              .toString() ==
                          "null"
                      ? ""
                      : prefs
                          .getString(ConstantValuesVLA.districtJsonKey)
                          .toString(),
                  onChangedECV: (tempOnChangedText) {
                    cityPVLA = tempOnChangedText;
                    setState(() {
                      cityPVLA;
                    });
                  },
                  maximumCharsECV: 20,
                  textInputTypeECV: TextInputType.name,
                  labelIConECV: Icons.location_city,
                  //titleECV: profileModelVLA.district.replaceAll("null", TR.city[languageIndex]).replaceAll("0", TR.city[languageIndex]),
                  hintTextECV: TR.city[languageIndex],
                ),
                ButtonCustomVidwath(
                  onPressedBCV: () {
                    if (userNamePVLA == "null" || userNamePVLA == "") {
                      var snackBar = const SnackBar(
                        content: Text("Please fill your user name field"),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 5),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (emailPVLA == "null" || emailPVLA == "") {
                      var snackBar = const SnackBar(
                        content: Text("Please fill your email id field"),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 5),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (!RegExp(
                            r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""")
                        .hasMatch(emailPVLA)) {
                      var snackBar = const SnackBar(
                        content: Text("Please enter a valid email id"),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 5),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (birthDateInString == null ||
                        prefs
                                .getString(ConstantValuesVLA.dobJsonKey)
                                .toString() ==
                            "") {
                      var snackBar = const SnackBar(
                        content: Text("Please select your date of birth"),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 5),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (cityPVLA == "null" || cityPVLA == "") {
                      var snackBar = const SnackBar(
                        content: Text("Please fill your city field"),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 5),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      callUpdateProfileAPI();

                      print(
                          '***************MODAL ********************${prefs.getString(ConstantValuesVLA.modelJsonKey)}');
                    }
                  },
                  textBCV: TR.savec[languageIndex],
                  enabledBgColorBCV: ConstantValuesVLA.splashBgColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> callGenerateOTPAPI() async {
    // print(prefs.getString(ConstantValuesVLA.useridJsonKey));
    var url = Uri.parse(
        ConstantValuesVLA.baseURLConstant + ConstantValuesVLA.profileConstant);

    http
        .post(url,
            body: jsonEncode({
              ConstantValuesVLA.user_idJsonKey:
                  prefs.getString(ConstantValuesVLA.user_idJsonKey).toString()
            }))
        .then((value) {
      profileModelVLA = ProfileModelVLA.fromJson(jsonDecode(value.body));
      // print("profileModelVLA.DOB");
      // print(profileModelVLA.DOB);

      birthDateInString = profileModelVLA.DOB;
      userNamePVLA = profileModelVLA.name;
      emailPVLA = profileModelVLA.email;
      cityPVLA = profileModelVLA.district;
      setState(() {
        profileModelVLA;
        birthDateInString;
        userNamePVLA;
        emailPVLA;
        cityPVLA;
      });
    });
  }

  Future<void> callUpdateProfileAPI() async {
    var url = Uri.parse(ConstantValuesVLA.baseURLConstant +
        ConstantValuesVLA.updateProfileConstant);
    var userEnteredData = {
      ConstantValuesVLA.user_idJsonKey:
          prefs.getString(ConstantValuesVLA.user_idJsonKey),
      "name": userNamePVLA == null
          ? prefs.getString(ConstantValuesVLA.usernameJsonKey).toString()
          : userNamePVLA,
      "email": emailPVLA == null
          ? prefs.getString(ConstantValuesVLA.emailJsonKey).toString()
          : emailPVLA,
      "dob": _selectedDate == null
          ? prefs.getString(ConstantValuesVLA.dobJsonKey).toString()
          : birthDateInString,
      "city": cityPVLA == null
          ? prefs.getString(ConstantValuesVLA.districtJsonKey).toString()
          : cityPVLA
    };
    // print("userEnteredData");
    // print(userEnteredData);
    http.post(url, body: jsonEncode(userEnteredData)).then((value) {
      // print("prefs.getString(ConstantValuesVLA.user_idJsonKey)");
      // print(prefs.getString(ConstantValuesVLA.user_idJsonKey));
      // print(value.body);
      var snackBar = SnackBar(
        content: Text(TR.profileSavedSuccessfully[languageIndex]),
        backgroundColor: Colors.indigoAccent,
        duration: const Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      prefs.setString(ConstantValuesVLA.usernameJsonKey, userNamePVLA);
      prefs.setString(ConstantValuesVLA.emailJsonKey, emailPVLA);
      prefs.setString(
          ConstantValuesVLA.dobJsonKey, birthDateInString.toString());
      prefs.setString(ConstantValuesVLA.districtJsonKey, cityPVLA);
      callGenerateOTPAPI();
    });
  }

  Future<bool> onBackPressed() {
    listOfWidgetForBack.removeLast();
    widget.thisSetNewScreenFunc(listOfWidgetForBack.last, addToQueue: false);
    return Future.value(false);
  }
}
