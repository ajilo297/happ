import 'package:flutter/material.dart';
import 'package:happ/core/models/appliance_model.dart';
import 'package:happ/widgets/rounded_card.dart';

class ApplianceCard extends StatelessWidget {
  final ApplianceModel applianceModel;
  final VoidCallback onToggle;

  ApplianceCard(this.applianceModel, {this.onToggle});

  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      width: 150,
      height: 200,
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 8, bottom: 8),
                    height: 8,
                    width: 8,
                    decoration: ShapeDecoration(
                      shape: CircleBorder(),
                      color: applianceModel.isOn
                          ? Colors.green
                          : Theme.of(context).disabledColor,
                    ),
                  ),
                ],
              ),
              Text(
                applianceModel?.name ?? 'Name',
                style: Theme.of(context).textTheme.subtitle,
                textAlign: TextAlign.start,
              ),
              Text(
                () {
                  String message = '';
                  if (applianceModel.isOn) {
                    message += 'On for last ';
                  } else {
                    message += 'Off for last ';
                  }
                  message += getDuration(applianceModel.updatedAt);
                  return message;
                }(),
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(
                height: 32,
              ),
              Center(
                child: IconButton(
                  icon: Icon(Icons.power_settings_new),
                  onPressed: onToggle,
                  iconSize: 32,
                  color: applianceModel.isOn
                      ? Theme.of(context).errorColor
                      : Theme.of(context).disabledColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getDuration(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    Duration difference = DateTime.now().difference(dateTime);

    return '${difference.inHours} Hours';
  }
}
