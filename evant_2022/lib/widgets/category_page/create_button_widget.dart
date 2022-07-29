import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controllers/global_controller.dart' as global;

import '../../widgets/responsive_layout_widget.dart';
import '../../widgets/rounded_btn_widget.dart';

import '../../pages/new_event_page.dart';

class CreateButtonWidget extends StatelessWidget {
  final Map userDoc;
  const CreateButtonWidget({
    Key? key,
    required this.userDoc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: CreateButtonMobileWidget(
        userDoc: userDoc,
      ),
    );
  }
}

// --------------------- MOBILE ----------------------- //

class CreateButtonMobileWidget extends StatefulWidget {
  final Map userDoc;
  const CreateButtonMobileWidget({
    Key? key,
    required this.userDoc,
  }) : super(key: key);

  @override
  State<CreateButtonMobileWidget> createState() =>
      _CreateButtonMobileWidgetState();
}

class _CreateButtonMobileWidgetState extends State<CreateButtonMobileWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .1,
      width: MediaQuery.of(context).size.width * .9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
            width: MediaQuery.of(context).size.width * .5,
            child: FittedBox(
              alignment: Alignment.centerRight,
              child: Text(
                'Can\'t find what you looking for ? ',
                style: GoogleFonts.yellowtail(),
              ),
            ),
          ),
          RoundedBtnWidget(
            height: MediaQuery.of(context).size.height * .05,
            width: MediaQuery.of(context).size.width * .2,
            func: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => NewEventPage(
                    userDoc: widget.userDoc,
                    point: LatLng(
                      widget.userDoc['homeground']['lat'],
                      widget.userDoc['homeground']['lng'],
                    ),
                  ),
                ),
              );
            },
            label: 'CREATE',
            btnColor: global.primaryColor,
            txtColor: Colors.white,
          )
        ],
      ),
    );
  }
}
