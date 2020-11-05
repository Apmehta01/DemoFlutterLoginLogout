import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Job {
  final int id;
  final String position;
  final String company;
  final String description;

  Job({this.id, this.position, this.company, this.description});

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      position: json['position'],
      company: json['company'],
      description: json['description'],
    );
  }
}

class JobsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Job>>(
      future: getJobList(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Job> jobList = snapshot.data;
          return setUpListview(jobList);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  // getting data from server
  Future<List<Job>> getJobList(BuildContext context) async {
    final jobListAPIURL = 'https://mock-json-service.glitch.me/';
    final response = await http.get(jobListAPIURL);

    if (response.statusCode == 200) {
      List jobResponse = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Loading Job Data Sucess.'
        ),
      ));
      return jobResponse.map((job) => new Job.fromJson(job)).toList();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Loading Job Data Failed!!'
        ),
      ));
      throw Exception('Failed to load jobs from API');
    }
  }

  ListView setUpListview(List<Job> jobList) {
    return ListView.builder(
        itemCount: jobList.length,
        itemBuilder: (context, index) {
          return setUpTitle(jobList[index].position, jobList[index].company, Icons.work);
        });
  }

  ListTile setUpTitle(String title, String subtitle, IconData icon) =>
      ListTile(
        title: Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(subtitle),
        leading: Icon(
          icon,
          color: Colors.blue[500],
        ),
      );
}