import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shiftzeal/common/progress_bar.dart';

import '../../common/common_methods.dart';
import '../../common/navigation_methos.dart';
import '../../constants/icons_constant.dart';
import 'directory_controller.dart';

class DirectoryScreen extends StatefulWidget {
  const DirectoryScreen({super.key});

  @override
  State<DirectoryScreen> createState() => _DirectoryScreenState();
}

class _DirectoryScreenState extends State<DirectoryScreen> {
  @override
  void initState() {
    super.initState();

    // Get the controller
    var directoryController =
        Provider.of<DirectoryController>(context, listen: false);

    // Call fetchEmployeeDirectory
    WidgetsBinding.instance.addPostFrameCallback((_) {
      directoryController.fetchEmployeeDirectory(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DirectoryController>(
      builder: (context, controller, child) {
        return ProgressBar(
          inAsyncCall: controller.inAsyncCall,
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                /*title: Text(
                  StringConstants.setting,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(fontSize: 20.px),
                ),
                centerTitle: true,
                actions: [
                  Text(
                    StringConstants.edit,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: 14.px,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  SizedBox(width: 24.px)
                ],*/
                // leading: GestureDetector(
                //   onTap: () {
                //     NavigationMethods.popMethod(context: context);
                //   },
                //   child: CommonMethods.appIcons(
                //     assetName: IconConstants.icBack,
                //     height: 34.px,
                //     width: 34.px,
                //   ),
                // ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(20.px),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.px),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(25.px)),
                      child: TabBar(
                        splashBorderRadius: BorderRadius.circular(0),
                        indicatorColor: Theme.of(context).primaryColor,
                        automaticIndicatorColorAdjustment: true,
                        indicatorSize: TabBarIndicatorSize.tab,
                        // onTap: (value) =>
                        //     controller.clickOnTap(value: value, context: context),
                        labelStyle: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontSize: 12.px,
                                fontWeight: FontWeight.w700),
                        unselectedLabelStyle: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontSize: 12.px, fontWeight: FontWeight.w700),
                        dividerColor: Theme.of(context).colorScheme.surface,
                        padding: EdgeInsets.zero,
                        labelPadding: EdgeInsets.zero,
                        tabs: const [
                          Tab(text: 'Directory'),
                          Tab(text: 'ORG Chart'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              body: SafeArea(
                child: const TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    DirectoryViewScreen(),
                    OrgChartScreen(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class DirectoryViewScreen extends StatefulWidget {
  const DirectoryViewScreen({super.key});

  @override
  State<DirectoryViewScreen> createState() => _DirectoryViewScreenState();
}

class _DirectoryViewScreenState extends State<DirectoryViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DirectoryController>(builder: (context, controller, child) {
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.px),
          child: Column(
            children: [
              SizedBox(height: 20.px),
              // Search Bar
              TextField(
                onChanged: (value) {
                  controller.filterUsers(value);
                },
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(
                      color: Color(0XFF6F7B80),
                      fontSize: 16.px,
                      fontWeight: FontWeight.w400),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0XFF6F7B80),
                  ),
                  filled: true,
                  fillColor: Color(0xFFF5F6FA),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              SizedBox(height: 20),
              // Grid View of Cards
              Expanded(
                child: GridView.builder(
                  itemCount: controller.filteredUsers.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final user = controller.filteredUsers[index];
                    return buildUserCard(user);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

Widget buildUserCard(Map<String, String> user) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          blurRadius: 10,
          color: Colors.black12,
          offset: Offset(2, 2),
        ),
      ],
    ),
    padding: EdgeInsets.all(12),
    child: Stack(
      //crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(user['image']!),
            ),
            SizedBox(height: 10),
            // Name
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user['name']!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  user['role']!,
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
            SizedBox(height: 8),
            // Arrow Icon
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: CommonMethods.appIcons(
            //       height: 24.px,
            //       width: 24.px,
            //       assetName: IconConstants.icBackForDashboard),
            // )
          ],
        ),
        Spacer(),
        Align(
          alignment: FractionalOffset.bottomRight,
          child: CommonMethods.appIcons(
              height: 24.px,
              width: 24.px,
              assetName: IconConstants.icBackForDashboard),
        )
      ],
    ),
  );
}

class OrgChartScreen extends StatefulWidget {
  const OrgChartScreen({super.key});

  @override
  State<OrgChartScreen> createState() => _OrgChartScreenState();
}

class _OrgChartScreenState extends State<OrgChartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      OrgCard(
                        imageUrl:
                            'https://randomuser.me/api/portraits/women/11.jpg',
                        name: 'Reman Mark',
                        title: 'Sr. Director. Communic',
                        location: 'Sales - Dubai',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(),
                          const VerticalLine(),
                        ],
                      ),
                      HorizonLine(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OrgCard(
                            imageUrl:
                                'https://randomuser.me/api/portraits/women/20.jpg',
                            name: 'Reman Mark',
                            title: 'Sr. Director. Communic',
                            location: 'Sales - Dubai',
                          ),
                          const SizedBox(width: 20),
                          OrgCard(
                            imageUrl:
                                'https://randomuser.me/api/portraits/women/50.jpg',
                            name: 'Reman Mark',
                            title: 'Sr. Director. Communic',
                            location: 'Sales - Dubai',
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const VerticalLine(),
                          SizedBox(),
                          const VerticalLine(),
                        ],
                      ),
                      HorizonLine(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OrgCard(
                            imageUrl:
                                'https://randomuser.me/api/portraits/men/33.jpg',
                            name: 'Reman Mark',
                            title: 'Sr. Director. Communic',
                            location: 'Sales - Dubai',
                          ),
                          const SizedBox(width: 20),
                          OrgCard(
                            imageUrl:
                                'https://randomuser.me/api/portraits/men/45.jpg',
                            name: 'Reman Mark',
                            title: 'Sr. Director. Communic',
                            location: 'Sales - Dubai',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrgCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String title;
  final String location;

  const OrgCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.title,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      //  margin: const EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20.px),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(height: 8),
          Text(name,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 2),
          Text(location,
              style: const TextStyle(color: Colors.black54, fontSize: 14)),
        ],
      ),
    );
  }
}

class VerticalLine extends StatelessWidget {
  const VerticalLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2,
      height: 30,
      color: Colors.black,
    );
  }
}

class HorizonLine extends StatelessWidget {
  const HorizonLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 2,
      color: Colors.black,
    );
  }
}
