import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.arrow_back,
                    size: 40, color: const Color.fromARGB(255, 41, 40, 40)),
                Spacer(),
                Icon(Icons.notifications_none_outlined,
                    size: 40, color: const Color.fromARGB(255, 142, 115, 115)),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search patients...',
                        prefixIcon: Icon(Icons.search,
                            size: 30,
                            color: Color.fromARGB(255, 133, 130, 130)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 29, 126, 33),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text("Search",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    )),
              ],
            ),
            SizedBox(height: 30),
            Row(
              children: [
                SizedBox(width: 10),
                Center(
                  child: Text("Sort by :",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 90, 80, 80),
                          fontSize: 18)),
                ),
                Spacer(),
                Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                          color: const Color.fromARGB(255, 160, 154, 154),
                          width: 2),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            Text("Date",
                                style: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 152, 127, 127),
                                    fontSize: 18)),
                            Spacer(),
                            Icon(
                              Icons.arrow_drop_down_sharp,
                              size: 30,
                            )
                          ],
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(height: 20),
            Divider(
              height: 4,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
