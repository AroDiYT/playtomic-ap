import 'package:flutter/material.dart';
import 'package:playtomic_app/src/pages/profile_activities.dart';
import 'package:playtomic_app/src/user.dart';

class ProfileContent extends StatefulWidget {
  AppUser user;

  ProfileContent({super.key, required this.user});

  @override
  _ProfileContentState createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.indigo.shade900,
              indicatorColor: Colors.indigo.shade900,
              splashFactory: NoSplash.splashFactory,
              tabs: const [
                Tab(text: "Activiteiten"),
                Tab(text: "Posts"),
              ]),
          SizedBox(
            //Add this to give height
            height: 1000, //TODO: Find better solution to make this scrollable
            child:
                TabBarView(physics: NeverScrollableScrollPhysics(), children: [
              ProfileActivities(user: widget.user),
              Text("Posts"),
            ]),
          ),
        ],
      ),
    );
  }
}
