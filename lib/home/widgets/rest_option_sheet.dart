import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/models/rest_option.dart';
import '../cubit/home_cubit.dart';

class RestOptionSheet extends StatelessWidget {
  const RestOptionSheet({super.key});

  static Future<RestOption> show(BuildContext context) async {
    return await showModalBottomSheet<RestOption>(
          context: context,
          isScrollControlled: true,
          builder: (_) => const RestOptionSheet(),
        ) ??
        RestOption.cancel;
  }

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(25, 25, 25, 16),
      child: Wrap(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _MessageText(),
              SizedBox(height: 5),
              _OptionsRow(),
            ],
          ),
        ],
      ),
    );
  }
}

class _MessageText extends StatelessWidget {
  const _MessageText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: context.read<HomeCubit>(),
      builder: (_, state) => RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: Colors.grey.shade900,
                fontSize: 18,
                height: 1.5,
                fontWeight: FontWeight.w300,
              ),
          children: [
            const TextSpan(text: 'Do you want to take a '),
            // ignore: lines_longer_than_80_chars
            TextSpan(
              text:
                  'break for ${state.breakDuration.inMinutes} minute${state.breakDuration.inMinutes > 1 ? 's' : ''} ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const TextSpan(text: 'or '),
            const TextSpan(
              text: 'end this session?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionsRow extends StatelessWidget {
  const _OptionsRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _TakeBreakButton(),
        _OrText(),
        _EndSessionButton(),
      ],
    );
  }
}

class _TakeBreakButton extends StatelessWidget {
  const _TakeBreakButton();

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        // stop normal timer - start break countdown timer
        Navigator.pop(context, RestOption.takeBreak);
      },
      child: Icon(
        RestOption.takeBreak.icon,
        color: Colors.grey.shade900,
        size: 36,
      ),
    );
  }
}

class _OrText extends StatelessWidget {
  const _OrText();

  @override
  Widget build(BuildContext context) {
    return Text(
      '— OR —',
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: Colors.grey.shade900,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

class _EndSessionButton extends StatelessWidget {
  const _EndSessionButton();

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        // stop normal timer
        Navigator.pop(context, RestOption.endSession);
      },
      child: Icon(
        RestOption.endSession.icon,
        color: Colors.grey.shade900,
        size: 36,
      ),
    );
  }
}
