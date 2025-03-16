import 'package:comfort_confy/components/platform/platform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> androidCreateConferencion(BuildContext context) async {
  final TextEditingController controller = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      style: const TextStyle(
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CupertinoTextField(
                  controller: controller,
                  placeholder: AppLocalizations.of(context)!.conferenceName,
                  style:
                    TextStyle(
                      color: Theme.of(context).colorScheme.tertiary
                    ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.copyLink,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30), // Отступ перед кнопкой
                Center(
                  // Центрирование кнопки
                  child: CupertinoButton(
                    onPressed: () {
                      Navigator.pop(context); // Закрыть модальное окно
                      /*Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => ConferencePage(conferenceName: _controller.text),
                        ),
                      );*/
                    },
                    color: Theme.of(context).primaryColor, //const Color(0xFF5727EC),
                    child: Text(
                      AppLocalizations.of(context)!.create,
                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Отступ после кнопки
              ],
            ),
          ),
        ),
      );
    },
  );
}
