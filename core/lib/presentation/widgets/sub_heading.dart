import 'package:flutter/material.dart';
import 'package:core/core.dart';

class SubHeading extends StatelessWidget {
  final String? valueKey;
  final String text;
  final Function() onSeeMoreTapped;
  const SubHeading({
    this.valueKey,
    required this.text,
    required this.onSeeMoreTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        16.0,
        24.0,
        16.0,
        8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: kHeading6),
          InkWell(
            key: Key(valueKey!),
            onTap: onSeeMoreTapped,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('See More'),
                  Icon(Icons.arrow_forward_ios, size: 16.0)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
