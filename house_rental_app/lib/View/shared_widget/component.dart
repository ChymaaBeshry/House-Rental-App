import 'package:flutter/material.dart';
import 'package:newproject/View/Utilities/imageManager.dart';
import 'package:newproject/View/Utilities/valuesManager.dart';
import 'package:newproject/View/Utilities/iconsManager.dart';
import 'package:newproject/View/Utilities/StringManager.dart';
import 'package:newproject/view/shared_theme/shared_colors.dart';
import 'package:newproject/view/shared_theme/share_fonts.dart';

List<String> Categorytitle = [
  " space ",
  " Premium ",
  " Hotel ",
  " House ",
  " Land ",
];

List<Map<String, dynamic>> settingsSectionDetails = [
  {
    "icon1": IconsManager.iconHouse,
    "title": StringsManager.country,
    "title2": StringsManager.egypt,
    "key": GlobalKey<PopupMenuButtonState>(),
    "data": [
      "Helwan , Egypt ",
      "Cairo , Egypt",
      "Giza , Egypt",
      "Maadi , Egypt",
      "Aswan , Egypt",
    ],
    "notification": false,
  },
  {
    "icon1": IconsManager.iconLanguage,
    "title": StringsManager.language,
    "title2": StringsManager.arabic,
    "key": GlobalKey<PopupMenuButtonState>(),
    "data": [
      StringsManager.english,
      StringsManager.arabic,
      StringsManager.german,
      StringsManager.spanish,
      StringsManager.french,
    ],
    "notification": false,
  },
  {
    "icon1": IconsManager.iconNotification,
    "title": StringsManager.notification,
    "title2": "4 ",
    "key": GlobalKey<PopupMenuButtonState>(),
    "data": [
      "Helwan , Egypt ",
      "Cairo , Egypt",
      "Giza , Egypt",
      "Maadi , Egypt",
      "Aswan , Egypt",
    ],
    "notification": true,
  },
];
List<String> photoGallery = [
  "https://cdn.vox-cdn.com/thumbor/1L4a4ve76ZqVZyjn0h5FWWxbcmQ=/0x0:4000x2667/920x613/filters:focal(1680x1014:2320x1654):format(webp)/cdn.vox-cdn.com/uploads/chorus_image/image/65889507/0120_Westerly_Reveal_6C_Kitchen_Alt_Angles_Lights_on_15.14.jpg",
  "https://image.shutterstock.com/image-photo/modern-contemporary-en-suite-bahroom-600w-506610379.jpg",
  "https://media.istockphoto.com/photos/rendering-of-an-elegant-bedroom-picture-id1213695547",
  "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/white-bedrooms-1585283934.jpg?crop=1.00xw:0.755xh;0,0.0962xh&resize=980:*",
  "https://archello.s3.eu-central-1.amazonaws.com/images/2020/11/13/corpus-architects-luxury-modern-house-garden-design-residential-landscape-archello.1605283804.1979.jpg",
];
List<String> apartmentphoto = [
  "https://thermohouse.ie/wp-content/uploads/2019/04/hero-image.jpg",
  "https://images.adsttc.com/media/images/629f/3517/c372/5201/650f/1c7f/slideshow/hyde-park-house-robeson-architects_1.jpg?1654601149",
  "https://thermohouse.ie/wp-content/uploads/2019/04/hero-image.jpg",
];
Row apartmentDetail(String title, IconData icon) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: SharedColors.OrangeColor,
          size: AppSize.size15,
        ),
        Text(
          title,
          style: SharedFonts.subGreyFont,
          maxLines: AppSize.size2,
        ),
      ],
    );
Column FABSection(
  IconData icon,
  String title,
) =>
    Column(
      children: [
        Icon(
          icon,
          color: SharedColors.BalckColor,
        ),
        titleSection(title),
      ],
    );

Padding accountSection(IconData icon1, String title, String title2,
        bool isNotification, Key key, List data, context) =>
    Padding(
      padding: const EdgeInsets.all(AppSize.size20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon1,
                color: SharedColors.OrangeColor,
              ),
              Text(
                title,
                style: SharedFonts.primaryBlackFont,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                title2,
                style: SharedFonts.primaryOrangeFont,
              ),
              isNotification == true
                  ? IconButton(
                      icon: Icon(IconsManager.iconRight),
                      onPressed: () {},
                    )
                  : PopupMenuButton(
                      key: key,
                      elevation: AppSize.size10,
                      icon: Icon(IconsManager.iconDrawer),
                      itemBuilder: (context) => [
                            for (int i = 0; i < 5; i++)
                              PopupMenuItem(
                                child: Text(data[i]),
                                //value: Categorytitle[0] ,
                              ),
                          ]),
            ],
          ),
        ],
      ),
    );
Padding accountSection1(IconData icon1, String title, String title2,
        IconData icon2, context, String screen) =>
    Padding(
      padding: const EdgeInsets.all(AppSize.size10),
      child: ListTile(
          leading: Icon(
            icon1,
            color: SharedColors.OrangeColor,
          ),
          title: Text(
            title,
            style: SharedFonts.primaryBlackFont,
          ),
          trailing: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, screen);
              },
              icon: Icon(
                icon2,
                color: SharedColors.BalckColor,
              ))),
    );
Padding titleSection(String title) => Padding(
      padding: const EdgeInsets.all(AppSize.size10),
      child: Text(
        title,
        style: SharedFonts.primaryBlackFont,
      ),
    );
Widget OR() => Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Divider(
          color: SharedColors.GreykColor,
          thickness: 2,
        ),
        Container(
            width: AppSize.size35,
            height: AppSize.size25,
            color: SharedColors.GreykColor,
            alignment: Alignment.center,
            child: Text(
              StringsManager.or,
              style: SharedFonts.primaryOrangeFont,
            )),
      ],
    );
Widget faceGoogle(String? sign) => Column(
      children: [
        Text(
          "$sign",
          style:
              TextStyle(fontSize: AppSize.size25, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: AppSize.size10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            logos(logo[0]),
            logos(logo[1]),
          ],
        ),
      ],
    );
TextButton sharedButton(
        {required String title, required VoidCallback onPressed}) =>
    TextButton(
      onPressed: () {
        onPressed();
      },
      child: Container(
        width: AppSize.size300,
        height: AppSize.size40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: SharedColors.OrangeColor,
          borderRadius: BorderRadiusDirectional.circular(AppSize.size10),
        ),
        child: Text(
          title,
          style: SharedFonts.primaryGreyFont,
          textAlign: TextAlign.center,
        ),
      ),
    );

Divider divider() => Divider(
      height: AppSize.sizeD2,
      color: SharedColors.GreykColor,
      thickness: AppSize.sizeD2,
    );
List<String> logo = [
  ImagesManager.googleLogoImage,
  ImagesManager.facebookLogoImage
];
Container logos(String image) => Container(
      width: AppSize.size50,
      height: AppSize.size50,
      decoration: BoxDecoration(
          image: DecorationImage(
        fit: BoxFit.fill,
        image: AssetImage(image),
      )),
    );
ListTile listTilePopUp(String title, Key key, List data, String value) =>
    ListTile(
      leading: titleSection(title),
      title: Text(
        value,
        style: SharedFonts.subGreyFont,
      ),
      trailing: PopupMenuButton(
          key: key,
          elevation: AppSize.size10,
          icon: Icon(IconsManager.iconDrawer),
          itemBuilder: (context) => [
                for (int i = 0; i < 5; i++)
                  PopupMenuItem(
                    enabled: true,
                    onTap: () {
                      data[i] = value;
                    },
                    value: data[i],
                    child: Text(data[i]),
                    //value: Categorytitle[0] ,
                  ),
              ]),
    );

SnackBar snack({
  required String title,
  required Color color
}){
  return SnackBar(
    backgroundColor: color,
    content: Text(title, style: SharedFonts.primaryOrangeFont,),
    duration: Duration(milliseconds: AppSize.size500),
  );
}
IconButton sharedIconButton({
  required IconData icon,
  required Color color,
  required VoidCallback onPressed,
})=>IconButton(
     icon: Icon(icon , color:color),
    onPressed: onPressed,
  );
Center centerLoading()=>const Center(
  child: CircularProgressIndicator(),
);

Center centerErrorText()=>const Center(
  child: Text(StringsManager.somethingWentWrong),
);
Container decoratedContainer({required Widget child})=>Container(
  margin: EdgeInsetsDirectional.all(AppSize.size10),
  padding: EdgeInsetsDirectional.all(2),
  decoration: BoxDecoration(
    color: SharedColors.OrangeColor,
    borderRadius: BorderRadiusDirectional.circular(8),
  ),
  child: Container(
    decoration: BoxDecoration(
      color: SharedColors.WhiteColor,
      borderRadius:
      BorderRadiusDirectional.circular(AppSize.size10),
    ),
    child: child ,
  ),
);

TextButton textButton({required String title,required VoidCallback onPressed})=>TextButton(
  onPressed:onPressed,
  child:Text(title,style: title!=StringsManager.skip? SharedFonts.subBlackFont:SharedFonts.primaryOrangeFont, ),);






/*SnackBar snack({
  required String title,
  required Color color
}){
  return SnackBar(
    content: Container(
      height: AppSize.size100,
      width: double.infinity,
      child: Text(title, style: SharedFonts.primaryOrangeFont,),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadiusDirectional.only(
            topStart:Radius.circular(AppSize.size20) ,
            topEnd:Radius.circular(AppSize.size20)
        ),
      ),
    ),
    duration: Duration(milliseconds: AppSize.size500),
  );
}*/