import 'package:flutter/material.dart';
import 'package:smarta1/widgets/travel/models/travel_detail_model.dart';

class ReservationTravelWidget extends StatelessWidget {
  TravelDetailModel travel;
  ReservationTravelWidget({required this.travel});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // IconfieldBuilder(
          //     icon: Icons.book,
          //     iconColor: Colors.white,
          //     label: 'label',
          //     textContent: 'textContent',
          //     spacing: 10),
          Row(
            children: [
              Icon(Icons.phone),
              SizedBox(width: 8),
              Text(
                travel.arrivalCity.cityName,
                style: textstyle,
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

var textstyle = TextStyle(color: Colors.black, fontSize: 15);

// Widget IconfieldBuilder({
//   required IconData icon,
//   required Color iconColor,
//   required String label,
//   required String textContent,
//   required double spacing,
// }) {
//   return Container(
//     child: Row(
//       children: [
//         Icon(icon),
//         SizedBox(width: spacing),
//         Text(label),
//         SizedBox(width: spacing),
//         Text(textContent),
//       ],
//     ),
//   );
// }
