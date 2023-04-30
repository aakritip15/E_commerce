// // ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables
//
// import 'package:app_1/Screens/chatHome.dart';
// import 'package:app_1/Screens/sell_item.dart';
// import 'package:app_1/models/userModel.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import '../Screens/donation.dart';
// import 'firebaseHelper.dart';
//
// class NavBar extends StatelessWidget {
//   final User? currentUser = FirebaseAuth.instance.currentUser;
//   String? uid = FirebaseAuth.instance.currentUser!.uid;
//
//   NavBar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               color: Color.fromARGB(255, 197, 197, 197),
//               blurRadius: 3,
//               offset: Offset(
//                 0,
//                 5,
//               ),
//             )
//           ],
//           color: Color.fromRGBO(245, 248, 254, 1),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         height: 50,
//         width: MediaQuery.of(context).size.width * 0.5,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             IconButton(
//               icon: const Icon(Icons.format_list_bulleted_add),
//               onPressed: () {},
//             ),
//             IconButton(
//               icon: const Icon(Icons.add_box_outlined),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => SellItem(
//                             firebaseUser: currentUser,
//                           )),
//                 );
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.message_outlined),
//               onPressed: () async {
//                 UserModel? userModel =
//                     await FirebaseHelper.getUserModelById(currentUser!.uid);
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ChatHome(
//                               userModel: userModel,
//                               firebaseUser: currentUser,
//                             )));
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.clean_hands_rounded),
//               onPressed: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: ((context) => Donation(firebaseUser: currentUser,))));
//
//               },
//             ),
//           ],
//         ));
//   }
// }
import 'package:app_1/Screens/MyOrders.dart';
import 'package:app_1/Screens/chatHome.dart';
import 'package:app_1/Screens/donation.dart';
import 'package:app_1/Screens/homepage.dart';
import 'package:app_1/Screens/landing_page.dart';
import 'package:app_1/Screens/profile.dart';
import 'package:app_1/Screens/sell_item.dart';
import 'package:app_1/consts/colors.dart';
import 'package:app_1/models/firebaseHelper.dart';
import 'package:app_1/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  String? uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 10,
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(
                  Icons.home,
                  color: kBrown,
                ),
                onPressed: () async {
                  UserModel? user = await FirebaseHelper.getUserModelById(uid!);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyHomePage(user: user!)));
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.handshake_outlined,
                  color: kBrown,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Donation(firebaseUser: currentUser!)));
                },
              ),
              SizedBox(width: 32),
              IconButton(
                icon: Icon(
                  Icons.chat_outlined,
                  color: kBrown,
                ),
                onPressed: () async {
                  UserModel? user = await FirebaseHelper.getUserModelById(uid!);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatHome(
                                userModel: user,
                                firebaseUser: currentUser,
                              )));
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.shopping_cart_rounded,
                  color: kBrown,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Orders()));
                },
              ),
            ],
          ),
        ),
        floatingActionButton: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SellItem(firebaseUser: currentUser!)));
          },
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: kYellow,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Icon(Icons.add, color: Colors.white, size: 32),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
