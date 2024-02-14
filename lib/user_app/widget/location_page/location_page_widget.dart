import 'package:flutter/material.dart';

import '../../../routes/routes.dart';
import '../../domain/blocs/themes/themes_model.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 0),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Select Your Delivery Location"),
                  ),
                  const Divider(
                    height: 1,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            MainNavigationRouteNames.confirmLocation);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.my_location,
                            color: ThemeColor.greenColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Use my current location",
                            style: TextStyle(color: ThemeColor.greenColor),
                          ),
                        ],
                      )),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Divider(
                        height: 1,
                        endIndent: 5,
                      ),
                      Text("or"),
                      Divider(
                        color: Colors.orange,
                        height: 2,
                        indent: 10,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {},
                      focusColor: const Color(0xFF56AE7C),
                      borderRadius: BorderRadius.circular(10.0),
                      child: Material(
                        // color: const Color(0xFF151A20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(
                            color: Colors.transparent,
                            width: 2.0,
                          ),
                        ),
                        child: const ListTile(
                          title: Text(
                            'Type Location Manually',
                            // style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            child: Card(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Recent Searches"),
                    ),
                    Divider(
                      height: 1,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
