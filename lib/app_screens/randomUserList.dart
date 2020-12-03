import 'package:demoflutterloginlogout/model/jobModel.dart';
import 'package:demoflutterloginlogout/network/RestClient.dart';
import 'package:demoflutterloginlogout/utils/Const.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class JobsListView extends StatefulWidget {
  final String title;
  const JobsListView({Key key, this.title}) : super(key: key);
  @override
  _JobListViewState createState() => _JobListViewState();
}

class _JobListViewState extends State<JobsListView> {
  TextEditingController _textController = TextEditingController();
  List<Job> jobList=List<Job>();
  List<Job> searchResultList=List<Job>();
  Future _future;
  bool noMatchFound=false;
  @override
  void initState() {
    super.initState();
    final client=RestClient(Dio(BaseOptions(contentType: "application/json")));
    _future = client.getTasks();
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
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanDown: (_) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Center(
        child: getFutureBuilder(context),
      ),
    );
  }

  /**
   * Name : getFutureBuilder
   * <br> Purpose : This method contains loginc of Future builder.
   */
  FutureBuilder<List<Job>> getFutureBuilder(BuildContext context) {
    return FutureBuilder<List<Job>>(
      future:_future,
      builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.done){
          if (snapshot.hasData) {
            jobList = List.from(snapshot.data);
            return setUpJobListWithSearch(jobList);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
        }else{
          return CircularProgressIndicator.adaptive();
        }
      },
    );
  }
  /**
   * Name : getJobList
   * <br> Purpose : This method is for getting data from server.
   */
  Future<List<Job>> getJobList(BuildContext context) async {
    final jobListAPIURL = 'https://jsonplaceholder.typicode.com/users';
    final response = await http.get(jobListAPIURL);
    if (response.statusCode == 200) {
      List jobResponse = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Loading Data Sucess.'),
      ));
      return jobResponse.map((job) => new Job.fromJson(job)).toList();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Loading Data Failed!!'),
      ));
      throw Exception('Failed to load data from API');
    }
  }

  /**
   * Name : setUpJobListWithSearch
   * <br> Purpose : This method will sets up listview.
   */
  Widget setUpJobListWithSearch(List<Job> jobList) {
    return Container(
      margin: EdgeInsets.only(left: 10.0,right: 10.0),
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
          Expanded(
              child: showDataInToListView()
          )
        ],
      ),
    );
  }

  /**
   * Name : showDataInToListView
   * <br> Purpose : This method will showcase data inside the listview.
   */
  showDataInToListView() {
    if(noMatchFound){
      return Center(
        child:Text(
          'No Match Found',
          style: TextStyle(
              fontSize: 15.0
          ),
        ) ,
      );
    }else{
      return searchResultList.length != 0 || _textController.text.isNotEmpty
          ? new ListView.builder(
        itemCount: searchResultList.length,
        itemBuilder: (context,index){
          return setUpTitle(searchResultList[index].name,
              searchResultList[index].email,jobList[index].phone,
              searchResultList[index].address.city,
              searchResultList[index].website ,Icons.person);
        },
      ):new ListView.builder(
          itemCount: jobList.length,
          itemBuilder: (context,index){
            return setUpTitle(jobList[index].name,
                jobList[index].email,jobList[index].phone,jobList[index].address.city,
                jobList[index].website, Icons.person);
          }
      );
    }
  }

  /**
   * Name : setUpTitle
   * <br> Purpose : This method will sets up listtitle of listview.
   */
  ListTile setUpTitle(String name, String email,String phone,String city,
      String website, IconData icon) => ListTile(
    title: Text(name,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        )),
    subtitle: Text(email),
    leading: Icon(
      icon,
      color: Colors.blue[500],
    ),
    onTap: (){
      openUserInformationDialog(name,email,phone,website,city);
    },
  );

  /**
   * Name : openUserInformationDialog
   * <br> Purpose : This method is will open dialog on listview click for showing information of the user.
   */
  openUserInformationDialog(String name, String email,String phone,String website,String city) {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Employee Details',
                        style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 5.0,
                  ),Container(
                    margin: EdgeInsets.only(left: 10.0,right: 10.0,top: 15.0,bottom: 15.0),
                    child: Column(
                      children: [
                        Text(
                          'Name: ${name}',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 15.0
                          ),
                        ),SizedBox(
                          height: 5.0,
                        ),Text(
                          'E-Mail: ${email}',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 15.0
                          ),
                        ),SizedBox(
                          height: 5.0,
                        ),Text(
                          'Website: ${website}',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 15.0
                          ),
                        ),SizedBox(
                          height: 5.0,
                        ),Text(
                          'Phone: ${phone}',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 15.0
                          ),
                        ),SizedBox(
                          height: 5.0,
                        ),Text(
                          'City: ${city}',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 15.0
                          ),
                        ),SizedBox(
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
      setState(() {

      });
      return;
    }

    jobList.forEach((job) {
      if (job.name.toLowerCase().contains(text))
        searchResultList.add(job);
    });
    setState(() {
      // debugPrint('SIZE:>>>>>>> '+searchResultList.length.toString());
      if(searchResultList.length==0){
        noMatchFound=true;
      }else{
        noMatchFound=false;
      }
    });
  }
}
