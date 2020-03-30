import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:openspaces/hospitalmap/bloc/point_of_interest_bloc.dart';
import 'package:openspaces/hospitalmap/repo/point_of_interest.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

import 'api.dart';
import 'colors.dart';

Widget buildCacheImageWidget(String imageUrl) {
  return CachedNetworkImage(
    imageBuilder: (context, imageProvider) => GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
    imageUrl: imageUrl,
    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
    errorWidget: (context, url, error) => Icon(Icons.error_outline),
  );
}

Widget buildNetworkImageWidget(String imageUrl, width, height) {
  if (imageUrl == null || imageUrl.isEmpty) {
    return Container(
      color: OpenSpaceColors.blue,
      height: height,
      width: width,
    );
  }

  if (imageUrl != null && imageUrl.isNotEmpty && !imageUrl.contains("http")) {
    imageUrl = base_url + "media/" + imageUrl;
  }

  return Container(
    height: height,
    width: width,
    child: Image.network(imageUrl),
  );
}

Widget buildNetworkCacheImageWidget(String imageUrl, width, height) {
  if (imageUrl != null && imageUrl.isNotEmpty && !imageUrl.contains("http")) {
    imageUrl = base_url + "media/" + imageUrl;
  }

  return CachedNetworkImage(
    imageBuilder: (context, imageProvider) => Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    ),
    imageUrl: getSafeString(imageUrl),
    placeholder: (context, url) => Container(
        height: height,
        width: width,
        child: Center(child: CircularProgressIndicator())),
    errorWidget: (context, url, error) => Container(
        color: OpenSpaceColors.blue,
        height: height,
        width: width,
        child: Icon(
          Icons.error_outline,
          color: Colors.white,
        )),
  );
}

String getSafeString(value) {
  return (value == null) ? "" : value.toString();
}

Widget buildNetworkSVGWidget(String url, {label = "A image"}) {
  return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      fadeOutDuration: const Duration(seconds: 1),
      fadeInDuration: const Duration(seconds: 3),
      width: 24.0,
      height: 24.0,
      fit: BoxFit.contain,
      color: OpenSpaceColors.icon_color);
}

//Widget buildSvgWidget(String iconName, Color color) {
//  final Widget svgIcon = SvgPicture.asset(iconName,
//      height: 20.0,
//      width: 20.0,
//      semanticsLabel: 'Ajustes Logo',
//      allowDrawingOutsideViewBox: true,
//      color: color);
//  return svgIcon;
//}

Widget buildMapMarkerV2(PointOfInterest pointOfInterest) {
  return InkWell(
    onTap: () {
      pointOfInterestBloc.updateSelectedPointOfInterest(pointOfInterest);
      pointOfInterestBloc
          .updateBottomSheetSnapPosition(SnapPosition(positionFactor: 0.3));
    },
    child: Icon(
      Icons.local_hospital,
      color: OpenSpaceColors.red,
    ),
  );
}

Widget buildActiveMapMarker(PointOfInterest pointOfInterest) {
  return InkWell(
    onTap: () {},
    child: Icon(
      Icons.local_hospital,
      size: 32,
      color: OpenSpaceColors.red,
    ),
  );
}

Widget buildMapMarker(String openSpaceId) {
  return InkWell(
      onTap: () {},
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: OpenSpaceColors.blue_transparent,
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          Center(
            child: Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                color: OpenSpaceColors.blue,
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ],
      ));
}

BoxShadow defaultBoxShadow() {
  return BoxShadow(color: Color.fromRGBO(0, 0, 0, .25), blurRadius: 16.0);
}

Widget buildMapUiIcon(Icon icon) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      border: Border.all(color: OpenSpaceColors.border_color),
      color: OpenSpaceColors.selected_color,
    ),
    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
    child: icon,
  );
}

EdgeInsets defaultContentPadding =
    const EdgeInsets.only(left: 16.0, right: 16.0);

Widget buildButton(String text, Color buttonColor, Color textColor,
    [Function onTapFunc]) {
  return Material(
    color: buttonColor,
    child: InkWell(
      onTap: onTapFunc,
      child: Container(
        height: 40.0,
        width: 80,
        child: Center(
          child: Text(
            text.toUpperCase(),
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    ),
  );
}

showToastMessage({message}) {
  Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: OpenSpaceColors.white,
      textColor: OpenSpaceColors.text_color);
}

launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    showToastMessage(message: "Could not lauch $url");
    throw 'Could not launch $url';
  }
}

Future<void> updateDialog(BuildContext context,
    {@required title, @required message,@required actions}) {
  return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: actions
        );
      });
}

launchCaller(String number) async {
  var url = "tel:$number";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Widget buildAppBar(BuildContext context, String title) {
  return AppBar(
      title: Text(
        title,
        style: TextStyle(
            fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: OpenSpaceColors.icon_color,
        ),
        onPressed: () => Navigator.pop(context, false),
      ));
}

Widget buildProgressBar(BuildContext context) {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget buildNoData(BuildContext context, {errorMessage = "No data found"}) {
  return Center(
    child: Text(errorMessage),
  );
}

Widget buildProgressAndNoData(context, snapshot,
    {errorMessage = "No data found"}) {
  bool isLoadingData =
      snapshot.connectionState.index == ConnectionState.waiting.index;
//  isLoadingData = !snapshot.hasData();
  if (isLoadingData) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: buildProgressBar(context));
  } else if (snapshot.hasError) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: buildNoData(context, errorMessage: errorMessage));
  }
}

//https://flutterbyexample.com/gradients-background/
Widget buildTopGradient() {
  return Container(
      height: 100,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [
          0.2,
          1,
        ],
        colors: [Colors.white, OpenSpaceColors.gradient_bottom],
      )));
}

Widget buildNavMenu(BuildContext context) {
  return Positioned(
    top: 42.0,
    left: 16.0,
    child: GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
        child: Icon(Icons.menu),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: [
            BoxShadow(color: Color.fromRGBO(0, 0, 0, .25), blurRadius: 16.0)
          ],
        ),
      ),
    ),
  );
}

TextStyle styleInActiveWhite = TextStyle(
    fontSize: 14,
    color: OpenSpaceColors.inactive_tab_text,
    fontWeight: FontWeight.bold);
