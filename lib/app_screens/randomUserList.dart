import 'dart:convert';
import 'package:demoflutterloginlogout/model/randomAPIModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;

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

  @override
  void initState() {
    super.initState();
    _future = getRandomUser(context);
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
        floatingActionButton: FloatingActionButton(
          tooltip: "Reload",
          child: Icon(Icons.refresh, color: Colors.white, size: 25.0),
          onPressed: () {
            setState(() {
              _future = getRandomUser(context);
              getFutureBuilder(_future);
            });
          },
        ),
        body: Center(
          child: getFutureBuilder(_future),
        ));
  }

  /**
   * Name : getRandomUser
   * <br> Purpose : This method is for getting data from server.
   */
  Future<List<RandomAPIModel>> getRandomUser(BuildContext context) async {
    final jobListAPIURL = 'https://randomuser.me/api/?results=10';
    final response = await http.get(jobListAPIURL);
    if (response.statusCode == 200) {
      List userResponse = json.decode(response.body)['results'];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Loading Data Sucess.'),
      ));
      return userResponse
          .map((randomapimodel) => RandomAPIModel.fromJson(randomapimodel))
          .toList();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Loading Data Failed!!'),
      ));
      throw Exception('Failed to load data from API');
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
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Search Name Here...',
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
                return setUpTitle(
                    index,
                    searchResultList[index].name.first + " " +
                    searchResultList[index].name.last,
                    searchResultList[index].gender,
                    searchResultList[index].email,
                    searchResultList[index].phone,
                    searchResultList[index].location.city,
                    searchResultList[index].location.country,
                    searchResultList[index].picture.medium,
                    searchResultList[index].dob.age.toString());
              },
            )
          : ListView.builder(
              itemCount: randomUserList.length,
              itemBuilder: (context, index) {
                return setUpTitle(
                    index,
                    randomUserList[index].name.first + " " +
                    randomUserList[index].name.last,
                    randomUserList[index].gender,
                    randomUserList[index].email,
                    randomUserList[index].phone,
                    randomUserList[index].location.city,
                    randomUserList[index].location.country,
                    randomUserList[index].picture.medium,
                    randomUserList[index].dob.age.toString());
              },
            );
    }
  }

  /**
   * Name : setUpTitle
   * <br> Purpose : This method will sets up listtitle of listview.
   */
  Widget setUpTitle(int index, String name, String gender, String email,
      String phone, String city, String country, String thumbnail, String age) {
    return Card(
      elevation: 1.5,
      margin: EdgeInsets.only(top: 7.0, bottom: 7.0),
      child: ListTile(
          onTap: () {
            openRandomUserInformationDialog(index);
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
                        image: DecorationImage(image: NetworkImage(thumbnail))),
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
                    )
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
  openRandomUserInformationDialog(item) {
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
                            fit: BoxFit.contain,
                            image: NetworkImage(
                                randomUserList[item].picture.large))),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        '${randomUserList[item].name.first + " " + randomUserList[item].name.last}',
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
                          'E-Mail: ${randomUserList[item].email}',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 15.0),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Phone: ${randomUserList[item].phone}',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 15.0),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'City: ${randomUserList[item].location.city}',
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
      if (randomUser.name.first.toLowerCase().contains(text) ||
          randomUser.name.last.toLowerCase().contains(text))
        searchResultList.add(randomUser);
    });
    setState(() {
      debugPrint('SIZE:>>>>>>> ' + searchResultList.length.toString());
      if (searchResultList.length == 0) {
        noMatchFound = true;
      } else {
        noMatchFound = false;
      }
    });
  }
}
