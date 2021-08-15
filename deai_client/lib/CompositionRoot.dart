
import 'package:deai_client/screens/main/main_screen.dart';
import 'package:deai_client/smartContracts/sentiment_analysis.dart';
import 'package:deai_client/state_management/contract_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:provider/provider.dart';

import 'controllers/MenuController.dart';

class CompositionRoot{
  static late NewContractLinking contractLinking;
  static configure() async{
    contractLinking = NewContractLinking();
   
  }
  static composeHomeUi(){
    ContractCubit contractCubit = ContractCubit(contractLinking);
    return  MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuController(),
          ),
          
          
        ],
        child:  CubitProvider(create: (BuildContext context) => contractCubit,child: MainScreen(),)
      );
     }
  
}