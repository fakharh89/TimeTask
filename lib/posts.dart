import 'package:flutter/material.dart';
import 'package:ntp/ntp.dart';
import 'package:timeago/timeago.dart' as timeago;

class Posts extends StatefulWidget {
  final snap;
  const Posts({Key? key, required this.snap}) : super(key: key);
  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  DateTime ntpTime = DateTime.fromMillisecondsSinceEpoch(0000000000);
  @override
  void initState() {
    super.initState();

    asyncInitState();
  }

  void asyncInitState() async {
    var a = await NTP.now(lookUpAddress: '1.amazon.pool.ntp.org');
    setState(() {
      ntpTime = a;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        ListTile(
          title: Text(widget.snap['title']),
          subtitle: Text(timeago.format(widget.snap['datePublished'].toDate(),
              clock: ntpTime, locale: 'en')),
        ),
      ],
    ));
  }
}
