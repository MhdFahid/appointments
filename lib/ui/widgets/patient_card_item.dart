import 'package:flutter/material.dart';

class PatientCardItem extends StatelessWidget {
  const PatientCardItem(
      {super.key,
      required this.name,
      required this.tretmentName,
      required this.index,
      required this.date,
      required this.age});
  final String name;
  final String tretmentName;
  final String index;
  final String date;
  final String age;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(date);
    String onlyDate =
        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 236, 234, 234),
          borderRadius: BorderRadius.circular(8),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.5),
          //     spreadRadius: 2,
          //     blurRadius: 5,
          //     offset: const Offset(0, 3), // changes position of shadow
          //   ),
          // ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 15.0,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$index.",
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w500)),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(tretmentName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w300,
                                color: Color.fromARGB(255, 24, 175, 11))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.date_range,
                              size: 30,
                              color: Color.fromARGB(255, 254, 113, 113)),
                          SizedBox(width: 5),
                          Text(onlyDate,
                              style: const TextStyle(
                                  fontSize: 17,
                                  color: Color.fromARGB(255, 133, 130, 130))),
                          SizedBox(
                            width: 10,
                          ),
                          const Icon(Icons.date_range,
                              size: 30,
                              color: Color.fromARGB(255, 254, 113, 113)),
                          Text(age,
                              style: const TextStyle(
                                  fontSize: 17,
                                  color: Color.fromARGB(255, 133, 130, 130))),
                        ],
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 10),
              Divider(),
              Text("View Booking details",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 133, 130, 130),
                      fontWeight: FontWeight.normal)),
            ],
          ),
        ),
      ),
    );
  }
}
