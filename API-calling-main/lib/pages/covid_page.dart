import 'package:flutter/material.dart';
import '../helper/helperclass.dart';
import '../model/modelclass.dart';

class Covid_Page extends StatefulWidget {
  const Covid_Page({Key? key}) : super(key: key);

  @override
  State<Covid_Page> createState() => _Covid_PageState();
}

class _Covid_PageState extends State<Covid_Page> {
  late Future<List<Detail?>?> fetchCovidCases;

  @override
  initState() {
    super.initState();
    fetchCovidCases = APIHelper.apiHelper.fetchCovid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text(
          'Covid case',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueAccent[100],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          FutureBuilder(
            future: fetchCovidCases,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error : ${snapshot.error}'),
                );
              } else if (snapshot.hasData) {
                List<Detail> data = snapshot.data as List<Detail>;
                return Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image:  AssetImage("images/img.png"),
                          )
                        ),
                      ),
                      Container(
                        width: double.infinity,
                       color: Colors.white.withOpacity(0.81),
                        ),
                      SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: data
                              .map(
                                (e) => Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(10),
                                          height: 50,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: (data.indexOf(e) %2 == 0)?Colors.orange:Colors.green,
                                            border: Border.all(color: Colors.black),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(e.state,style: const TextStyle(color: Colors.white,fontSize: 16),),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.all(10),
                                          height: 50,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: (data.indexOf(e) %2 == 1)?Colors.orange:Colors.green,
                                            border: Border.all(color: Colors.black),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(e.cases.toString(),style: const TextStyle(color: Colors.white,fontSize: 16),),

                                        ),
                                      ],
                                    ),
                                        const SizedBox(height: 50,),
                                    // Stack(
                                    //   alignment: Alignment.center,
                                    //   children: [
                                    //     SizedBox(
                                    //       height: 225,
                                    //       child: Image.asset(
                                    //         'assets/images/${e.state}.png',
                                    //         color: Colors.yellowAccent,
                                    //       ),
                                    //     ),
                                    //     Column(
                                    //       children: [
                                    //         Text(
                                    //           e.state,
                                    //           style: const TextStyle(
                                    //               color: Colors.deepPurple,
                                    //               fontWeight: FontWeight.w500,
                                    //               fontSize: 30),
                                    //         ),
                                    //         CircleAvatar(
                                    //           radius: 45,
                                    //           backgroundColor: Colors.deepPurple,
                                    //           child: Text(
                                    //             "${e.cases}",
                                    //             style: const TextStyle(
                                    //                 color: Colors.white,
                                    //                 fontWeight: FontWeight.w500,
                                    //                 fontSize: 30),
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ],
                                    // ),
                                    // const SizedBox(height: 70),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.blue,
                ));
              }
            },
          ),
        ],
      ),
    );
  }
}
