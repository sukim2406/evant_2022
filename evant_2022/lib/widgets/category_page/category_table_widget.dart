import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../responsive_layout_widget.dart';

import '../../controllers/global_controller.dart' as global;
import '../../controllers/user_controller.dart';

import '../../pages/event_detail_page.dart';

class CategoryTableWidget extends StatefulWidget {
  final Map userDoc;
  final List eventsList;
  const CategoryTableWidget({
    Key? key,
    required this.eventsList,
    required this.userDoc,
  }) : super(key: key);

  @override
  State<CategoryTableWidget> createState() => _CategoryTableWidgetState();
}

class _CategoryTableWidgetState extends State<CategoryTableWidget> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: CategoryTableMobileWidget(
        eventsList: widget.eventsList,
        userDoc: widget.userDoc,
      ),
    );
  }
}

// -------------------------- MOBILE ------------------------- //

class CategoryTableMobileWidget extends StatefulWidget {
  final Map userDoc;
  final List eventsList;
  const CategoryTableMobileWidget({
    Key? key,
    required this.eventsList,
    required this.userDoc,
  }) : super(key: key);

  @override
  State<CategoryTableMobileWidget> createState() =>
      _CategoryTableMobileWidgetState();
}

class _CategoryTableMobileWidgetState extends State<CategoryTableMobileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .55,
      width: MediaQuery.of(context).size.width * .9,
      color: Colors.grey,
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .3,
                height: MediaQuery.of(context).size.height * .05,
                alignment: Alignment.center,
                child: const Text(
                  'title',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .1,
                height: MediaQuery.of(context).size.height * .05,
                alignment: Alignment.center,
                child: const Text(
                  'category',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .2,
                height: MediaQuery.of(context).size.height * .05,
                alignment: Alignment.center,
                child: const Text(
                  'attendance',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .1,
                height: MediaQuery.of(context).size.height * .05,
                alignment: Alignment.center,
                child: const Text(
                  'host',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .1,
                height: MediaQuery.of(context).size.height * .05,
                alignment: Alignment.center,
                child: const Text(
                  'detail',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .1,
                height: MediaQuery.of(context).size.height * .05,
                alignment: Alignment.center,
                child: const Text(
                  'join',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * .5,
            width: MediaQuery.of(context).size.width * .9,
            child: ListView.builder(
              itemCount: widget.eventsList.length,
              itemBuilder: (context, index) {
                return Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * .3,
                      height: MediaQuery.of(context).size.height * .05,
                      alignment: Alignment.center,
                      child: Text(
                        widget.eventsList[index]['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .1,
                      height: MediaQuery.of(context).size.height * .05,
                      alignment: Alignment.center,
                      child: Text(
                        widget.eventsList[index]['category'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .2,
                      height: MediaQuery.of(context).size.height * .05,
                      alignment: Alignment.center,
                      child: Text(
                        '${widget.eventsList[index]['rsvpList'].length} / ${widget.eventsList[index]['max']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .1,
                      height: MediaQuery.of(context).size.height * .05,
                      alignment: Alignment.center,
                      child: FutureBuilder(
                        future: UserController.instance
                            .getProfileUrl(widget.eventsList[index]['host']),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.hasError) {
                            return const CircleAvatar(
                              backgroundColor: global.secondaryColor,
                            );
                          }
                          if (!snapshot.hasData) {
                            return const CircleAvatar(
                              backgroundColor: global.secondaryColor,
                            );
                          }
                          return CircleAvatar(
                            backgroundColor: global.secondaryColor,
                            backgroundImage: NetworkImage(snapshot.data!),
                          );
                        },
                        // child: CircleAvatar(
                        //   backgroundColor: global.primaryColor,
                        //   child: Image.network(),
                        // ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .1,
                      height: MediaQuery.of(context).size.height * .05,
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  EventDetailPage(
                                eventData: widget.eventsList[index],
                                userDoc: widget.userDoc,
                              ),
                            ),
                            (route) => false,
                          );
                        },
                        child: const Text(
                          'detail',
                          style: TextStyle(
                            color: global.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // const Text(
                      //   'detail',
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .1,
                      height: MediaQuery.of(context).size.height * .05,
                      alignment: Alignment.center,
                      child: const Text(
                        'join',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
                // return ListTile(
                //   leading: Text(widget.eventsList[index]['title']),
                // );
              },
            ),
          ),
        ],
      ),
    );
  }
}
