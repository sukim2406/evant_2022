import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/global_controller.dart' as global;

import '../../widgets/responsive_layout_widget.dart';

class SearchFollowingWidget extends StatefulWidget {
  const SearchFollowingWidget({Key? key}) : super(key: key);

  @override
  State<SearchFollowingWidget> createState() => _SearchFollowingWidgetState();
}

class _SearchFollowingWidgetState extends State<SearchFollowingWidget> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayoutWidget(
      mobileVer: SearchFollowingMobileWidget(),
    );
  }
}

// -------------------------- MOBILE ---------------------- //

class SearchFollowingMobileWidget extends StatefulWidget {
  const SearchFollowingMobileWidget({Key? key}) : super(key: key);

  @override
  State<SearchFollowingMobileWidget> createState() =>
      _SearchFollowingMobileWidgetState();
}

class _SearchFollowingMobileWidgetState
    extends State<SearchFollowingMobileWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .05,
          width: MediaQuery.of(context).size.width * .9,
          child: FittedBox(
            alignment: Alignment.centerLeft,
            child: Text(
              'Following',
              style: GoogleFonts.yellowtail(
                color: global.secondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * .5,
          width: MediaQuery.of(context).size.width * .9,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            color: Color.fromRGBO(82, 82, 82, .5),
          ),
          child: ListView.separated(
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
