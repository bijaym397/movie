import 'package:flutter/material.dart';
import 'package:movie/modul.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class MovieDetails extends StatefulWidget {
  Results results;

  MovieDetails(this.results);

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Back'),
          backgroundColor: Color(0xFFFFE57E),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w342${widget.results.poster_path}'),
                fit: BoxFit.fill),
              ),
            ),
            Container(
              height: 270,
              width: 300,
              color: Color(0x8A000000),
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 30, 4, 2),
                    child: Text(
                      '${widget.results.original_title}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
                    child: Text(
                      '${widget.results.original_title}',
                      style: TextStyle(color: Colors.white60),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
                    child: Row(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.directions_boat,
                              color: Colors.white60,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              '22%',
                              style: TextStyle(
                                  color: Colors.white60, fontSize: 17),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 80,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.timer,
                              color: Colors.white60,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              '22%',
                              style: TextStyle(color: Colors.white60),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
                    child: Text(
                      '${widget.results.overview}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),


      ),
    );
  }
}
