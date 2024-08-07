import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leadkart/ApiServices/BussnessApi.dart';
import 'package:leadkart/Models/BussnessdetailModel.dart';
import 'package:leadkart/Models/MycustomResponce.dart';
import 'package:leadkart/Models/VerifyOtpModel.dart';
import 'package:leadkart/Models/business_model.dart';
import 'package:leadkart/controllers/shredprefrence.dart';
import 'package:leadkart/helper/controllerInstances.dart';
import 'package:leadkart/helper/helper.dart';
import 'package:logger/logger.dart';


class BusinessProvider with ChangeNotifier {

  final  _log = Logger();

  //Variables
  bool _loding = false;
  bool _warning = true;
  bool _isWarningOpen = false;
  List<BusinessModel> _allBusiness = [];
  BusinessModel? _currentBusiness;
  //

  //Getters
  bool get loding => _loding;
  bool get warnIng => _warning;
  List<BusinessModel> get allBusiness => _allBusiness;
  BusinessModel? get currentBusiness => _currentBusiness;
  //

//lode Method
  Future<void> lode(BuildContext context) async {
    _loding = true;
    CurrentUser? user = await Controllers.userPreferencesController.getUser();
    CustomResponce responce =
        await BussnissApi().getBusinessByUserId(userId: user!.id!);

    if (responce.statusCode == 200) {
      _allBusiness = responce.data;
    }

    _loding = false;
    _currentBusiness = await Controllers.useraPrefrenc.getBusiness();
    notifyListeners();
    if(!_isWarningOpen&& _warning)
      {
        showWarning(context);
      }

  }
  //

  //set Current Business
  setCurrentBusiness(BusinessModel business) {
    _currentBusiness = business;
    notifyListeners();
    UserPreference().saveBusiness(business);
  }
  //

 Future<bool> showWarning(BuildContext context) async
 {
   _log.i("Hi Threr");
   if(_currentBusiness!=null)
     {
       _isWarningOpen  =true;
       BusinessDetailModel? businessDetail = await MyHelper.bussnissApi.getFullDetailOfBusiness(_currentBusiness?.id??"");
       if(businessDetail!=null)
         {
           _log.i("in");
           if(businessDetail.isFacebookPageLinked!=true)
             {
               await showDialog(context: context,
                   barrierDismissible: false,builder: (context)=>  AlertDialog(
                 title:const  Text("FaceBook page is not linked,please link",textAlign: TextAlign.center,),
                 actions: [
                   ElevatedButton(onPressed: (){}, child:const Text("Link")),
                   ElevatedButton(onPressed: (){
                     _warning = false;
                     Navigator.pop(context);
                   }, child:const Text("Cancel")),
                 ],
               ));
               return false;
             }
           else if(businessDetail.isMetaAccessTokenActive!=true)
             {
               await showDialog(
                 barrierDismissible: false,
                   context: context, builder: (context)=>  AlertDialog(
                 title:const  Text("Meta To",textAlign: TextAlign.center,),
                 actions: [
                   ElevatedButton(onPressed: (){
                     _warning = false;
                     Navigator.pop(context);
                   }, child:const Text("Close")),
                   // ElevatedButton(onPressed: (){
                   //   _warning = false;
                   //   Navigator.pop(context);
                   // }, child:const Text("Cancel")),
                 ],
               ));
               return false;
             }
           else
             {
               return true;
             }

         }
       else
         {
           return false;
         }
       _isWarningOpen = false;
     }
   else
     {
       return false;
     }
 }
}
