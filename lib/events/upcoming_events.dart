import 'package:flutter/material.dart';
import 'package:terracred/bottom-sheet/insta_share_bottom_sheet.dart';
import 'package:terracred/buttons/main_button.dart';
import 'package:terracred/const/constants.dart';
import 'package:terracred/model/event_model.dart';
import 'package:terracred/navigators.dart';

class UpcomingEvents extends StatefulWidget {
  const UpcomingEvents({Key? key}) : super(key: key);

  @override
  State<UpcomingEvents> createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  List<Event> events = [];

  void addEvent() {
    setState(() {
      events.add(
        Event(
          title: titleController.text,
          description: descriptionController.text,
          time: timeController.text,
          date: dateController.text,
          place: placeController.text,
        ),
      );
      titleController.clear();
      descriptionController.clear();
      timeController.clear();
      dateController.clear();
      placeController.clear();
    });
  }

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
          'Upcoming Events',
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
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Upcoming Event Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Event Description'),
              ),
              TextField(
                controller: timeController,
                decoration: InputDecoration(labelText: 'Time'),
              ),
              TextField(
                controller: dateController,
                decoration: InputDecoration(labelText: 'Date'),
              ),
              TextField(
                controller: placeController,
                decoration: InputDecoration(labelText: 'Place'),
              ),
              SizedBox(height: 20),
              MainButton(
                onPressed: addEvent,
                title: 'Add your event',
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return Card(
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
                        subtitle: Text('${event.time}, ${event.date}, ${event.place}'),
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