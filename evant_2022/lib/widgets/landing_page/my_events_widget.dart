import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/global_controller.dart' as global;

import '../../widgets/responsive_layout_widget.dart';

class MyEventsWidget extends StatefulWidget {
  const MyEventsWidget({Key? key}) : super(key: key);

  @override
  State<MyEventsWidget> createState() => _MyEventsWidgetState();
}

class _MyEventsWidgetState extends State<MyEventsWidget> {
  late ScrollController scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: MyEventsMobileWidget(
        controller: scrollController,
      ),
      tabeltVer: MyEventsTabletWidget(
        controller: scrollController,
      ),
    );
  }
}

// -------------------------- MOBILE ------------------------ //

class MyEventsMobileWidget extends StatefulWidget {
  final ScrollController controller;
  const MyEventsMobileWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<MyEventsMobileWidget> createState() => _MyEventsMobileWidgetState();
}

class _MyEventsMobileWidgetState extends State<MyEventsMobileWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .05,
          width: MediaQuery.of(context).size.width * .9,
          child: FittedBox(
            alignment: Alignment.centerLeft,
            child: Text('My Events',
                style: GoogleFonts.yellowtail(
                  color: global.secondaryColor,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * .3,
          width: MediaQuery.of(context).size.width * .9,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            color: Color.fromRGBO(82, 82, 82, .5),
          ),
          child: ListView.separated(
            controller: widget.controller,
            padding: const EdgeInsets.all(8),
            itemCount: global.tempFollowing.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Text(global.tempFollowing[index]['host']),
                title: Text(global.tempFollowing[index]['title']),
                subtitle: Text(
                    '${global.tempFollowing[index]['attending']} / ${global.tempFollowing[index]['limit']}'),
                trailing: Text(global.tempFollowing[index]['category']),
              );
            },
            separatorBuilder: (BuildContext context, index) => const Divider(),
          ),
        ),
      ],
    );
  }
}

// ---------------------------- TABLET -------------------------------//

class MyEventsTabletWidget extends StatefulWidget {
  final ScrollController controller;
  const MyEventsTabletWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<MyEventsTabletWidget> createState() => _MyEventsTabletWidgetState();
}

class _MyEventsTabletWidgetState extends State<MyEventsTabletWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .05,
          width: MediaQuery.of(context).size.width * .3,
          child: FittedBox(
            alignment: Alignment.centerLeft,
            child: Text('My Events',
                style: GoogleFonts.yellowtail(
                  color: global.secondaryColor,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * .2,
          width: MediaQuery.of(context).size.width * .25,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            color: Color.fromRGBO(82, 82, 82, .5),
          ),
          child: ListView.separated(
            controller: widget.controller,
            padding: const EdgeInsets.all(8),
            itemCount: global.tempFollowing.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Text(global.tempFollowing[index]['host']),
                title: Text(global.tempFollowing[index]['title']),
                subtitle: Text(
                    '${global.tempFollowing[index]['attending']} / ${global.tempFollowing[index]['limit']}'),
                trailing: Text(global.tempFollowing[index]['category']),
              );
            },
            separatorBuilder: (BuildContext context, index) => const Divider(),
          ),
        ),
      ],
    );
  }
}
