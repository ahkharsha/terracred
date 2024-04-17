import 'package:flutter/material.dart';
import 'package:terracred/bottom-sheet/insta_share_bottom_sheet.dart';
import 'package:terracred/const/constants.dart';
import 'package:terracred/model/event_model.dart';
import 'package:terracred/navigators.dart';

class PastEvents extends StatefulWidget {
  const PastEvents({Key? key}) : super(key: key);

  @override
  State<PastEvents> createState() => _PastEventsState();
}

class _PastEventsState extends State<PastEvents> {
  List<Event> pastEvents = [
    Event(
      title: 'Past Event 1',
      description: 'Description of Past Event 1',
      time: '12:00 PM',
      date: '2023-04-18',
      place: 'Past Place 1',
    ),
    Event(
      title: 'Past Event 2',
      description: 'Description of Past Event 2',
      time: '2:30 PM',
      date: '2023-04-19',
      place: 'Past Place 2',
    ),
    Event(
      title: 'Past Event 3',
      description: 'Description of Past Event 3',
      time: '5:00 PM',
      date: '2023-04-20',
      place: 'Past Place 3',
    ),
    Event(
      title: 'Past Event 4',
      description: 'Description of Past Event 4',
      time: '10:00 AM',
      date: '2023-04-21',
      place: 'Past Place 4',
    ),
    Event(
      title: 'Past Event 5',
      description: 'Description of Past Event 5',
      time: '3:45 PM',
      date: '2023-04-22',
      place: 'Past Place 5',
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
          'Past Events',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: false,
        backgroundColor: primaryColor,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 5.0, right: 5.0),
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return InstaShareBottomSheet();
              },
            );
          },
          backgroundColor: Colors.red,
          foregroundColor: boxColor,
          highlightElevation: 50,
          child: Icon(
            Icons.warning_outlined,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: pastEvents.length,
                  itemBuilder: (context, index) {
                    final event = pastEvents[index];
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

