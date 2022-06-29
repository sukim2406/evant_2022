import 'package:flutter/material.dart';

import '../controllers/global_controller.dart' as global;

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .2,
            child: const Image(
              image: AssetImage('img/logoevant.png'),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .8,
            child: const ProgressIndicatorTheme(
              data: ProgressIndicatorThemeData(
                color: global.primaryColor,
                linearTrackColor: Colors.grey,
              ),
              child: LinearProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
