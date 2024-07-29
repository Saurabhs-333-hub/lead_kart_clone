


import 'package:flutter/cupertino.dart';
import 'package:leadkart/ApiServices/leads%20api.dart';
import 'package:leadkart/Models/LeadsApiresponce.dart';
import 'package:leadkart/helper/helper.dart';

class LeadsProvider with ChangeNotifier{


  //const var

  final _leadsApi =  LeadsApi();

  bool _isLoad = false;
  List<Lead> _allLeads = [];

  List<Lead> get allLeads => _allLeads;
  bool get isLoad => _isLoad;




  //get Leads by BusinessId;
  Future<void> getLeads(BuildContext context) async
  {

    var resp = await _leadsApi.getAllLeads();

    if(resp.statusCode==200)
      {
        try
            {
              var d = LeadsApiResponce.fromJson(resp.data);
              _allLeads = d.data??[];
            }
            catch(e)
    {
      MyHelper.mySnakebar(context, "$e");
    }

      }
    else
      {
        MyHelper.mySnakebar(context, "${resp.statusCode} ${resp.data}");
      }

    _isLoad = true;
    notifyListeners();

  }


  clear()
  {
    _isLoad = true;
    _allLeads = [];
    notifyListeners();
  }





}