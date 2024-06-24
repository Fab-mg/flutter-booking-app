import 'package:flutter/material.dart';

Widget ItemBuilderGlobal({
  required String imageLink,
  required String label,
  required BuildContext context,
  required Widget widgetPath,
  required bool iconCircular,
  required bool isCircular,
  required double iconSize,
}) {
  return InkWell(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => widgetPath));
    },
    child: Container(
      child: Column(
        children: [
          Container(
            width: iconSize,
            height: iconSize,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.transparent,
                    // Colors.white,
                    // Color.fromARGB(255, 167, 84, 182),
                    Colors.transparent,
                    // Colors.white,
                  ],
                ),
                shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
                border: Border.all(
                  color: Colors.white,
                  width: 3,
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imageLink),
                      fit: BoxFit.cover,
                    ),
                    shape: iconCircular ? BoxShape.circle : BoxShape.rectangle,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
            constraints: BoxConstraints(maxWidth: 100),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
