

import 'package:flutter/material.dart';import 'package:leadkart/helper/TextStyles.dart';import 'package:leadkart/them/constents.dart';
import 'package:leadkart/component/sheder%20Iocn.dart';
import 'package:leadkart/helper/TextStyles.dart';
import 'package:leadkart/them/constents.dart';

import '../helper/dimention.dart';
import '../helper/helper.dart';



class LeadeTile2 extends StatefulWidget {
  double elevation;
  void Function(bool?)? onChnage;
  void Function()? onTap;
  LeadeTile2({this.onChnage,this.onTap,this.elevation = .5,super.key});

  @override
  State<LeadeTile2> createState() => _LeadeTile2State();
}

class _LeadeTile2State extends State<LeadeTile2> {
  bool active = false;

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation:widget.elevation,
      surfaceTintColor: Colors.transparent,
      color: Colors.white,
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.symmetric(horizontal: SC.from_width(12),vertical: 5),
      child: InkWell(
        splashColor: AppConstent().leadsBannerColor,
        onTap: widget.onTap,
        child: Container(
          height: SC.from_width(80),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Checkbox(
                value: active, onChanged: (v){
                active=!active;
                if(widget.onChnage!=null)
                  {
                    widget.onChnage!(v);
                  }
                setState(() {

                });
              },),

              //Leading
              Container(
                clipBehavior: Clip.hardEdge,
                margin: EdgeInsets.all(SC.from_width(8)),

                width: SC.from_width(69),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300,width: 2),
                    borderRadius: BorderRadius.circular(5)),
                child: Stack(
                  children: [
                    Image.asset("assets/onBording2/leadTileImage.png",fit: BoxFit.cover,),

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: SC.from_width(17),
                        color: Colors.black.withOpacity(.5),
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text("See detail",
                          style: TextStyle(fontSize: SC.from_width(8.7),color: Colors.white),),
                      ),
                    )

                  ],
                ),

              ),

              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    //title
                    Text("Demo Lead",overflow: TextOverflow.ellipsis,maxLines: 1,style: TextStyles().leadTileTitle),

                    //subtitle
                    Text("+91 9988909890",maxLines: 1,overflow: TextOverflow.ellipsis,style:TextStyles().leadTileSubTitle),

                    Text("Added : 8789-887-788",maxLines: 1,overflow: TextOverflow.ellipsis,style:TextStyles().leadTileSubTitle),

                  ],
                ),
              ),

              AspectRatio(aspectRatio: 1,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Text("New Lead",style: TextStyle(fontSize: SC.from_width(12),fontWeight: FontWeight.w500),),
                        decoration: BoxDecoration(
                            color: AppConstent().leadTiletagColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(32)
                            )
                        ),
                      ),
                      Expanded(
                          child: ShederIcon(iconData: Icons.call_outlined,)
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}