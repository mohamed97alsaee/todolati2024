import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todolati2024/models/task_model.dart';
import 'package:todolati2024/providers/dark_mode_provider.dart';
import 'package:todolati2024/providers/localization_provider.dart';
import 'package:todolati2024/providers/tasks_provider.dart';
import 'package:todolati2024/widgets/clickables/drawer_tile.dart';
import 'package:todolati2024/widgets/dialogs/add_task_dialog.dart';
import 'package:todolati2024/widgets/cards/task_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskSubtitleController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeProvider>(builder: (context, darkModeConsumer, _) {
      return Consumer<TasksProvider>(builder: (context, tasksConsumer, _) {
        return Scaffold(
            drawer: Drawer(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      DrawerTile(
                          text: darkModeConsumer.isDark
                              ? AppLocalizations.of(context)!.lightmode
                              : AppLocalizations.of(context)!.darkmode,
                          onTab: () {
                            Provider.of<DarkModeProvider>(context,
                                    listen: false)
                                .switchMode();
                          },
                          icon: darkModeConsumer.isDark
                              ? Icons.light_mode
                              : Icons.dark_mode),
                      DrawerTile(
                          text: AppLocalizations.of(context)!.arabic,
                          onTab: () {
                            Provider.of<LocalizationProvider>(context,
                                    listen: false)
                                .storeLanguage("ar");
                          },
                          icon: Icons.language),
                      DrawerTile(
                          text: AppLocalizations.of(context)!.english,
                          onTab: () {
                            Provider.of<LocalizationProvider>(context,
                                    listen: false)
                                .storeLanguage("en");
                          },
                          icon: Icons.language),
                      DrawerTile(
                          text: AppLocalizations.of(context)!.spanish,
                          onTab: () {
                            Provider.of<LocalizationProvider>(context,
                                    listen: false)
                                .storeLanguage("es");
                          },
                          icon: Icons.language),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AddTaskDialog(
                            titleController: taskTitleController,
                            subTitleController: taskSubtitleController,
                            onTap: () {
                              Provider.of<TasksProvider>(context, listen: false)
                                  .addTask(TaskModel(
                                      title: taskTitleController.text,
                                      subTitle:
                                          taskSubtitleController.text.isEmpty
                                              ? null
                                              : taskSubtitleController.text,
                                      createdAt:
                                          DateTime.now().toIso8601String()));
                              taskTitleController.clear();
                              taskSubtitleController.clear();
                              Navigator.pop(context);
                            });
                      });
                }),
            appBar: AppBar(
              title: const Text("TASKY"),
            ),
            body: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                      labelStyle: GoogleFonts.cairo(),
                      isScrollable: false,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.blue,
                      tabs: [
                        Tab(
                          text: AppLocalizations.of(context)!.waiting,
                        ),
                        Tab(
                          text: AppLocalizations.of(context)!.completed,
                        )
                      ]),
                  Expanded(
                    child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          ListView.builder(
                            padding: const EdgeInsets.all(24),
                            itemCount: tasksConsumer.tasks.length,
                            itemBuilder: (context, index) {
                              return tasksConsumer.tasks[index].isCompleted
                                  ? const SizedBox()
                                  : TaskCard(
                                      taskModel: tasksConsumer.tasks[index],
                                      onTap: () {
                                        Provider.of<TasksProvider>(context,
                                                listen: false)
                                            .switchValue(
                                                tasksConsumer.tasks[index]);
                                      });
                            },
                          ),
                          ListView.builder(
                            padding: const EdgeInsets.all(24),
                            itemCount: tasksConsumer.tasks.length,
                            itemBuilder: (context, index) {
                              return !tasksConsumer.tasks[index].isCompleted
                                  ? const SizedBox()
                                  : TaskCard(
                                      taskModel: tasksConsumer.tasks[index],
                                      onTap: () {
                                        Provider.of<TasksProvider>(context,
                                                listen: false)
                                            .switchValue(
                                                tasksConsumer.tasks[index]);
                                      });
                            },
                          ),
                        ]),
                  )
                ],
              ),
            ));
      });
    });
  }
}
