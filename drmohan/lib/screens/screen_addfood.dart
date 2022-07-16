import 'package:drmohan/models/model_fooddetailitem.dart';
import 'package:drmohan/screens/food_search_bar.dart';
import 'package:drmohan/screens/list_item.dart';
import 'package:drmohan/screens/screen_addfoodtodiet.dart';
import 'package:drmohan/services/http_service.dart';
import 'package:drmohan/widgets/appbar.dart';
import 'package:drmohan/widgets/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  bool _isSearching = false;
  bool _isLoading = true;
  bool isSubmitting = false;
  List<FoodItem> foodSearched = [];
  List<FoodDetailItem> foodDetailList = [];
  late FToast fToast;
  var searchedText = "";

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    super.initState();
    fetchData(" ");
  }

  Future<void> fetchData(String food) async {
    await httpService.getFoodDetails(food).then((value) {
      foodDetailList.addAll(value);
      foodSearched.clear();
      foodDetailList.forEach((element) {
        if (element.Food_Desc.toLowerCase().contains(food.toLowerCase())) {
          FoodItem foodItem = FoodItem(foodDetailItem: element);
          foodSearched.add(foodItem);
        }
      });
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _emailFood(String food) async {
    await httpService.emailFoodName(food).then((value) {
      if (value == 200) {
        fToast.showToast(
          child: showSuccessToast("Food Name Emailed"),
          gravity: ToastGravity.BOTTOM,
          toastDuration: const Duration(seconds: 2),
        );
      } else {
        fToast.showToast(
          child: showErrorToast("Something Went Wrong!!"),
          gravity: ToastGravity.BOTTOM,
          toastDuration: const Duration(seconds: 2),
        );
      }
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AddFoodScreen(diet: widget.diet),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      extendBody: true,
      appBar: AppBarWidget(),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: FooterLayout(
            footer: _isSearching && searchedText.length > 3
                ? KeyboardAttachable(
              backgroundColor: Colors.grey.shade200,
              child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.grey.shade200,
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Can't find your food?",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _emailFood(searchedText);
                        },
                        child: const ClipOval(
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
                      ),
                    ],
                  )),
            )
                : Container(
              height: 0,
            ),
            child: !_isLoading
                ? Stack(children: [
              isSubmitting
                  ? AbsorbPointer(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                    ),
                    child: const Center(child: CircularProgressIndicator()),
                  ))
                  : Container(),
              Column(children: [
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
                                ProfileScreen.selectedProfile.PatientName[0],
                                style: TextStyle(fontFamily: 'Arial', fontStyle: FontStyle.normal, fontWeight: FontWeight.bold, color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.055),
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
                                    margin: const EdgeInsets.all(0),
                                    color: Colors.white,
                                    height: MediaQuery.of(context).size.height * 0.03,
                                    width: MediaQuery.of(context).size.width * 0.45,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        ProfileScreen.selectedProfile.PatientName,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.width * 0.030,
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
                                    height: MediaQuery.of(context).size.height * 0.03,
                                    width: MediaQuery.of(context).size.width * 0.09,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        DrMohanApp.appinfoitems![0].srntxt4.split(',')[0] + ":",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.width * 0.030,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )),
                                Container(
                                    height: MediaQuery.of(context).size.height * 0.03,
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        ProfileScreen.selectedProfile.MrNo,
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.width * 0.030,
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
                                  height: MediaQuery.of(context).size.height * 0.03,
                                  width: MediaQuery.of(context).size.width * 0.1,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      DrMohanApp.appinfoitems![0].srntxt4.split(',')[1] + ": ",
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width * 0.030,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )),
                              Container(
                                height: MediaQuery.of(context).size.height * 0.03,
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    ProfileScreen.selectedProfile.DOB.split(" ")[0],
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.030,
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
                        Container(height: MediaQuery.of(context).size.height * 0.15, width: MediaQuery.of(context).size.width * 0.15, margin: EdgeInsets.only(left: 2), child: Image.network(DrMohanApp.appinfoitems![0].srntxt2 + "/images/" + ProfileScreen.selectedProfile.Gender.toLowerCase() + ".png"))
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
                    _getSearchedItems(text);
                  },
                ),
                _isSearching
                    ? Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: const [
                      Text(
                        "Search Results",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
                    : Container(
                  height: 0,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: foodSearched.length,
                      itemExtent: 58,
                      // Provide a builder function. This is where the magic happens.
                      // Convert each item into a widget based on the type of item it is.
                      itemBuilder: (context, index) {
                        final item = foodSearched[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            InkWell(
                              // Splash color
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddFoodToDietScreen(diet: widget.diet, food: item.foodDetailItem),
                                  ),
                                ).then((value) => Navigator.pop(context, value));
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
              ])
            ])
                : const Center(child: CircularProgressIndicator())),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        tooltip: 'Dr. Mohan\'s',
        //child: Icon(Icons.add, color: Colors.blue),
        child: CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage(OTPVerification.appscreensdataitems![36].srntxt2 + '/images/dmdscLOGOsmall.png'),
          backgroundColor: Colors.transparent,
        ),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }

  Future<void> _getSearchedItems(String text) async {
    foodSearched.clear();
    if (text.length > 3) {
      setState(() {
        if (!_isSearching) _isSearching = true;
        searchedText = text;
      });
      await fetchData(text).then((value) {
        setState(() {
          if (foodSearched.isNotEmpty) _isSearching = false;
        });
      });
    }
  }
}

class FoodItem implements ListItem {
  final FoodDetailItem foodDetailItem;

  FoodItem({required this.foodDetailItem});

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      foodDetailItem.Food_Desc,
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
