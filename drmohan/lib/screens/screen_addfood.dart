import 'dart:developer';

import 'package:drmohan/models/model_dashboarditem.dart';
import 'package:drmohan/screens/food_search_bar.dart';
import 'package:drmohan/screens/list_item.dart';
import 'package:drmohan/screens/screen_addfoodtodiet.dart';
import 'package:drmohan/services/http_service.dart';
import 'package:drmohan/widgets/appbar.dart';
import 'package:drmohan/widgets/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';

import '../main.dart';

class AddFoodScreen extends StatefulWidget {
  final String diet;

  const AddFoodScreen({Key? key, required this.diet}) : super(key: key);

  @override
  _AddFoodScreenState createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  final HttpService httpService = HttpService();
  bool isSaerching = false;
  var scrollController = ScrollController();
  List<FoodItem> foodSearched = [];
  final food = [
    FoodItem(heading: "Idli"),
    FoodItem(heading: "Homemade Idli"),
    FoodItem(
      heading: "Chowmein",
    ),
    FoodItem(
      heading: "Fried Rice",
    ),
    FoodItem(
      heading: "Dosa",
    ),
  ];

  void startSearch(String text) {
    _getSearchedItems(text);
    setState(() {
      isSaerching = true;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      extendBody: true,
      appBar: AppBarWidget(),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: FooterLayout(
          footer: isSaerching
              ? KeyboardAttachable(
                  backgroundColor: Colors.grey.shade200,
                  child: Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.grey.shade200,
                      child: Row(
                        children: const [
                          Expanded(
                            child: Text(
                              "Can't find your food?",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange),
                            ),
                          ),
                          ClipOval(
                            child: Material(
                              color: Colors.orange, // Button color
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                )
              : Container(
                  height: 0,
                ),
          child: FutureBuilder(
              future: httpService.getDashboardItems(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Dashboarditem>> snapshot) {
                log('data: $snapshot.hasData');
                if (snapshot.hasData) {
                  List<Dashboarditem>? dashboarditems = snapshot.data;
                  return Column(children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      margin: const EdgeInsets.only(top: 10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(width: 5.0, color: Colors.grey),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          print("tapped");
                          /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DashboardScreen(),
                              ));*/
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 0.2,
                              margin: const EdgeInsets.only(left: 3),
                              child: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: Text(
                                    ProfileScreen
                                        .selectedProfile.PatientName[0],
                                    style: TextStyle(
                                        fontFamily: 'Arial',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.055),
                                  )),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: 0.7,
                              color: Colors.blue,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.09,
                              width: MediaQuery.of(context).size.width * 0.6,
                              margin: const EdgeInsets.only(left: 10),
                              child: Column(children: [
                                Row(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.all(0),
                                        color: Colors.white,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            ProfileScreen
                                                .selectedProfile.PatientName,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.030,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.all(0),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.09,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            DrMohanApp.appinfoitems![0].srntxt4
                                                    .split(',')[0] +
                                                ":",
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.030,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )),
                                    Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            ProfileScreen.selectedProfile.MrNo,
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.030,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                                Row(children: [
                                  Container(
                                      margin: EdgeInsets.all(0),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          DrMohanApp.appinfoitems![0].srntxt4
                                                  .split(',')[1] +
                                              ": ",
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.030,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        ProfileScreen.selectedProfile.DOB
                                            .split(" ")[0],
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.030,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                              ]),
                            ),
                            /*Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                width: MediaQuery.of(context).size.width * 0.5,
                                margin: EdgeInsets.only(left: 10),
                                child: Html(
                                  data:
                                      //'${profiles![index].name + "<br>Dob: " + profiles![index].dob + "<br>MRN: " + profiles![index].mrn.toString()}',
                                      ProfileScreen
                                              .selectedProfile.PatientName +
                                          "<br>" +
                                          DrMohanApp.appinfoitems![0].srntxt4
                                              .split(',')[0] +
                                          ": " +
                                          ProfileScreen.selectedProfile.MrNo +
                                          "<br>" +
                                          DrMohanApp.appinfoitems![0].srntxt4
                                              .split(',')[1] +
                                          ": " +
                                          ProfileScreen.selectedProfile.DOB
                                              .split(" ")[0],
                                )),*/
                            Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                width: MediaQuery.of(context).size.width * 0.15,
                                margin: EdgeInsets.only(left: 2),
                                child: Image.network(
                                    DrMohanApp.appinfoitems![0].srntxt2 +
                                        "/images/" +
                                        ProfileScreen.selectedProfile.Gender
                                            .toLowerCase() +
                                        ".png"))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                          color: Colors.white),
                      child: Column(),
                    ),
                    FoodSearchBar(
                      onChanged: (String text) {
                        startSearch(text);
                      },
                    ),
                    isSaerching
                        ?  Padding(
                            padding: EdgeInsets.all(12),
                            child: Row(
                              children: const [
                                Text(
                                  "Search Results",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        : Container(height: 0,),
                    isSaerching
                        ? Expanded(
                            child: ListView.builder(
                                itemCount: foodSearched.length,
                                itemExtent: 58,
                                // Provide a builder function. This is where the magic happens.
                                // Convert each item into a widget based on the type of item it is.
                                itemBuilder: (context, index) {
                                  final item = foodSearched[index];
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      InkWell(
                                        // Splash color
                                        onTap: () async {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AddFoodToDietScreen(
                                                      diet: widget.diet,
                                                      food: item.heading),
                                            ),
                                          ).then((value) =>
                                              Navigator.pop(context, value));
                                        },
                                        child: ListTile(
                                          title: item.buildTitle(context),
                                          trailing: item.buildTrailing(context),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          )
                        : Expanded(
                            child: ListView.builder(
                                itemCount: food.length,
                                itemExtent: 58,
                                // Provide a builder function. This is where the magic happens.
                                // Convert each item into a widget based on the type of item it is.
                                itemBuilder: (context, index) {
                                  final item = food[index];
                                  return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        InkWell(
                                            // Splash color
                                            onTap: () async {
                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddFoodToDietScreen(
                                                          diet: widget.diet,
                                                          food: item.heading),
                                                ),
                                              ).then((value) => Navigator.pop(
                                                  context, value));
                                            },
                                            child: ListTile(
                                              title: item.buildTitle(context),
                                              trailing:
                                                  item.buildTrailing(context),
                                            )),
                                      ]);
                                }),
                          ),
                  ]);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        tooltip: 'Dr. Mohan\'s',
        //child: Icon(Icons.add, color: Colors.blue),
        child: CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage(
              OTPVerification.appscreensdataitems![36].srntxt2 +
                  '/images/dmdscLOGOsmall.png'),
          backgroundColor: Colors.transparent,
        ),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }

//                   }
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   ),
// );

  List<FoodItem> _getSearchedItems(String text) {
    foodSearched.clear();
    food.forEach((element) {
      if (element.heading.toLowerCase().contains(text.toLowerCase())) {
        foodSearched.add(element);
      }
    });
    return foodSearched;
  }
}

class FoodItem implements ListItem {
  final String heading;

  FoodItem({required this.heading});

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
    );
  }

  @override
  Widget buildSubtitle(BuildContext context) {
    return Container();
  }

  @override
  Widget buildTrailing(BuildContext context) {
    return const SizedBox(
      width: 30,
      height: 30,
      child: Icon(
        Icons.add,
        size: 20,
        color: Colors.orange,
      ),
    );
  }
}

// void _openProductPage(Product product) {
//   Navigator.pushNamed(
//     context,
//     '/product/' + product.id.toString(),
//   );
// }
