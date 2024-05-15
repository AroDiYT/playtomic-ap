import 'package:flutter/material.dart';
import 'package:playtomic_app/src/pages/profile_activities.dart';

class ProfileContent extends StatefulWidget {
  const ProfileContent({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileContentState createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisSize: MainAxisSize.max,
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
          const SizedBox(
            //Add this to give height
            height: 1000, //TODO: Find better solution to make this scrollable
            child:
                TabBarView(physics: NeverScrollableScrollPhysics(), children: [
              ProfileActivities(),
              Text("Posts"),
            ]),
          ),

          // ConstrainedBox(
          //   constraints: const BoxConstraints(maxHeight: 1000, maxWidth: 1000),
          //   child: const SingleChildScrollView(
          //     child: TabBarView(
          //       children: [
          //         ProfileActivities(),
          //         Text("Posts"),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
