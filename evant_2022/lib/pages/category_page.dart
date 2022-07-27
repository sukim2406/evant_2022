import 'package:flutter/material.dart';

import '../widgets/responsive_layout_widget.dart';
import '../widgets/landing_page/app_bar_widget.dart';
import '../widgets/category_page/category_message_widget.dart';
import '../widgets/category_page/category_table_widget.dart';
import '../widgets/category_page/create_button_widget.dart';
import '../widgets/category_page/dropdown_widget.dart';

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
  late String selectedCategory;

  void loadEvents() async {
    var temp = await EventController.instance.getEvents(
      widget.userDoc['homeground']['lat'],
      widget.userDoc['homeground']['lng'],
    );
    setState(() {
      loadedEvents = temp;
    });
  }

  void loadEventsByCategory() async {
    var temp = await EventController.instance.getEventsByCategory(
      widget.userDoc['homeground']['lat'],
      widget.userDoc['homeground']['lng'],
      selectedCategory,
    );
    setState(() {
      loadedEvents = temp;
    });
  }

  void setSelectedCategory(String category) {
    setState(() {
      selectedCategory = category;
    });

    loadEventsByCategory();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loadEvents();
    setSelectedCategory(widget.initCategory);
    loadEventsByCategory();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: CategoryMobilePage(
        eventsList: loadedEvents,
        userDoc: widget.userDoc,
        initCategory: selectedCategory,
        setSelectedCategory: setSelectedCategory,
      ),
    );
  }
}

// ----------------------- MOBILE -------------------------- //

class CategoryMobilePage extends StatefulWidget {
  final Function setSelectedCategory;
  final String initCategory;
  final Map userDoc;
  final List eventsList;
  const CategoryMobilePage({
    Key? key,
    required this.eventsList,
    required this.userDoc,
    required this.initCategory,
    required this.setSelectedCategory,
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
        color: Colors.white,
        child: Column(
          children: [
            AppBarWidget(
              profileUrl: widget.userDoc['profilePicture'],
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .05,
                ),
                const CategoryMessageWidget(),
                const Expanded(
                  child: SizedBox(),
                ),
                DropdownWidget(
                  selectedCategory: widget.initCategory,
                  setSelectedCategory: widget.setSelectedCategory,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .05,
                ),
              ],
            ),
            CategoryTableWidget(
              eventsList: widget.eventsList,
              userDoc: widget.userDoc,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
            ),
            const CreateButtonWidget(),
          ],
        ),
      ),
    );
  }
}
