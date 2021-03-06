import 'package:advice/api.dart';
import 'package:advice/search.dart';
import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    data = ApiData().fetchAdvice();

    setState(() {});
    loading = false;

    return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = ApiData().fetchAdvice();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 1,
          child: Image.asset(
            "assets/bg.jpg",
            fit: BoxFit.fitHeight,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 1,
          color: Colors.black.withOpacity(.4),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              child: FutureBuilder(
                future: data,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * .04,
                                bottom:
                                    MediaQuery.of(context).size.height * .03,
                              ),
                              child: AutoSizeText(
                                "Your Advice",
                                style: GoogleFonts.architectsDaughter(
                                  textStyle: TextStyle(
                                    color: Colors.white,
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
                              height: MediaQuery.of(context).size.height * .24,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * .04,
                                ),
                                color: Colors.black.withOpacity(.4),
                              ),
                              padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * .06,
                              ),
                              child: Center(
                                child: AutoSizeText(
                                  '"' + snapshot.data.toString() + '"',
                                  style: GoogleFonts.giveYouGlory(
                                    textStyle: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 4,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * .08,
                            vertical: MediaQuery.of(context).size.height * .02,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              .04,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          loading = true;
                                        });
                                        getAdvice();
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .07,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(.4),
                                          borderRadius: BorderRadius.circular(
                                            MediaQuery.of(context).size.width *
                                                .03,
                                          ),
                                        ),
                                        child: Center(
                                          child: AutoSizeText(
                                            "New Advice",
                                            style:
                                                GoogleFonts.architectsDaughter(
                                              textStyle: TextStyle(
                                                color: Colors.white60,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            maxLines: 1,
                                          ),
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
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              .04,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Share.share(snapshot.data.toString());
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .07,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(.4),
                                          borderRadius: BorderRadius.circular(
                                            MediaQuery.of(context).size.width *
                                                .03,
                                          ),
                                        ),
                                        child: Center(
                                          child: RichText(
                                            text: TextSpan(
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons.share_rounded,
                                                    color: Colors.white60,
                                                    size: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        .06,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: " Share",
                                                  style: GoogleFonts
                                                      .architectsDaughter(
                                                    textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white60,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .06,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
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
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * .04,
            ),
            child: OpenContainer(
              closedShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(100.0),
                ),
              ),
              transitionType: ContainerTransitionType.fadeThrough,
              transitionDuration: Duration(milliseconds: 600),
              openColor: Colors.black.withOpacity(.4),
              closedColor: Colors.black.withOpacity(.4),
              closedElevation: 0.0,
              closedBuilder: (context, openWidget) {
                return FloatingActionButton(
                  onPressed: openWidget,
                  elevation: 0.0,
                  backgroundColor: Colors.black.withOpacity(.4),
                  child: Icon(
                    Icons.search_rounded,
                    color: Colors.white54,
                    size: MediaQuery.of(context).size.width * .09,
                  ),
                );
              },
              openBuilder: (context, closeWidget) {
                return SearchAdvice();
              },
            ),
          ),
        ),
      ],
    );
  }
}
