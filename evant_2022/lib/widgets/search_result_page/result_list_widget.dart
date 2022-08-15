import 'package:flutter/material.dart';

import '../../widgets/responsive_layout_widget.dart';

import '../../pages/event_detail_page.dart';

class ResultListWidget extends StatefulWidget {
  final Map userData;
  final List eventList;
  final List userList;
  const ResultListWidget({
    Key? key,
    required this.eventList,
    required this.userList,
    required this.userData,
  }) : super(key: key);

  @override
  State<ResultListWidget> createState() => _ResultListWidgetState();
}

class _ResultListWidgetState extends State<ResultListWidget> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: ResultListMobileWidget(
        eventList: widget.eventList,
        userList: widget.userList,
        userData: widget.userData,
      ),
    );
  }
}

// ------------------------- MOBILE ------------------------- //

class ResultListMobileWidget extends StatefulWidget {
  final Map userData;
  final List eventList;
  final List userList;
  const ResultListMobileWidget({
    Key? key,
    required this.eventList,
    required this.userList,
    required this.userData,
  }) : super(key: key);

  @override
  State<ResultListMobileWidget> createState() => _ResultListMobileWidgetState();
}

class _ResultListMobileWidgetState extends State<ResultListMobileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .7,
      width: MediaQuery.of(context).size.width * .9,
      color: Colors.grey,
      child: Column(
        children: [
          const Text('events'),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.eventList.length,
            itemBuilder: (BuildContext eventContext, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetailPage(
                        userDoc: widget.userData,
                        eventData: widget.eventList[index],
                      ),
                    ),
                  );
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.eventList[index]['eventImage'],
                    ),
                  ),
                  title: Text(widget.eventList[index]['title']),
                  trailing: Text(widget.eventList[index]['description']),
                ),
              );
            },
          ),
          const Text('users'),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.userList.length,
            itemBuilder: (BuildContext userContext, int index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    widget.userList[index]['profilePicture'],
                  ),
                ),
                title: Text(widget.userList[index]['screenName']),
              );
            },
          ),
        ],
      ),
    );
  }
}
