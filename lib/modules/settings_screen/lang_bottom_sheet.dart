import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../app_config_provider/app_config_provider.dart';
import '../../core/themes/colors.dart';


class LangBottomSheet extends StatefulWidget {
  const LangBottomSheet({super.key});

  @override
  State<LangBottomSheet> createState() => _LangBottomSheetState();
}

class _LangBottomSheetState extends State<LangBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //en
          InkWell(
            onTap: () {
              provider.changeLang('en');
              Navigator.of(context).pop();

            },
            child: provider.applang == 'en'
                ? getSelcted("${AppLocalizations.of(context)?.english}")
                : getunSelcted("${AppLocalizations.of(context)?.english}"),
          ),
          const Divider(
            height: 30,
          ),
          //ar
          InkWell(
            onTap: () {
              provider.changeLang('ar');
              Navigator.of(context).pop();
            },
            child: provider.applang == 'ar'
                ? getSelcted("${AppLocalizations.of(context)?.arabic}")
                : getunSelcted("${AppLocalizations.of(context)?.arabic}"),
          ),
        ],
      ),
    );
  }

  Widget getSelcted(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontFamily: "Poppins",
            fontSize: 19,
            fontWeight: FontWeight.w300,
            color: AppColors.primaryLight,
          ),
        ),
        const Icon(
          Icons.check,
          color: AppColors.primaryLight,
        ),
      ],
    );
  }

  Widget getunSelcted(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontFamily: "Poppins",
              fontSize: 19,
              fontWeight: FontWeight.w300,
              color: AppColors.black),
        ),
      ],
    );
  }
}
