import 'package:flutter/material.dart';

import '../widgets/responsive_layout_widget.dart';

import '../controllers/event_controller.dart';

class CategoryPage extends StatefulWidget {
  final String initCategory;
  final Map userDoc;
  const CategoryPage({
    Key? key,
    required this.userDoc,
    required this.initCategory,
  }) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List loadedEvents = [];

  void loadEvents() async {
    var temp = await EventController.instance.getEvents(
      widget.userDoc['homeground']['lat'],
      widget.userDoc['homeground']['lng'],
    );
    setState(() {
      loadedEvents = temp;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: CategoryMobilePage(
        eventsList: loadedEvents,
      ),
    );
  }
}

// ----------------------- MOBILE -------------------------- //

class CategoryMobilePage extends StatefulWidget {
  final List eventsList;
  const CategoryMobilePage({
    Key? key,
    required this.eventsList,
  }) : super(key: key);

  @override
  State<CategoryMobilePage> createState() => _CategoryMobilePageState();
}

class _CategoryMobilePageState extends State<CategoryMobilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey,
        child: Text(widget.eventsList.toString()),
      ),
    );
  }
}
