// @dart=2.9
import 'package:deai_client/controllers/MenuController.dart';
import 'package:deai_client/screens/dashboard/dashboard_screen.dart';
import 'package:deai_client/state_management/contract_cubit.dart';
import 'package:deai_client/state_management/contract_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_web3_provider/ethereum.dart';
import 'package:flutter_web3_provider/ethers.dart';
import 'package:provider/provider.dart';

import 'dart:js_util';
import '../../constants.dart';
import '../../responsive.dart';
import 'components/side_menu.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin{
  TabController tabController;
  String selectedAddress;
  bool _walletConnected = false;
  void initState(){
    super.initState();
    tabController =  TabController(vsync:this,length:4,initialIndex: 0);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
     // drawer: sideMenu(context),
      body: SafeArea(
       child: CubitConsumer<ContractCubit, ContractState>(
          builder: (context, state) {
        
            return buildBody(context);
          },
          listener: (context, state) {
            if (state is ErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.error),
              ));
            
            }
           
          },
        )
      
      ),
    );
  
  }
buildBody(BuildContext context)=>Container(
          height:MediaQuery.of(context).size.height ,
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              if (Responsive.isDesktop(context))
                Expanded(
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child:sideMenu(context)
                ),
              Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: Container(
                  padding:EdgeInsets.symmetric(horizontal: 10),
                  height:MediaQuery.of(context).size.height,
                  child: Column(
                    children:[
                    Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: context.read<MenuController>().controlMenu,
          ),
        if (!Responsive.isMobile(context))
          Text(
            "DeAi",
            style: Theme.of(context).textTheme.headline6,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
          Container(
            padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
            child: ElevatedButton.icon(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
                 onPressed: () async {
                if (!_walletConnected) {
                  var accounts = await promiseToFuture(ethereum
                      .request(RequestParams(method: 'eth_requestAccounts')));
                  print(accounts);
                  String se = ethereum.selectedAddress;
                  print("selectedAddress: $se");
                  setState(() {
                    selectedAddress = se;
                    _walletConnected = true;
                  });
                  var web3 = Web3Provider(ethereum);
                  
                  CubitProvider.of<ContractCubit>(context).startContract(web3);}},
                icon: Icon(Icons.wallet_travel),
                label: Text(_walletConnected ? "Wallet Connected" : "Connect Wallet")
              ),
          ),
      //  Expanded(child: SearchField()),
       // ProfileCard()
      ],
    ),
                    Expanded(
                      flex:8,
                      child: TabBarView(
                  controller: tabController,
                  children: [
                      DashboardScreen(),
                      DashboardScreen(),
                      DashboardScreen(),
                      DashboardScreen(),
                  ],
              ),
                    )],),
                ),
              ),
            ],
          ),
        );

sideMenu(BuildContext context)=>Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image(image:AssetImage("assets/images/logo2.png"))
          ),
        
          DrawerListTile(
            title: "ML Models",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              tabController.animateTo(1);
            },
          ),
         
        
          DrawerListTile(
            title: "History",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {
              tabController.animateTo(3);
            },
          ),
          DrawerListTile(
            title: "Subscription",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {
              tabController.animateTo(4);
            },
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {
              tabController.animateTo(5);
            },
          ),
        ],
      ),
    );
}
