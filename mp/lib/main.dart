import 'package:flutter/material.dart';
import 'pages/home.dart' show HomePage;
import 'pages/distribution.dart' show GraphSelector;
import 'pages/geometry.dart' show GeometryView;
import 'pages/MtViewer.dart' show Mtviewer;
import 'pages/mtoperator.dart' show MtOpBoard;

enum MenuItem {
  home,
  dis,
  geo,
  mtdoc,
  mtopt
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu Navigation Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 400,
          minHeight: 600,
        ),
        child: const CorePage(),
      )
      ,
    );
  }
}

class CorePage extends StatefulWidget {
  const CorePage({super.key});

  @override
  CorePageState createState() => CorePageState();
}

class CorePageState extends State<CorePage> {
  // 当前选中的菜单项
  MenuItem _selectedMenu = MenuItem.home;

  // 根据菜单项返回对应的页面
  Widget _getPage(MenuItem menu) {
    switch (menu) {
      case MenuItem.home:
        return const HomePage();
      case MenuItem.dis:
        return const GraphSelector();
      case MenuItem.geo:
        return const GeometryView();
      case MenuItem.mtdoc:
        return const Mtviewer();
      case MenuItem.mtopt:
        return MtOpBoard();
      default:
        return const HomePage();
    }
  }

  // 菜单项的标题
  String _getMenuTitle(MenuItem menu) {
    switch (menu) {
      case MenuItem.home:
        return '主页';
      case MenuItem.dis:
        return '概率分布';
      case MenuItem.geo:
        return '几何模拟';
      case MenuItem.mtdoc:
        return '核心文档';
      case MenuItem.mtopt:
        return '案例';
      default:
        return '主页';
    }
  }

  // 菜单项的图标
  IconData _getMenuIcon(MenuItem menu) {
    switch (menu) {
      case MenuItem.home:
        return Icons.home;
      case MenuItem.dis:
        return Icons.person;
      case MenuItem.geo:
        return Icons.settings;
      case MenuItem.mtdoc:
        return Icons.document_scanner;
      case MenuItem.mtopt:
        return Icons.temple_buddhist_outlined;
      default:
        return Icons.home;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MatrixType Demo'),
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: MenuItem.values.indexOf(_selectedMenu),
            onDestinationSelected: (int index) {
              setState(() {
                _selectedMenu = MenuItem.values[index];
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: MenuItem.values.map((menu) {
              return NavigationRailDestination(
                icon: Icon(_getMenuIcon(menu)),
                selectedIcon: Icon(_getMenuIcon(menu), color: Colors.deepPurple),
                label: Text(_getMenuTitle(menu)),
              );
            }).toList(),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _getPage(_selectedMenu),
            ),
          ),
        ],
      ),
    );
  }
}
