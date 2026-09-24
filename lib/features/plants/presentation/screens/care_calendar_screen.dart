import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plantpal/core/widgets/gradient_background.dart';
import 'package:plantpal/features/plants/presentation/widgets/maintenance_alarm_card.dart';
import 'package:plantpal/features/plants/presentation/widgets/maintenance_bottom_bar.dart';
import 'package:plantpal/features/plants/presentation/widgets/maintenance_header.dart';
import 'package:plantpal/features/plants/presentation/widgets/maintenance_intake_form.dart';
import 'package:plantpal/features/plants/presentation/widgets/maintenance_journal_section.dart';
import 'package:plantpal/features/plants/presentation/widgets/maintenance_tips_section.dart';
import 'package:plantpal/features/plants/presentation/widgets/maintenance_todo_list.dart';

/// Maintenance screen (route: /care-calendar), redesigned as a single
/// scrollable page: plant intake form -> to-do + alarm -> tips + journal.
/// The progress bar tracks scroll position through the sections.
class CareCalendarScreen extends StatefulWidget {
  const CareCalendarScreen({super.key});

  @override
  State<CareCalendarScreen> createState() => _CareCalendarScreenState();
}

class _CareCalendarScreenState extends State<CareCalendarScreen> {
  final _scrollController = ScrollController();
  final _todoKey = GlobalKey();

  double _progress = 0;
  String? _category;
  String _plantName = '';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final max = _scrollController.position.maxScrollExtent;
    final next = max == 0 ? 0.0 : (_scrollController.offset / max).clamp(0.0, 1.0);
    if (next != _progress) setState(() => _progress = next);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onRoadmapCreated(String name, String type) {
    setState(() {
      _plantName = name;
      _category = type.isEmpty ? 'House Plant' : type;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _todoKey.currentContext;
      if (ctx != null) {
        Scrollable.ensureVisible(ctx, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              MaintenanceHeader(
                category: _category,
                progress: _progress,
                onLogBook: () => context.push('/plants'),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 96),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      MaintenanceIntakeForm(onSubmit: _onRoadmapCreated),
                      const SizedBox(height: 28),
                      MaintenanceTodoList(sectionKey: _todoKey),
                      const SizedBox(height: 20),
                      const SetAlarmCard(),
                      const SizedBox(height: 28),
                      MaintenanceTipsSection(plantName: _plantName),
                      const SizedBox(height: 24),
                      const MaintenanceJournalSection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MaintenanceBottomBar(
        onAddPlant: () => context.push('/plants/add'),
        onBack: () => context.canPop() ? context.pop() : context.go('/home'),
      ),
    );
  }
}