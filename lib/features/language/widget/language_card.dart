import 'package:cached_network_image/cached_network_image.dart';
import 'package:flaapp/features/language/bloc/language_bloc.dart';
import 'package:flaapp/model/language.dart';
import 'package:flaapp/utils/constant/theme/colors.dart';
import 'package:flaapp/widgets/primary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCard extends StatelessWidget {
  const LanguageCard({
    super.key,
    required this.language,
    required this.state,
  });

  final LanguageModel language;
  final LanguageState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: PrimaryCard(
        backgroundColor: state.selectedLanguage.language == language.language
            ? ColorTheme.tBlueColor.withValues(alpha: 0.8)
            : ColorTheme.tWhiteColor,
        onTap: () => context
            .read<LanguageBloc>()
            .add(LanguageSelected(language: language)),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: language.flag ?? "",
              width: 48.0,
              height: 48.0,
              placeholder: (context, url) => const SizedBox(),
              errorWidget: (context, url, error) => const SizedBox(),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                language.language ?? "",
                style: theme.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: state.selectedLanguage.language == language.language
                      ? ColorTheme.tWhiteColor
                      : ColorTheme.tBlackColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
