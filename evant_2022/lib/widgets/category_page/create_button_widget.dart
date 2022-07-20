import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/global_controller.dart' as global;

import '../../widgets/responsive_layout_widget.dart';
import '../../widgets/rounded_btn_widget.dart';

class CreateButtonWidget extends StatelessWidget {
  const CreateButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayoutWidget(
      mobileVer: CreateButtonMobileWidget(),
    );
  }
}

// --------------------- MOBILE ----------------------- //

class CreateButtonMobileWidget extends StatefulWidget {
  const CreateButtonMobileWidget({Key? key}) : super(key: key);

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
            func: () {},
            label: 'CREATE',
            btnColor: global.primaryColor,
            txtColor: Colors.white,
          )
        ],
      ),
    );
  }
}
