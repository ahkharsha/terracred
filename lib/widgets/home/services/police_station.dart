import 'package:flutter/material.dart';
import 'package:terracred/const/constants.dart';
import 'package:terracred/multi-language/classes/language_constants.dart';

class PoliceStation extends StatelessWidget {
  final Function? onMapFunction;
  const PoliceStation({Key? key, this.onMapFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              onMapFunction!('Police stations near me');
            },
            child: Card(
              color: boxColor,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: Container(
                height: 50,
                width: 50,
                child: Center(
                  child: Image.asset(
                    'assets/images/services/police-station.png',
                    height: 32,
                  ),
                ),
              ),
            ),
          ),
          Text(translation(context).police)
        ],
      ),
    );
  }
}