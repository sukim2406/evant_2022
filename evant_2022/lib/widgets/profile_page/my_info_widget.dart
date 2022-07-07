import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:get/get.dart';

import '../../widgets/responsive_layout_widget.dart';
import '../../widgets/rounded_btn_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/boxed_textfield_widget.dart';

import '../../controllers/global_controller.dart' as global;
import '../../controllers/storage_controller.dart';
import '../../controllers/user_controller.dart';

import '../../pages/landing_page.dart';

class MyInfoWidget extends StatefulWidget {
  final Map userDoc;
  const MyInfoWidget({
    Key? key,
    required this.userDoc,
  }) : super(key: key);

  @override
  State<MyInfoWidget> createState() => _MyInfoWidgetState();
}

class _MyInfoWidgetState extends State<MyInfoWidget> {
  TextEditingController screenNameController = TextEditingController();
  TextEditingController greetMsgController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    screenNameController.text = widget.userDoc['screenName'];
    greetMsgController.text = widget.userDoc['greetMsg'];
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: MyInfoMobileWidget(
        userDoc: widget.userDoc,
        screenNameController: screenNameController,
        greetMsgController: greetMsgController,
      ),
    );
  }
}

// --------------------------- MOBILE --------------------------- //

class MyInfoMobileWidget extends StatefulWidget {
  final TextEditingController screenNameController;
  final TextEditingController greetMsgController;
  final Map userDoc;
  const MyInfoMobileWidget({
    Key? key,
    required this.userDoc,
    required this.greetMsgController,
    required this.screenNameController,
  }) : super(key: key);

  @override
  State<MyInfoMobileWidget> createState() => _MyInfoMobileWidgetState();
}

class _MyInfoMobileWidgetState extends State<MyInfoMobileWidget> {
  late Uint8List newImage;
  bool imageSet = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .8,
      width: MediaQuery.of(context).size.width * .9,
      decoration: BoxDecoration(
        color: global.secondaryColor,
        border: Border.all(
          color: global.secondaryColor,
          width: 5,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: MediaQuery.of(context).size.height * .1,
            backgroundColor: global.secondaryColor,
            backgroundImage: (imageSet)
                ? Image.memory(newImage).image
                : Image.network(
                    widget.userDoc['profilePicture'],
                    fit: BoxFit.contain,
                  ).image,
          ),
          TextButton(
            onPressed: () async {
              if (imageSet) {
                setState(() {
                  imageSet = false;
                });
              } else {
                try {
                  // final imageData = await ImagePickerWeb.getImageInfo;
                  // print(p.basename(imageData!.fileName as String));
                  final image = await ImagePickerWeb.getImageAsBytes();

                  setState(() {
                    newImage = image!;
                    imageSet = true;
                  });
                } catch (e) {}
              }
            },
            child: (imageSet)
                ? const Text(
                    'Reset Image',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                : const Text(
                    'Change Profile Picture',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .025,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .4,
            width: MediaQuery.of(context).size.width * .8,
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .7,
                  child: const Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                BoxedTextFieldWidget(
                  hintText: widget.userDoc['email'],
                  width: MediaQuery.of(context).size.width * .7,
                  controller: TextEditingController(),
                  obsecure: false,
                  focusNode: FocusNode(),
                  enabled: false,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .7,
                  child: const Text(
                    'Screen Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                BoxedTextFieldWidget(
                  hintText: 'Screen Name',
                  width: MediaQuery.of(context).size.width * .7,
                  controller: widget.screenNameController,
                  obsecure: false,
                  focusNode: FocusNode(),
                  enabled: true,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .7,
                  child: const Text(
                    'Screen Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                BoxedTextFieldWidget(
                  hintText: 'Greet Message',
                  width: MediaQuery.of(context).size.width * .7,
                  controller: widget.greetMsgController,
                  obsecure: false,
                  focusNode: FocusNode(),
                  enabled: true,
                  height: MediaQuery.of(context).size.height * .15,
                  multiline: true,
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .025,
          ),
          RoundedBtnWidget(
            height: MediaQuery.of(context).size.height * .05,
            width: MediaQuery.of(context).size.width * .8,
            func: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoadingWidget(),
                ),
              );
              if (imageSet) {
                StorageController.instance
                    .uploadProfileImage(widget.userDoc['uid'], newImage)
                    .then((result) {
                  if (result) {
                    StorageController.instance
                        .getProfileImageUrl(widget.userDoc['uid'])
                        .then((url) {
                      if (url != '') {
                        UserController.instance
                            .updateProfile(
                          widget.userDoc['uid'],
                          url,
                          widget.screenNameController.text,
                          widget.greetMsgController.text,
                        )
                            .then((result) {
                          if (result) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const LandingPage(),
                              ),
                              (route) => false,
                            );
                          } else {
                            Get.snackbar(
                              'ERROR',
                              'updateProfile error',
                              duration: const Duration(seconds: 5),
                              onTap: (snackBar) {
                                print('updateProfile error');
                              },
                              backgroundColor: Colors.redAccent,
                              snackPosition: SnackPosition.BOTTOM,
                              titleText: const Text(
                                'updateProfile error',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            );
                            print('updateProfile error');
                            Navigator.pop(context);
                          }
                        });
                      } else {
                        Get.snackbar(
                          'ERROR',
                          'getProfileImageUrl error',
                          duration: const Duration(seconds: 5),
                          onTap: (snackBar) {
                            print('getProfileImageUrl error');
                          },
                          backgroundColor: Colors.redAccent,
                          snackPosition: SnackPosition.BOTTOM,
                          titleText: const Text(
                            'getProfileImageUrl error',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        );
                        print('getProfileImageUrl error');
                        Navigator.pop(context);
                      }
                    });
                  } else {
                    Get.snackbar(
                      'ERROR',
                      'uploadProfileImage error',
                      duration: const Duration(seconds: 5),
                      onTap: (snackBar) {
                        print('uploadProfileImage error');
                      },
                      backgroundColor: Colors.redAccent,
                      snackPosition: SnackPosition.BOTTOM,
                      titleText: const Text(
                        'uploadProfileImage error',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                    print('uploadProfileImage error');
                    Navigator.pop(context);
                  }
                });
              } else {
                {
                  UserController.instance
                      .updateProfileNoPicture(
                    widget.userDoc['uid'],
                    widget.screenNameController.text,
                    widget.greetMsgController.text,
                  )
                      .then((result) {
                    if (result) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const LandingPage(),
                        ),
                        (route) => false,
                      );
                    } else {
                      Get.snackbar(
                        'ERROR',
                        'updateProfileNoPicture error',
                        duration: const Duration(seconds: 5),
                        onTap: (snackBar) {
                          print('updateProfileNoPicture error');
                        },
                        backgroundColor: Colors.redAccent,
                        snackPosition: SnackPosition.BOTTOM,
                        titleText: const Text(
                          'updateProfileNoPicture error',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                      print('updateProfileNoPicture error');
                      Navigator.pop(context);
                    }
                  });
                }
              }
            },
            label: 'SAVE',
            btnColor: global.primaryColor,
            txtColor: Colors.white,
          )
        ],
      ),
    );
  }
}
