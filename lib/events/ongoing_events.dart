import 'package:flutter/material.dart';
import 'package:terracred/bottom-sheet/insta_share_bottom_sheet.dart';
import 'package:terracred/const/constants.dart';
import 'package:terracred/model/event_model.dart';
import 'package:terracred/navigators.dart';

class OngoingEvents extends StatefulWidget {
  const OngoingEvents({Key? key}) : super(key: key);

  @override
  State<OngoingEvents> createState() => _OngoingEventsState();
}

class _OngoingEventsState extends State<OngoingEvents> {
  List<Event> sampleEvents = [
    Event(
      title: 'Sample Event 1',
      description: 'Description of Sample Event 1',
      time: '12:00 PM',
      date: '2024-04-18',
      place: 'Sample Place 1',
    ),
    Event(
      title: 'Sample Event 2',
      description: 'Description of Sample Event 2',
      time: '2:30 PM',
      date: '2024-04-19',
      place: 'Sample Place 2',
    ),
    Event(
      title: 'Sample Event 3',
      description: 'Description of Sample Event 3',
      time: '5:00 PM',
      date: '2024-04-20',
      place: 'Sample Place 3',
    ),
    Event(
      title: 'Sample Event 4',
      description: 'Description of Sample Event 4',
      time: '10:00 AM',
      date: '2024-04-21',
      place: 'Sample Place 4',
    ),
    Event(
      title: 'Sample Event 5',
      description: 'Description of Sample Event 5',
      time: '3:45 PM',
      date: '2024-04-22',
      place: 'Sample Place 5',
    ),
    Event(
      title: 'Sample Event 6',
      description: 'Description of Sample Event 6',
      time: '1:15 PM',
      date: '2024-04-23',
      place: 'Sample Place 6',
    ),
    Event(
      title: 'Sample Event 7',
      description: 'Description of Sample Event 7',
      time: '9:30 AM',
      date: '2024-04-24',
      place: 'Sample Place 7',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () => goBack(context),
        ),
        title: Text(
          'Ongoing Events',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: false,
        backgroundColor: primaryColor,
      ),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 5.0, right: 5.0),
      //   child: FloatingActionButton(
      //     onPressed: () {
      //       showModalBottomSheet<void>(
      //         context: context,
      //         builder: (BuildContext context) {
      //           return InstaShareBottomSheet();
      //         },
      //       );
      //     },
      //     backgroundColor: Colors.red,
      //     foregroundColor: boxColor,
      //     highlightElevation: 50,
      //     child: Icon(
      //       Icons.warning_outlined,
      //     ),
      //   ),
      // ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: sampleEvents.length,
                  itemBuilder: (context, index) {
                    final event = sampleEvents[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: ListTile(
                        title: Text(event.title),
                        tileColor: boxColor,
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Time: ${event.time}'),
                            Text('Date: ${event.date}'),
                            Text('Place: ${event.place}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
