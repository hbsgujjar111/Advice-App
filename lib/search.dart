import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
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
  dynamic data, advice;

  Future getAdvice() {
    data = ApiData().searchAdvice(searchQuery.text);
    advice = data;
    return data;
  }

  //searchBar widget
  Widget searchBar() {
    return Container(
      width: MediaQuery.of(context).size.width * .86,
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
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardAppearance: Brightness.dark,
        keyboardType: TextInputType.name,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          decoration: TextDecoration.none,
        ),
        textInputAction: TextInputAction.next,
        cursorColor: Colors.white,
        cursorWidth: 2.0,
        cursorHeight: 26.0,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 22.0, horizontal: 20.0),
          errorStyle: TextStyle(
            fontSize: 15.0,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(16.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff36c7d0), width: 2.0),
            borderRadius: BorderRadius.circular(16.0),
          ),
          border: InputBorder.none,
          hintText: 'Search your advice...',
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
          suffixIcon: Container(
            height: 63.0,
            width: 60.0,
            decoration: BoxDecoration(
              color: Color(0xff36c7d0),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
            ),
            child: IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    data = null;
                  });
                  getAdvice();
                }
              },
              icon: Icon(Icons.search),
              color: Colors.white,
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
      height: MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.height * .24
          : MediaQuery.of(context).size.height * .34,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(24.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: AutoSizeText(
                    "$text",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                    ),
                    maxLines: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 3
                        : 2,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .28,
                      height: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? MediaQuery.of(context).size.height * .06
                          : MediaQuery.of(context).size.height * .12,
                      child: OutlinedButton(
                        onPressed: () {
                          Share.share("$text");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                  fontSize: 24.0,
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
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff262833),
      appBar: AppBar(
        title: AutoSizeText(
          "Search Advice",
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Color(0xff36c7d0),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 10.0,
                  bottom: 20.0,
                ),
                child: searchBar(),
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
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        )
                                      : Text(
                                          "Total Found Advices : " +
                                              (snapshot.data
                                                  as Map)['total_results'],
                                          style: TextStyle(
                                            color: Colors.white,
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
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22.0,
                                        ),
                                      ),
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .76,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .86,
                                        child: ListView.builder(
                                          itemCount: int.parse(
                                            (snapshot.data
                                                as Map)['total_results'],
                                          ),
                                          itemBuilder: (context, i) {
                                            return adviceBox(
                                              (snapshot.data as Map)['slips'][i]
                                                  ['advice'],
                                            );
                                          },
                                        ),
                                      ),
                                    ],
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
