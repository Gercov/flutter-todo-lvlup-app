import 'package:flutter/material.dart';
import 'package:lvlup/Theme/app_colors.dart';
import 'package:lvlup/domain/entity/home_tabs_list.dart';
import 'package:provider/provider.dart';

class HomeViewModelState {
  final tabOptions = HomeTabsList.options;
  final screens = HomeTabsList.screens;
  final int selectedTab;

  HomeViewModelState({
    required this.selectedTab,
  });
}

class HomeViewModel extends ChangeNotifier {
  var _state = HomeViewModelState(selectedTab: 0);
  HomeViewModelState get state => _state;

  void onChangingTab(int index) {
    _state = HomeViewModelState(selectedTab: index);
    notifyListeners();
  }

  void onPressedAddButton(BuildContext context) async {
    Navigator.of(context).pushNamed(
      '/create',
    );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: const Scaffold(
          appBar: _AppBar(),
          body: _View(),
          bottomNavigationBar: _BottomNavigationBar(),
          floatingActionButton: _FloatingActionButton()),
    );
  }
}

class _AppBar extends StatelessWidget with PreferredSizeWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabOptions = context.read<HomeViewModel>().state.tabOptions;
    final selectedIndexTab = context.watch<HomeViewModel>().state.selectedTab;

    return AppBar(
      title: Text(tabOptions[selectedIndexTab].name),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _View extends StatelessWidget {
  const _View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<HomeViewModel>().state;

    final selectedIndexTab = context.watch<HomeViewModel>().state.selectedTab;

    return IndexedStack(
      index: selectedIndexTab,
      children: model.screens,
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedTabIndex = context.watch<HomeViewModel>().state.selectedTab;
    final tabOptions = context.read<HomeViewModel>().state.tabOptions;
    final changeTab = context.read<HomeViewModel>().onChangingTab;

    final navigationItems = <BottomNavigationBarItem>[];
    for (var item in tabOptions) {
      navigationItems.add(
        BottomNavigationBarItem(
          icon: item.icon,
          label: item.name,
        ),
      );
    }

    return BottomNavigationBar(
      currentIndex: selectedTabIndex,
      items: navigationItems,
      onTap: changeTab,
    );
  }
}

class _FloatingActionButton extends StatelessWidget {
  const _FloatingActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<HomeViewModel>();

    return FloatingActionButton(
      backgroundColor: AppColors.mainDarkBlue,
      onPressed: () => model.onPressedAddButton(context),
      child: const Icon(Icons.add),
    );
  }
}
