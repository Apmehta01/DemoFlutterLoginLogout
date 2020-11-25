import 'dart:convert';
import 'package:demoflutterloginlogout/model/randomAPIModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:progress_dialog/progress_dialog.dart';

class RandomUserList extends StatefulWidget {
  final String title;

  const RandomUserList({Key key, this.title}) : super(key: key);

  @override
  _RandomUserListState createState() => _RandomUserListState();
}

class _RandomUserListState extends State<RandomUserList> {
  TextEditingController _textController = TextEditingController();
  List<RandomAPIModel> randomUserList = List<RandomAPIModel>();
  List<RandomAPIModel> searchResultList = List<RandomAPIModel>();
  Future _future;
  bool noMatchFound = false;
  List userResponse = new List();
  ProgressDialog progressdialog;

  //Pagination
  static int page = 1;
  final dio = new Dio();

  @override
  void initState() {
    _future = getRandomUser(context, page);
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.zero,
        child: Container(
          height: 45.0,
          width: 45.0,
          child: FloatingActionButton(
            tooltip: "Reload",
            child: Icon(Icons.refresh, color: Colors.white, size: 25.0),
            onPressed: () {
              setState(() {
                page = 0;
                _future = getRandomUser(context, page);
                getFutureBuilder(_future);
              });
            },
          ),
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanDown: (_) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
          child: getFutureBuilder(_future),
        ),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  /**
   * Name : getRandomUser
   * <br> Purpose : This method is for getting data from server.
   */
  Future<List<RandomAPIModel>> getRandomUser(
      BuildContext context, int pageNumber) async {
    showProgressDialog();
    // final jobListAPIURL = 'https://randomuser.me/api/?results=10';
    final jobListAPIURL = "https://randomuser.me/api/?page=" +
        pageNumber.toString() +
        "&results=11&seed=abc";
    // final response = await http.get(jobListAPIURL);
    final response = await dio.get(jobListAPIURL);
    debugPrint('URL:>>>>>>> ' + jobListAPIURL);
    if (response.statusCode == 200) {
      for (int i = 0; i < response.data['results'].length; i++) {
        userResponse.add(response.data['results'][i]);
        debugPrint('DATA:>>>>>>> ' + response.data['results'][i].toString());
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 2),
        content: Text('Adding data Sucess.'),
      ));
      return userResponse
          .map((randomapimodel) => RandomAPIModel.fromJson(randomapimodel))
          .toList();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error while adding the data!!'),
      ));
      throw Exception('Failed to load data from API!!');
    }
  }

  /**
   * Name : getFutureBuilder
   * <br> Purpose : This method contains loginc of Future builder.
   */
  Widget getFutureBuilder(Future future) {
    return FutureBuilder<List<RandomAPIModel>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("SNAP SIZE:>>>>>>>" + snapshot.data.length.toString());
            randomUserList = List.from(snapshot.data);
            return setUpRandomUserListWithSearch(randomUserList);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator.adaptive();
        });
  }

  /**
   * Name : setUpRandomUserListWithSearch
   * <br> Purpose : This method will sets up listview.
   */
  Widget setUpRandomUserListWithSearch(List<RandomAPIModel> randomUserList) {
    debugPrint('SIZE:>>>>>>> ' + randomUserList.length.toString());
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Search name here...',
              ),
              onChanged: (value) {
                setState(() {
                  onSearchTextChanged(value);
                });
              }, // onChanged: onItemChanged,
            ),
          ),
          Expanded(child: displayDataIntoListView())
        ],
      ),
    );
  }

  /**
   * Name : displayDataIntoListView
   * <br> Purpose : This method will showcase data inside the listview.
   */
  displayDataIntoListView() {
    if (noMatchFound) {
      return Center(
        child: Text(
          'No Match Found!!!!!',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      );
    } else {
      return searchResultList.length != 0 || _textController.text.isNotEmpty
          ? ListView.builder(
              itemCount: searchResultList.length,
              itemBuilder: (context, index) {
                String name = /*index.toString()+". "+*/ searchResultList[index]
                        .name
                        .first +
                    " " +
                    searchResultList[index].name.last;
                return setUpTitle(
                    index,
                    name,
                    searchResultList[index].gender,
                    searchResultList[index].email,
                    searchResultList[index].phone,
                    searchResultList[index].location.city,
                    searchResultList[index].location.country,
                    searchResultList[index].picture.large,
                    searchResultList[index].dob.age.toString());
              })
          : ListView.builder(
              itemCount: randomUserList.length + 1,
              itemBuilder: (context, index) {
                if (index == randomUserList.length) {
                  return Center(
                      child: Container(
                    margin: EdgeInsets.only(bottom: 20.0, top: 10.0),
                    width: 170.0,
                    height: 40.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.lightBlueAccent)),
                      color: Colors.lightBlueAccent,
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Load More",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        setState(() {
                          page++;
                          _future = getRandomUser(context, page);
                        });
                      },
                    ),
                  ));
                } else {
                  String name = index.toString() +
                      ". " +
                      randomUserList[index].name.first +
                      " " +
                      randomUserList[index].name.last;
                  print("LIST COME:>>>>>>>");
                  return setUpTitle(
                      index,
                      name,
                      randomUserList[index].gender,
                      randomUserList[index].email,
                      randomUserList[index].phone,
                      randomUserList[index].location.city,
                      randomUserList[index].location.country,
                      randomUserList[index].picture.large,
                      randomUserList[index].dob.age.toString());
                }
              });
    }
  }

  /**
   * Name : setUpTitle
   * <br> Purpose : This method will sets up listtitle of listview.
   */
  Widget setUpTitle(int index, String name, String gender, String email,
      String phone, String city, String country, String picture, String age) {
    progressdialog.hide();
    return Card(
      elevation: 1.5,
      margin: EdgeInsets.only(top: 7.0, bottom: 7.0),
      child: ListTile(
          onTap: () {
            openRandomUserInformationDialog(picture, name, email, phone, city);
          },
          title: Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        image: DecorationImage(image: NetworkImage(picture))),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                        width: MediaQuery.of(context).size.width - 140,
                        child: Text(
                          name,
                          style: TextStyle(fontSize: 17),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          gender,
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          age,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }

  /**
   * Name : openRandomUserInformationDialog
   * <br> Purpose : This method is will open dialog on listview click for showing information of the user.
   */
  openRandomUserInformationDialog(
      String picture, String name, String email, String phone, String city) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 350.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.contain, image: NetworkImage(picture))),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        '${name}',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 5.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                    child: Column(
                      children: [
                        Text(
                          'E-Mail: ${email}',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 15.0),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Phone: ${phone}',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 15.0),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'City: ${city}',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 15.0),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  /**
   * Name : onSearchTextChanged
   * <br> Purpose : This method contains logic of search when user will input textin Textfield.
   */
  onSearchTextChanged(String text) async {
    searchResultList.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    randomUserList.forEach((randomUser) {
      if (randomUser.name.first.toLowerCase().trim().contains(text) ||
          randomUser.name.last.toLowerCase().trim().contains(text))
        searchResultList.add(randomUser);
    });
    setState(() {
      if (searchResultList.length == 0) {
        noMatchFound = true;
      } else {
        noMatchFound = false;
      }
    });
  }

  /**
   * Name : showProgressBar
   * <br> Purpose : This method is for showing progressDialog.
   */
  showProgressDialog() {
    progressdialog = new ProgressDialog(context);
    progressdialog.style(
      message: 'Adding data.....',
      progressWidget: Transform.scale(
        scale: 0.5,
        child: CircularProgressIndicator(),
      ),
      insetAnimCurve: Curves.easeInOut,
    );
    progressdialog.show();
  }
}
