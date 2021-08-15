// @dart=2.9
import 'dart:html';
import 'dart:convert';
import 'package:cubit/cubit.dart';
import 'package:deai_client/constants.dart';
import 'package:deai_client/state_management/contract_cubit.dart';
import 'package:deai_client/state_management/contract_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_web3_provider/ethereum.dart';
import 'package:flutter_web3_provider/ethers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:js_util';
import 'package:http/http.dart' as http;
import '../widgets/claim_token.dart';

class Home extends StatefulWidget {
  final ContractCubit cubit;

  const Home(this.cubit);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController yourNameController = TextEditingController();
  TextEditingController trainController = TextEditingController();
  List<bool> isSelected = [true, false];
  String selectedAddress;
  bool _walletConnected = false;
  String prediction = "";

  @override
  void initState() {
    super.initState();
    // CubitProvider.of<ContractCubit>(context).getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: secondaryColor,
          title: Text("Sentiment Analysis"),
          centerTitle: true,
        ),
        body: CubitConsumer<ContractCubit, ContractState>(
            cubit: widget.cubit,
            builder: (context, state) {
              if (state is PredictState) {
                prediction = state.result == 1 ? "Postive" : "Negative";
              }
              return buildBody();
            },
            listener: (context, state) {
              if (state is ErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.error),
                ));
              }
              if (state is TrainState) {
                var result = state.good_or_bad;
                String mes;
                if (result == 1) {
                  mes = "Good data submitted";
                } else
                  mes = "Bad data submitted";
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(mes),
                ));
              }
            }));
  }

  buildBody() => Container(
        color: bgColor,
        padding: EdgeInsets.symmetric(vertical: 100,horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                    "The IMDb Movie Reviews dataset is a binary sentiment analysis dataset consisting of"+
                    " 50,000 reviews from the Internet Movie Database (IMDb) labeled as positive or negative."+
                    "The dataset contains an even number of positive and negative reviews."+
                    " Only highly polarizing reviews are considered",
                    style: GoogleFonts.nixieOne(
    textStyle: TextStyle(color: Colors.white60, fontSize: 32)),
                    ),
                
               SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(left:200),
                  child: Row(
                    children: [
                      Container(
                    width: 800,
                    padding: EdgeInsets.only(top: 29),
                    child: TextFormField(
                      controller: yourNameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Predict",
                          hintText: "Enter the review",
                          icon: Icon(Icons.drive_file_rename_outline)),
                    ),
                  ),
                   SizedBox(width: 100),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: ElevatedButton(
                          child: Text(
                            'Get Prediction',
                            style: TextStyle(fontSize: 30),
                          ),
                          style:
                              ElevatedButton.styleFrom(primary: primaryColor),
                          onPressed: () {
                            widget.cubit.predict(yourNameController.text);
                          },
                        ),
                      ),
                      
                    ],
                  ),
                ),
               SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text(prediction,
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.blue,
                          )),
                    ),
                SizedBox(height: 50),
                Padding(

                  padding: const EdgeInsets.only(left:200),
                  child: Row(

                    children: [
                      Container(
                        width:800,
                        padding: EdgeInsets.only(top: 29),
                        child: TextFormField(
                          controller: trainController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Train",
                              hintText: "Enter the review",
                              icon: Icon(Icons.drive_file_rename_outline)),
                        ),
                      ),
                       SizedBox(width: 100),
                  Padding(
                    padding: EdgeInsets.only(top: 29),
                    child: ToggleButtons(
                      children: [
                        Icon(Icons.thumb_up_outlined),
                        Icon(Icons.thumb_down_outlined),
                      ],
                      isSelected: isSelected,
                      onPressed: (index) {
                        setState(() {
                          isSelected[index] = true;
                          isSelected[1 - index] = false;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 50),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: ElevatedButton(
                    child: Text(
                      'Train',
                      style: TextStyle(fontSize: 30),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                    ),
                    onPressed: () {
                      int classificaion = isSelected[0] ? 1 : 0;
                      widget.cubit.train(trainController.text, classificaion);
                    },
                  ),
                )
                    ],
                  ),
                ),
                
              ],
            ),
          ),
        ),
      );
}
