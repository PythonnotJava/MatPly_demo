import 'package:flutter/cupertino.dart' show ConnectionState;
import 'package:flutter/material.dart' show
  AsyncSnapshot,
  BuildContext,
  Center,
  CircularProgressIndicator,
  Expanded,
  FutureBuilder,
  StatelessWidget,
  Text,
  Widget
;
import 'package:flutter/services.dart' show rootBundle;
import 'package:markdown_widget/markdown_widget.dart' show MarkdownWidget;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: rootBundle.loadString('assets/README.md'),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(child: Text('Failed to load Markdown'));
            } else {
              return buildMarkdown(snapshot.data!);
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildMarkdown(String data) => MarkdownWidget(data: data);
}