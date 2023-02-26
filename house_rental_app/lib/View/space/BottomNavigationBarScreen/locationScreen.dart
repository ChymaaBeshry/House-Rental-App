
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newproject/Controller/MapController/mapCubit.dart';
import 'package:newproject/Controller/MapController/mapStates.dart';
import 'package:newproject/View/Utilities/StringManager.dart';
import 'package:newproject/View/Utilities/iconsManager.dart';
import 'package:newproject/View/Utilities/valuesManager.dart';
import 'package:newproject/View/shared_theme/share_fonts.dart';
import 'package:newproject/view/shared_widget/inputFeildWidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../Controller/spaceController/spaceCubit.dart';
import '../../shared_widget/apartmentWidget.dart';
import '../../shared_widget/component.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen();
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  TextEditingController locationController=TextEditingController();
  final locationKey=GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    MapController mapController= BlocProvider.of<MapController>(context);
    SpaceCubit spaceController= BlocProvider.of<SpaceCubit>(context);
    return BlocBuilder<MapController,MapStates>(
     builder:(context,state) {
       if (state is ErrorStatusState) {
         return Center(child: Text(
           "Please Give Us a(Permission or Enable Location Service)",
           style: SharedFonts.primaryOrangeFont,),);
       } else if (state is ErrorMapState) {
         return centerErrorText();
       } else if (state is LoadingMapState) {
         return centerLoading();
        }else {
         return Scaffold(
             body: Stack(
               alignment: AlignmentDirectional.bottomCenter,
               children: [
                 Column(
                   children: [
                     SafeArea(
                         top: true,
                         child: Container(
                           padding: EdgeInsets.fromLTRB(
                               AppSize.size3, AppSize.size10, AppSize.size3,
                               AppSize.size3),
                           alignment: Alignment.center,
                           height: AppSize.size70,
                           child: InputField(
                             model: InputModel(
                               key: locationKey,
                               controller: locationController,
                               prefix: IconsManager.iconLocation,
                               keyboardType: TextInputType.streetAddress,
                               title: StringsManager.searchYorLocation,
                               hint: StringsManager.enterYourLocation,
                               onSubmitted: ()async {
                                 await mapController.getSearchLocation(
                                     locationController.text);
                                 mapController.getDirections();
                                 spaceController.getNearbySpace(mapController.latlng);
                               },

                             ),
                           ),
                         )
                     ),
                     Flexible(
                       child: GoogleMap(
                         initialCameraPosition: CameraPosition(
                           target: mapController.latlng,
                           zoom: AppSize.size15,
                         ),
                         myLocationEnabled: true,
                         myLocationButtonEnabled: true,
                         mapType: MapType.normal,
                         markers: mapController.markers,
                         polylines: Set<Polyline>.of(mapController.polyLines.values),
                       ),)
                   ],
                 ),
                 Container(
                   height: 250,
                   child:ListView.builder(
                     scrollDirection: Axis.horizontal,
                     itemBuilder: (context,index)=> ApartmentWidget(isDetail: true,spaceModel: spaceController.nearbyList[index]),
                     itemCount: spaceController.nearbyList.length,
                   ),
                 ),
               ],
             )
         );
       }
     }
   );
  }
}

     /* body:Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://www.google.com/maps/d/thumbnail?mid=17Html8AHIeJ2g4ALF1y8d4jKVh4&hl=en"),
            fit: BoxFit.fill,
            )
        ),
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: defaultInput( locationKey,TextInputType.text,locationController,"Type Keyword", Icons.location_on),
            ),
            SizedBox(
              height: 200,
            ),
            Container(
              height: 250,
              child:ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (contex,index)=> ApartmentWidget(110,false,index),
                itemCount: 3,
              ),
            ),
          ],
        ),
      ),
    );

  }

  Widget defaultInput(  Key key , TextInputType type , TextEditingController controller , String text , IconData  prefixIcon , )=>
      TextFormField(
        key: key,
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          filled: true,

          fillColor: SharedColors.WhiteColor,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            labelText: text,
            labelStyle: TextStyle(color:SharedColors.GreykColor , fontSize: 18),
            prefixIcon: Icon( prefixIcon , color:SharedColors.OrangeColor),
            focusedBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color:SharedColors.OrangeColor )),
            suffixIcon: text == "password"  ? IconButton(icon: Icon( Icons.remove_red_eye) ,
              onPressed: (){
                setState(() {
                  pressesd=!pressesd;
                });
              },): null
        ),
        obscureText: text == "password"  ? pressesd : false,
        validator: (value){
          if( value!.isEmpty ){
            return " Please enter your $text ";
          }else {
            print(value);
          }
        },
      );
}*/