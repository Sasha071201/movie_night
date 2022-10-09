import 'package:flutter/material.dart';

import 'package:movie_night/application/resources/resources.dart';
import 'package:movie_night/application/ui/screens/about_me/about_me_view_model.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/themes/app_text_style.dart';
import 'package:movie_night/application/ui/widgets/elevated_button_widget.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../widgets/text_field_widget.dart';

class AboutMeScreen extends StatefulWidget {
  const AboutMeScreen({Key? key}) : super(key: key);

  @override
  State<AboutMeScreen> createState() => _AboutMeScreenState();
}

class _AboutMeScreenState extends State<AboutMeScreen> {
  @override
  void didChangeDependencies() {
    context.read<AboutMeViewModel>().setupLocale(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.colorPrimary,
          leading: const BackButton(color: AppColors.colorSecondary),
          title: Text(
            S.of(context).about_me,
            style: AppTextStyle.header3,
          ),
        ),
        body: const _BodyWidget(),
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: const [
                SizedBox(height: 16),
                _AvatarImageWidget(),
                SizedBox(height: 16),
                _NameTextFieldWidget(),
                Spacer(),
                SizedBox(height: 16),
                _SaveButtonWidget(),
                _BottomSizedBoxWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SaveButtonWidget extends StatelessWidget {
  const _SaveButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<AboutMeViewModel>();
    final isLoadingSave = context.select((AboutMeViewModel vm) => vm.isLoadingSave);
    return ElevatedButtonWidget(
      child: !isLoadingSave
          ? Text(
              S.of(context).save,
              style: AppTextStyle.button.copyWith(
                color: AppColors.colorPrimary,
              ),
            )
          : const RepaintBoundary(
              child: CircularProgressIndicator(
                color: AppColors.colorPrimary,
              ),
            ),
      onPressed: !isLoadingSave ? vm.save : null,
      backgroundColor: AppColors.colorSecondary,
      overlayColor: AppColors.colorSplash,
    );
  }
}

class _BottomSizedBoxWidget extends StatelessWidget {
  const _BottomSizedBoxWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final insetsBottom = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(height: insetsBottom == 0 ? 32 : insetsBottom + 16);
  }
}

class _NameTextFieldWidget extends StatelessWidget {
  const _NameTextFieldWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<AboutMeViewModel>();
    final isLoadingSave = context.select((AboutMeViewModel vm) => vm.isLoadingSave);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).name, style: AppTextStyle.header3),
        const SizedBox(height: 8),
        TextFieldWidget(
          controller: vm.nameController,
          onSubmitted: !isLoadingSave ? (text) => vm.save() : null,
          hintText: S.of(context).enter_your_name,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          enableSuggestions: true,
          maxLines: 1,
        ),
      ],
    );
  }
}

class _AvatarImageWidget extends StatelessWidget {
  const _AvatarImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<AboutMeViewModel>();
    return ClipRRect(
      borderRadius: BorderRadius.circular(90),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const _ImageWidget(),
          Positioned(
            bottom: 0,
            child: Container(
              color: AppColors.colorSecondaryText,
              width: 130,
              height: 30,
              child: Center(
                  child: Text(
                S.of(context).change,
                style: AppTextStyle.button,
              )),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                highlightColor: Colors.transparent,
                overlayColor: MaterialStateProperty.all(AppColors.colorSplash),
                onTap: vm.pickFile,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageWidget extends StatelessWidget {
  const _ImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final url = context.select((AboutMeViewModel vm) => vm.profileImageUrl);
    final file = context.select((AboutMeViewModel vm) => vm.profileImageFile);
    final image = file != null
        ? Image.file(
            file,
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          )
        : url.isNotEmpty
            ? Image.network(
                url,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              )
            : Image.asset(
                AppImages.placeholder,
                width: 150,
                height: 150,
                color: AppColors.colorMainText,
                fit: BoxFit.cover,
              );
    return ClipRRect(
      borderRadius: BorderRadius.circular(90),
      child: image,
    );
  }
}
