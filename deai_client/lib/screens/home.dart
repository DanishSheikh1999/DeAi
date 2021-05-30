// @dart=2.9
import 'dart:html';

import 'package:deai_client/state_management/contract_cubit.dart';
import 'package:deai_client/state_management/contract_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_web3_provider/ethereum.dart';
import 'package:flutter_web3_provider/ethers.dart';
import 'package:provider/provider.dart';
import 'dart:js_util';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
   TextEditingController yourNameController = TextEditingController();
   TextEditingController trainController = TextEditingController();
    List<bool> isSelected = [true,false];
    String selectedAddress;
    bool _walletConnected = false;
    String prediction = "";
    @override
    void initState() {
        super.initState();
      // CubitProvider.of<ContractCubit>(context).getTasks();
    }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Sentiment Analysis"),
        centerTitle: true,
        actions: [ElevatedButton(
    child: Text(_walletConnected?"Wallet Connected":"Connect Wallet"),
    onPressed: () async {
      if(!_walletConnected){
        var accounts = await promiseToFuture(
            ethereum.request(RequestParams(method: 'eth_requestAccounts')));
        print(accounts);
        String se = ethereum.selectedAddress;
        print("selectedAddress: $se");
        setState(() {
            selectedAddress = se;
            _walletConnected = true;
        });
        var web3 = Web3Provider(ethereum);
        CubitProvider.of<ContractCubit>(context).startContract(web3);
      
        // NewContractLinking contractLinking = NewContractLinking(web3);
        // await contractLinking.initialSetup();
      //  print(await contractLinking.getCount());
        }
    },
)
],
      ),
      
      body:  CubitConsumer<ContractCubit,ContractState>(builder: (context,state){
        if(state is IntialState)
          return Center(child:Text("Connect to the wallet first"));
        if(state is PredictState)
          {
              prediction = state.result==1?"Postive":"Negative";
           
          }
        return buildBody();
        
      }, listener: ( context, state) {
         if(state is ErrorState)
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error),));
        }
        
        },)
      )
    ;
  }


  buildBody()=>Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child:  SingleChildScrollView(
                    child: Form(
                      child: Column(
                        children: [
                        
                          Padding(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: ElevatedButton(
                                  child: Text(
                                    'Get Prediction',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                  ),
                                  onPressed: () {
                                    
                                   CubitProvider.of<ContractCubit>(context).predict(yourNameController.text);
                                   
                                    
                                                                  },
                                ),
                              ), 
                              SizedBox(width:40),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Text(prediction,style: TextStyle(fontSize: 30,color: Colors.blue,)),
                              )
                            ],
                          ),
                          SizedBox(height:20),
                                                  Padding(
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
                                                   
                                                   ToggleButtons(children: [Icon(Icons.thumb_up_outlined),Icon(Icons.thumb_down_outlined),],
                                                     isSelected:isSelected,
                                                     onPressed: (index){
                                                       setState(() {
                                                         
                                                       isSelected[index] = true;
                                                       isSelected[1-index] =false;
                                                    
                                                       }); },
                         
                                                   ),
                          Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: ElevatedButton(
                              child: Text(
                                'Train',
                                style: TextStyle(fontSize: 30),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                              ),
                              onPressed: () {
                                int classificaion = isSelected[0]?1:0;
                                CubitProvider.of<ContractCubit>(context).train(trainController.text,classificaion);
                               
                                
                                                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
          ),
        );
}


