import 'package:flutter/material.dart';

class ExpandableTile extends StatefulWidget {
  final Widget header;
  final Widget body;

  const ExpandableTile({
    super.key,
    required this.header,
    required this.body,
  });

  @override
  State<ExpandableTile> createState() => _ExpandableTileState();
}

class _ExpandableTileState extends State<ExpandableTile> {
  late bool isExpanded;
  @override
  void initState() {
    isExpanded = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(children: [
          GestureDetector(
            onTap: _showBody,
            child: _ExpandableHeader(
              content: widget.header,
            ),
          ),
          AnimatedContainer(
              curve: Curves.easeInOutQuart,
              height: isExpanded ? 300 : 0,
              duration: Duration(milliseconds: 250),
              child: isExpanded
                  ? _ExpandableBody(
                      content: widget.body,
                    )
                  : Container())
        ]),
      ),
    );
  }

  void _showBody() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }
}

class _ExpandableHeader extends StatelessWidget {
  final Widget content;
  const _ExpandableHeader({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return content;
  }
}

class _ExpandableBody extends StatelessWidget {
  final Widget content;
  const _ExpandableBody({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return content;
  }
}
