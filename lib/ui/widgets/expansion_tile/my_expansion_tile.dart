import 'package:flutter/material.dart';
import 'package:kyw_management/ui/widgets/text_field/title_text_field.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';
import 'package:kyw_management/utils/icons.dart';

class MyExpansionTile extends StatefulWidget {
  const MyExpansionTile({
    super.key,
    this.title,
    required this.placeHolder,
    this.children = const <Widget>[],
    this.backgroundColor,
    this.borderColor,
    this.margin,
    this.icon,
    this.isWithBorder = false,
    this.showBorder = false,
    this.controller,
  });

  const MyExpansionTile.border({
    super.key,
    this.title,
    required this.placeHolder,
    this.children = const <Widget>[],
    this.backgroundColor,
    this.borderColor,
    this.margin,
    this.icon,
    this.isWithBorder = true,
    this.showBorder = true,
    this.controller,
  });

  final String? title;
  final Widget placeHolder;
  final List<Widget> children;
  final bool isWithBorder;
  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? margin;
  final Icon? icon;
  final bool showBorder;
  final ExpansionTileController? controller;

  @override
  State<MyExpansionTile> createState() => _MembersState();
}

class _MembersState extends State<MyExpansionTile> {
  bool _isExpanded = false;

  void _expansionChanged(bool value) => setState(() => _isExpanded = value);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final border = BorderSide(color: widget.borderColor ?? TColors.base150);

    return widget.isWithBorder
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /// Título
              if (widget.title != null) TitleTextField('${widget.title}'),

              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Container(
                  margin: widget.margin ?? const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    border: Border(
                        left: widget.showBorder ? BorderSide(width: 5, color: theme.primaryColor) : BorderSide.none),
                    borderRadius: BorderRadius.circular(TConstants.cardRadiusXs),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.backgroundColor ?? theme.inputDecorationTheme.fillColor,
                      border: Border(
                        top: border,
                        right: border,
                        bottom: border,
                      ),
                      borderRadius: BorderRadius.horizontal(
                        left: widget.showBorder ? Radius.zero : const Radius.circular(TConstants.cardRadiusXs),
                        right: const Radius.circular(TConstants.cardRadiusXs),
                      ),
                    ),
                    child: ExpansionTile(
                      controller: widget.controller,
                      tilePadding: const EdgeInsets.only(left: 12, right: 16),
                      visualDensity: VisualDensity.compact,
                      trailing: TrailingRotation(
                        isExpanded: _isExpanded,
                        icon: widget.icon,
                      ),
                      collapsedShape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(TConstants.cardRadiusXs)),
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(TConstants.cardRadiusXs)),
                      ),
                      onExpansionChanged: _expansionChanged,
                      title: widget.placeHolder,
                      children: widget.children,
                    ),
                  ),
                ),
              ),
            ],
          )

        /// Sem a borda
        : Container(
            margin: widget.margin ?? const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              border: Border.all(color: TColors.borderSideColor),
              borderRadius: const BorderRadius.all(Radius.circular(TConstants.cardRadiusXs)),
            ),
            child: ExpansionTile(
              visualDensity: VisualDensity.compact,
              trailing: TrailingRotation(
                isExpanded: _isExpanded,
                icon: widget.icon,
              ),
              backgroundColor: widget.backgroundColor ?? TColors.base200.withOpacity(.30),
              collapsedBackgroundColor: TColors.base200.withOpacity(.30),
              collapsedShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(TConstants.cardRadiusXs)),
              ),
              onExpansionChanged: _expansionChanged,
              title: widget.placeHolder,
              children: widget.children,
            ),
          );
  }
}

class TrailingRotation extends StatelessWidget {
  const TrailingRotation({
    super.key,
    required bool isExpanded,
    this.icon,
  }) : _isExpanded = isExpanded;

  final bool _isExpanded;
  final Widget? icon;

  @override
  Widget build(BuildContext context) => AnimatedRotation(
        turns: _isExpanded ? 0 : .5,
        duration: const Duration(milliseconds: 200),
        child: icon ??
            const Icon(
              TIcons.arrowTop,
              color: TColors.primary,
            ),
      );
}
