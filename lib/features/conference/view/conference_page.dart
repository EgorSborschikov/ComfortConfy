import 'package:comfort_confy/components/platform/platform.dart';
import 'package:flutter/material.dart';


class ConferencePage extends StatefulWidget{
  const ConferencePage({super.key,});

  @override
  State<ConferencePage> createState() => _ConferencePageState();
}

class _ConferencePageState extends State<ConferencePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PlatformAppBar(
        title: '',
        
      ), // Conference name
    );
  }
}