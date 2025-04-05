import 'package:clipboard/clipboard.dart';
import 'package:comfort_confy/components/common/common_text_field.dart';
import 'package:comfort_confy/components/platform/platform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:comfort_confy/services/api/create_conference.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

Future<void> androidCreateConferencion(BuildContext context) async {
  final TextEditingController controller = TextEditingController();
  bool isLoading = false;
  String? generateLink;
  String? roomId;

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          Future<void> createConference() async{
            if(controller.text.isEmpty){
              Fluttertoast.showToast(
                msg:AppLocalizations.of(context)!.conferenceName,
                backgroundColor: Colors.red,
              );
              return;
            }
            setState(() => isLoading = true);

            /*try {
              final response = await createConference(controller.text);
              
              await Future.delayed(Duration(seconds: 1));
              /*if (response.statusCode == 400) {
                throw Exception('Достигнут лимит активных конференций');
              } else if (response.statusCode >= 500) {
                throw Exception('Серверная ошибка');
              }*/

              setState(() {
                generateLink = response.link;
                roomId = response.room_id;
                isLoading = false;
                /*if (isLoading) {
                  return PlatformProgressIndicator();
                }*/
              });

            } on http.ClientException catch (e) {
              setState(() => isLoading = false);
              Fluttertoast.showToast(
                msg: 'Network error: ${e.message}',
                backgroundColor: Colors.red,
              );
            } on Exception catch (e) {
              setState(() => isLoading = false);
              Fluttertoast.showToast(
                msg: e.toString(),
                backgroundColor: Colors.red,
              );
            }*/
          }

          void copyToClipboard() {
            if(generateLink != null){
              FlutterClipboard.copy(generateLink!).then((_) {
                Fluttertoast.showToast(
                  msg: AppLocalizations.of(context)!.copyLink,
                  backgroundColor: Colors.green,
                );
              });
            }
          }

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
                          onPressed: () => Navigator.pop(context),
                        ),
                        Text(
                          AppLocalizations.of(context)!.createANewConference,
                          style: const TextStyle(
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 48), // Для выравнивания
                      ],
                    ),
                    const SizedBox(height: 20),
                    CommonTextField(
                      controller: controller,
                      prefix: AppLocalizations.of(context)!.conferenceName,
                      isObscure: false,
                    ),
                    if (generateLink != null) ...[
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: copyToClipboard,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                generateLink!,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(
                              Icons.copy,
                              size: 16,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 30),
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: CupertinoButton(
                          onPressed: isLoading ? null : () async {
                            if (generateLink == null) {
                              await createConference();
                            } else {
                              // Перенаправление в конференцию
                              /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ConferenceRoomPage(
                                    roomId: roomId!,
                                    conferenceName: controller.text,
                                  ),
                                ),
                              );*/
                            }
                          },
                          color: Theme.of(context).primaryColor,
                          disabledColor: Colors.grey,
                          child: isLoading
                              ? const CupertinoActivityIndicator()
                              : Text(
                                  generateLink == null
                                      ? AppLocalizations.of(context)!.create
                                      : AppLocalizations.of(context)!.confirm,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}