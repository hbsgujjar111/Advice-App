import 'package:advice/api.dart';
import 'package:advice/search.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic data, advice;
  bool loading = false;

  Future getAdvice() {
    print("j" + loading.toString());
    setState(() {
      data = ApiData().fetchAdvice();
      loading = false;
      print("k" + loading.toString());
    });
    return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAdvice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                            style: GoogleFonts.architectsDaughter(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
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
                            color: Colors.grey.shade300,
                          ),
                          padding: EdgeInsets.all(24.0),
                          child: Center(
                            child: loading == true
                                ? CircularProgressIndicator()
                                : AutoSizeText(
                                    '"$advice"',
                                    style: GoogleFonts.giveYouGlory(
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    maxLines:
                                        MediaQuery.of(context).orientation ==
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
                                  loading = true;
                                  print("i" + loading.toString());
                                });
                                getAdvice();
                              },
                              child: AutoSizeText(
                                "New Advice",
                                style: GoogleFonts.architectsDaughter(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 26.0,
                                  ),
                                ),
                                maxLines: 1,
                              ),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                                backgroundColor: Colors.grey.shade300,
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
                                          color: Colors.black,
                                          size: 30.0,
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Flexible(
                                          child: AutoSizeText(
                                            "Share",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 26.0,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                      backgroundColor: Colors.grey.shade300,
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
                                          color: Colors.black,
                                          size: 30.0,
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Flexible(
                                          child: AutoSizeText(
                                            "Search",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 26.0,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                      backgroundColor: Colors.grey.shade300,
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
