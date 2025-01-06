import 'package:flutter/material.dart';
import 'package:reorder_app/models/models.dart';
import 'package:reorder_app/routes/screen_arguments.dart';

class TimeLineView extends StatefulWidget {
  const TimeLineView({super.key, required this.data});

  static const routeName = '/TimeLineView';
  final ScreenArguments data;

  @override
  State<TimeLineView> createState() => _TimeLineViewState();
}

class _TimeLineViewState extends State<TimeLineView> {
  List<TimeLineModel> timeLineModel = [];

  @override
  void initState() {
    timeLineModel = widget.data.arg1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Hoạt động gần đây",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            // Timeline starts here
            ListView.builder(
              shrinkWrap: true,
              itemCount: timeLineModel.length,
              itemBuilder: (context, index) {
                return buildTimelineItem(index + 1, "${timeLineModel[index].title}",
                    "${timeLineModel[index].content}", true);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                timeLineModel.clear();
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTimelineItem(int index, String title, String description, bool isCompleted) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: Colors.blue,
              child: Text(
                index.toString(),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,),
              ),
            ),
            Container(
              width: 2,
              height: 50,
              color: Colors.grey,
            ),
          ],
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.red,
                  fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}
