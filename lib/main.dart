import 'dart:io';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movie/modul.dart';
import 'details_screen.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController searchController = TextEditingController();
  bool isTopRated = false;
  bool isSearch = false;
  List<Results> list = null;
  List<Results> searchList = null;
  @override
  void initState() {
    getData();
    searchController.addListener(onTextDataChange);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFE57E),
        title:
            Container(height: 100, width: double.infinity, child: getHader()),
      ),

/////////////////////////////////////////////////////////////////////////////////////
//      Movie List

      backgroundColor: Color(0XFFFFD54F),
      body: Container(
        width: double.infinity,
        child: searchList == null
            ? Container()
            : ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: searchList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Future<bool> returnValu = Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MovieDetails(searchList[index])));

                      returnValu.then((value) {
                        if (value != null) {
                          setState(() {
                            isTopRated = value;
                          });
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white54)),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 1, 8, 1),
                            child: Card(
                              elevation: 8,
                              child: Container(
                                height: 125,
                                width: 95,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w342${searchList[index].poster_path}'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 210,
                                child: Text(
                                  "${searchList[index].original_title}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Container(
                                width: 240,
                                child: Text(
                                  "${searchList[index].overview}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 5,
                                  style: TextStyle(fontSize: 13),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),

/////////////////////////////////////////////////////////////////////////////////////
//      Tab bar

      bottomNavigationBar: Container(
        color: Color(0xFFFFE57E),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ////////////////////////////////////
//            Now playing list tab
            Expanded(
              child: GestureDetector(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.movie,
                        size: 50,
                        color: isTopRated ? Colors.black12 : Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          'Now Playing',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: isTopRated ? Colors.black12 : Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  isTopRated = false;
                  getData();
                },
              ),
            ),

///////////////////////////////////////////////////
//          Top rated movie tab
            Expanded(
              child: GestureDetector(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        size: 50,
                        color: isTopRated ? Colors.black : Colors.black12,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          'Top Rated',
                          style: TextStyle(
                            color: isTopRated ? Colors.black : Colors.black12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  isTopRated = true;
                  getData();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  getData() async {
//    if(){
//
//    }else

    searchList = null;
    list = null;
    String response;
    if (isTopRated) {
      response =
          "https://api.themoviedb.org/3/movie/top_rated?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed";
    } else {
      response =
          "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed";
    }
    var res = await http
        .get(Uri.encodeFull(response), headers: {"Accept": "application/json"});
    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["results"] as List;
      print("===============$rest");
      list = rest.map<Results>((json) => Results.fromJson(json)).toList();
    }
    print("List Size: ${list.length}");

    setState(() {
      searchList = list;
      list;
    });
  }

  //TODO: Searchh Field
  getHader() {
    return isSearch
        ? Container(
            child: Row(
              children: <Widget>[
                Container(
                  height: 38,
                  width: 290,
                  child: Row(
//                    crossAxisAlignment: CrossAxisAlignment.,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 5),
                        child: Icon(
                          Icons.search,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: TextField(
                          controller: searchController,
                          maxLength: 22,
                          decoration: InputDecoration(
                            counterText: '',
                            hintText: 'Search',
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            searchController.text = "";
                            searchList = list;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 10, right: 5),
                          child: Icon(
                            Icons.close,
                            color: Colors.black54,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white54,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 6, right: 6),
                  child: GestureDetector(
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    onTap: () {
                      setState(() {
                        searchController.text = "";
                        searchList = list;
                        isSearch = false;
                      });
                    },
                  ),
                )
              ],
            ),
          )
        : GestureDetector(
            onTap: () {
              setState(() {
                isSearch = true;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 35,
                  width: 340,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.search,
                        color: Colors.black26,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Search',
                        style: TextStyle(color: Colors.black26),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
  }

  void onTextDataChange() {
    String text = searchController.text.toLowerCase();
    if (text != "") {
      searchList = null;
      searchList = List();
      list.forEach((rslt) {
        if (rslt.original_title.toLowerCase().contains(text) ||
            rslt.overview.toLowerCase().contains(text)) {
          searchList.add(rslt);
          setState(() {});
        }
      });
    }
  }
}

