import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pit_components/pit_components.dart';
import 'package:nemob_cs_helper/utilities/localization.dart';

abstract class View<T extends StatefulWidget> extends State<T> {
  bool _firstRun = true;
  CsHelperDict _dict;
  bool _withLoading = true;
  LoadingController controller = LoadingController();

  CsHelperDict get dict => _dict;

  @override
  Widget build(BuildContext context) {
    if (_firstRun) {
      initStateWithContext(context);
      _firstRun = false;
    }

    return buildView(context);
  }

  void initStateWithContext(BuildContext context) {
    _dict = CsHelperDict.of(context);
  }

  Widget buildView(BuildContext context);

  void refresh() {
    if (this.mounted) setState(() {});
  }

  Future<dynamic> process(Function f) async {
    OverlayEntry x = _withLoading ? _showLoading() : null;

    var result = await f();

    if (controller.refresh != null) await controller.refresh();

    x?.remove();

    return result;
  }

  OverlayEntry _showLoading() {
    OverlayEntry toastOverlay = _createLoadingOverlay();

    OverlayState overlay = Overlay.of(context);

    if (overlay == null) return null;
    overlay.insert(toastOverlay);

    return toastOverlay;
  }

  OverlayEntry _createLoadingOverlay() {
    return OverlayEntry(
      builder: (context) => FullLoading(
            true,
            PitComponents.loadingBarrierColor,
            PitComponents.loadingWidth,
            PitComponents.loadingHeight,
            controller,
          ),
    );
  }
}

typedef Future<void> RefreshLoading();

class LoadingController {
  RefreshLoading refresh;
}

class FullLoading extends StatefulWidget {
  final bool visible;
  final Color barrierColor;
  final double width;
  final double height;
  final LoadingController controller;

  FullLoading(this.visible, this.barrierColor, this.width, this.height, this.controller);

  @override
  State<StatefulWidget> createState() => FullLoadingState();
}

class FullLoadingState extends State<FullLoading> with TickerProviderStateMixin {
  AnimationController opacityController;

  @override
  void initState() {
    super.initState();
    if (!this.mounted) return;

    widget.controller.refresh = () async {
      await opacityController.reverse(from: 1.0);
    };

    opacityController = AnimationController(duration: Duration(milliseconds: 200), vsync: this);

    opacityController.addListener(() {
      if (this.mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    opacityController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!opacityController.isAnimating) {
        if (widget.visible && opacityController.value == 0.0) opacityController.forward(from: 0.0);
      }
    });

    return Visibility(
      visible: opacityController.value > 0.0,
      child: Positioned.fill(
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
              child: Opacity(
                  opacity: opacityController.value,
                  child: Container(
                      color: widget.barrierColor,
                      child: Center(
                          child: Image.asset(
                        PitComponents.loadingAssetName,
                        height: widget.height,
                        width: widget.width,
                      )))))),
    );
  }
}
