import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../models/UnitModel/unitsubject._model.dart';

class SlidingUpPanelHomePageWidget extends StatefulWidget {
  const SlidingUpPanelHomePageWidget(
      {super.key,
      required this.unitBookSubject,
      required this.panelOrderPanelController,
      required this.slidgpanel});
  final UnitSubject unitBookSubject;
  final PanelController panelOrderPanelController;
  final List<Widget> slidgpanel;

  @override
  State<SlidingUpPanelHomePageWidget> createState() =>
      _SlidingUpPanelHomePageWidgetState();
}

late bool isOpenOrderPanel;

class _SlidingUpPanelHomePageWidgetState
    extends State<SlidingUpPanelHomePageWidget> {
  @override
  void initState() {
    super.initState();
    isOpenOrderPanel = false;
  }

  @override
  Widget build(BuildContext context) {
    Size screenMediaQuerySldgUpPOPrs = MediaQuery.of(context).size;

    return SlidingUpPanel(
        isDraggable: false,
        onPanelOpened: () {
          setState(() {
            isOpenOrderPanel = true;
          });
        },
        onPanelClosed: () {
          setState(() {
            isOpenOrderPanel = false;
          });
        },
         
        controller: widget.panelOrderPanelController,
        maxHeight: MediaQuery.of(context).size.height,
        minHeight: (screenMediaQuerySldgUpPOPrs.height > 600)
            ? MediaQuery.of(context).size.height * 0.06
            : screenMediaQuerySldgUpPOPrs.height * 0.07,
        header: Container(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.01),
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).primaryColor,
          child: Row(
            children: [
              (widget.panelOrderPanelController.isAttached)
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          (widget.panelOrderPanelController.isAttached &&
                                  widget
                                      .panelOrderPanelController.isPanelClosed)
                              ? widget.unitBookSubject.titleSubject
                              : widget.unitBookSubject.titleSubject,
                          textAlign: TextAlign.center),
                    )
                  : Text(widget.unitBookSubject.titleSubject),
              (!isOpenOrderPanel)
                  ? TextButton.icon(
                      onPressed: () {
                        widget.panelOrderPanelController.open();
                      },
                      icon: Icon(
                        Icons.circle_notifications,
                        color: Theme.of(context).cardColor,
                      ),
                      label: Text(""))
                  : TextButton.icon(
                      onPressed: () {
                        widget.panelOrderPanelController.close();
                      },
                      icon: Icon(
                        Icons.circle,
                        color: Theme.of(context).cardColor,
                      ),
                      label: Text(""))
            ],
          ),
        ),
        panel: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.03,
            ),
            child: CustomScrollView(slivers: [
              SliverList(delegate: SliverChildListDelegate(widget.slidgpanel)),
            ])));
  }
}
