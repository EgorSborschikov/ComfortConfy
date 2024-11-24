import 'package:comfort_confy/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

late final TextEditingController controller;

Future<void> createConferencion(BuildContext context) async {
  showModalBottomSheet(
    context: context, 
    builder: (BuildContext context){
      return Container(
        padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    AppLocalizations.of(context)!.createANewConference,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              CupertinoTextField(
                prefix: Text(
                  AppLocalizations.of(context)!.conferenceName,
                ),
                placeholder: AppLocalizations.of(context)!.conferenceName,
                controller: controller,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.timeStart,
                  ),
                  /*CupertinoPicker(
                    itemExtent: itemExtent, 
                    onSelectedItemChanged: onSelectedItemChanged, 
                    children: children
                  ),*/
                ]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.addUsersToTheConference,
                  ),
                  IconButton(
                    icon: const Icon(CupertinoIcons.add_circled, size: 30),
                    color: Color(0xFF5727EC),
                    onPressed: () {
                      
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.copyLink,
                  ),
                ],
              ),
            ],
          ),
      );
    }
  );
}