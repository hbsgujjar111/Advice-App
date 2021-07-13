import 'package:advice/api.dart';
import 'package:advice/search.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic data, advice;

  Future getAdvice() {
    data = ApiData().fetchAdvice();
    advice = data;
    return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ApiData().searchAdvice("parents");
    getAdvice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff262833),
      appBar: AppBar(
        title: AutoSizeText(
          "Advice App",
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Color(0xff36c7d0),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: data,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                advice = snapshot.data.toString();
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20.0,
                            bottom: 20.0,
                          ),
                          child: AutoSizeText(
                            "Your Advice",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .86,
                          height: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? MediaQuery.of(context).size.height * .24
                              : MediaQuery.of(context).size.height * .3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(24.0),
                          child: Center(
                            child: AutoSizeText(
                              advice,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.0,
                              ),
                              maxLines: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? 4
                                  : 3,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 30.0,
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width * .86,
                            height: MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? MediaQuery.of(context).size.height * .07
                                : MediaQuery.of(context).size.height * .12,
                            child: OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  getAdvice();
                                });
                              },
                              child: AutoSizeText(
                                "New Advice",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26.0,
                                ),
                                maxLines: 1,
                              ),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: Color(0xff36c7d0),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                                backgroundColor: Color(0xff36c7d0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * .07,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: 30.0,
                                ),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * .34,
                                  height: MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? MediaQuery.of(context).size.height * .07
                                      : MediaQuery.of(context).size.height *
                                          .12,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Share.share(advice);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.share_rounded,
                                          color: Colors.white,
                                          size: 30.0,
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Flexible(
                                          child: AutoSizeText(
                                            "Share",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 26.0,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                        color: Color(0xff36c7d0),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                      backgroundColor: Color(0xff36c7d0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: 30.0,
                                ),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * .34,
                                  height: MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? MediaQuery.of(context).size.height * .07
                                      : MediaQuery.of(context).size.height *
                                          .12,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SearchAdvice(),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.search_rounded,
                                          color: Colors.white,
                                          size: 30.0,
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Flexible(
                                          child: AutoSizeText(
                                            "Search",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 26.0,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                        color: Color(0xff36c7d0),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                      backgroundColor: Color(0xff36c7d0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
