import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';

import 'api.dart';

final searchQuery = TextEditingController();
final _formKey = GlobalKey<FormState>();

class SearchAdvice extends StatefulWidget {
  const SearchAdvice({Key? key}) : super(key: key);

  @override
  _SearchAdviceState createState() => _SearchAdviceState();
}

class _SearchAdviceState extends State<SearchAdvice> {
  dynamic data;
  bool loading = false;

  Future getAdvice() {
    data = ApiData().searchAdvice(searchQuery.text);
    setState(() {
      loading = false;
    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: AutoSizeText(
          "Search Advice",
          style: GoogleFonts.architectsDaughter(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width * .07,
            ),
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.grey.shade300,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * .02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: searchBar(),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  FutureBuilder(
                    future: data,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width * .07,
                                    bottom: 10.0,
                                  ),
                                  child: (snapshot.data as Map).length == 1
                                      ? Text(
                                          "Total Found Advices : 0",
                                          style: GoogleFonts.architectsDaughter(
                                            textStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .04,
                                            ),
                                          ),
                                        )
                                      : Text(
                                          "Total Found Advices : " +
                                              (snapshot.data
                                                  as Map)['total_results'],
                                          style: GoogleFonts.architectsDaughter(
                                            textStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .04,
                                            ),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                            (snapshot.data as Map).length == 1
                                ? Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width * .07,
                                      ),
                                      child: Text(
                                        "No advice found matching that search term.",
                                        style: GoogleFonts.architectsDaughter(
                                          textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .06,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      loading == false
                                          ? Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .74,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .86,
                                              child: ListView.builder(
                                                itemCount: int.parse(
                                                  (snapshot.data
                                                      as Map)['total_results'],
                                                ),
                                                itemBuilder: (context, i) {
                                                  return adviceBox(
                                                    (snapshot.data
                                                            as Map)['slips'][i]
                                                        ['advice'],
                                                  );
                                                },
                                              ),
                                            )
                                          : CircularProgressIndicator(),
                                    ],
                                  ),
                          ],
                        );
                      }
                      return ColoredBox(color: Colors.black);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //searchBar widget
  Widget searchBar() {
    return Container(
      width: MediaQuery.of(context).size.width * .86,
      height: MediaQuery.of(context).size.height * .06,
      child: TextFormField(
        initialValue: null,
        autocorrect: true,
        controller: searchQuery,
        validator: (query) {
          if (query!.isEmpty) {
            return 'Search Some Advice!';
          } else {
            return null;
          }
        },
        keyboardAppearance: Brightness.dark,
        keyboardType: TextInputType.name,
        style: GoogleFonts.architectsDaughter(
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: MediaQuery.of(context).size.width * .05,
            decoration: TextDecoration.none,
            letterSpacing: 2.0,
          ),
        ),
        textInputAction: TextInputAction.next,
        cursorColor: Colors.black,
        cursorWidth: 2.0,
        cursorHeight: 26.0,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .04,
          ),
          errorStyle: TextStyle(
            fontSize: 15.0,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300, width: 2.0),
            borderRadius: BorderRadius.circular(
              MediaQuery.of(context).size.width * .02,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300, width: 2.0),
            borderRadius: BorderRadius.circular(
              MediaQuery.of(context).size.width * .02,
            ),
          ),
          border: InputBorder.none,
          hintText: 'Search your advice...',
          hintStyle: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
          ),
          suffixIcon: Container(
            width: MediaQuery.of(context).size.width * .1,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(
                  MediaQuery.of(context).size.width * .02,
                ),
                bottomRight: Radius.circular(
                  MediaQuery.of(context).size.width * .02,
                ),
              ),
            ),
            child: IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    data = null;
                    loading = true;
                  });
                  getAdvice();
                }
              },
              icon: Icon(Icons.search),
              color: Colors.black,
              iconSize: 30.0,
            ),
          ),
        ),
      ),
    );
  }

//advice box widget
  Widget adviceBox(String text) {
    return Container(
      width: MediaQuery.of(context).size.width * .86,
      height: MediaQuery.of(context).size.height * .24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        color: Colors.grey.shade300,
      ),
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: AutoSizeText(
                    '" $text "',
                    style: GoogleFonts.giveYouGlory(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * .06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Share.share(text);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * .32,
                    height: MediaQuery.of(context).size.height * .05,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * .03,
                      ),
                    ),
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyText2,
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.share_rounded,
                                color: Colors.black,
                                size: MediaQuery.of(context).size.width * .06,
                              ),
                            ),
                            TextSpan(
                              text: " Share",
                              style: GoogleFonts.architectsDaughter(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.width * .06,
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}
