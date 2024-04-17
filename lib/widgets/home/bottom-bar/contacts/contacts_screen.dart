import 'package:flutter/material.dart';
import 'package:terracred/bottom-sheet/insta_share_bottom_sheet.dart';
import 'package:terracred/const/constants.dart';
import 'package:terracred/navigators.dart';
import 'package:terracred/multi-language/classes/language_constants.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
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
          translation(context).trustedContacts,
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
              buildUpcomingEventsTile(
                  'Upcoming Events', Icons.timelapse_rounded),
              buildOngoingEventsTile(
                  'Ongoing Events', Icons.access_time_rounded),
              buildPastEventsTile('Past Events', Icons.history_rounded),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUpcomingEventsTile(String name, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: InkWell(
        onTap: () => navigateToUpcomingEvents(context),
        child: Card(
          color: boxColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.black, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(icon),
              title: Text(name),
              trailing: Container(
                width: MediaQuery.of(context).size.width * 0.13555,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => navigateToUpcomingEvents(context),
                      icon: Icon(
                        Icons.navigate_next_rounded,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOngoingEventsTile(String name, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: InkWell(
        onTap: () => navigateToOngoingEvents(context),
        child: Card(
          color: boxColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.black, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(icon),
              title: Text(name),
              trailing: Container(
                width: MediaQuery.of(context).size.width * 0.13555,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => navigateToOngoingEvents(context),
                      icon: Icon(
                        Icons.navigate_next_rounded,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPastEventsTile(String name, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: InkWell(
        onTap: () => navigateToPastEvents(context),
        child: Card(
          color: boxColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.black, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(icon),
              title: Text(name),
              trailing: Container(
                width: MediaQuery.of(context).size.width * 0.13555,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => navigateToPastEvents(context),
                      icon: Icon(
                        Icons.navigate_next_rounded,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
