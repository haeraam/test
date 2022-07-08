import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const TestApp());

class TestApp extends StatelessWidget {
  const TestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _pages = const [Page1(), Page2(), Page3(), Page3()];
  final _navigatorKeyList =
      List.generate(4, (index) => GlobalKey<NavigatorState>());
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !(await _navigatorKeyList[_currentIndex]
            .currentState!
            .maybePop());
      },
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: TabBarView(
            children: _pages.map(
              (page) {
                int index = _pages.indexOf(page);
                return CustomNavigator(
                  page: page,
                  navigatorKey: _navigatorKeyList[index],
                );
              },
            ).toList(),
          ),
          bottomNavigationBar: Container(
            color: Colors.white,
            child: TabBar(
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              overlayColor: MaterialStateProperty.all(Colors.black87),
              isScrollable: false,
              indicatorPadding: const EdgeInsets.only(bottom: 74),
              automaticIndicatorColorAdjustment: true,
              unselectedLabelColor: Colors.grey,
              onTap: (index) => setState(() {
                _currentIndex = index;
              }),
              tabs:  const [
                Tab(
                  icon: Icon(
                    Icons.home,
                  ),
                  text: '홈',
                ),
                Tab(
                  icon: Icon(
                    Icons.calendar_today,
                  ),
                  text: '몸풀기',
                ),
                Tab(
                  icon: Icon(
                    Icons.email,
                  ),
                  text: '마음풀기',
                ),
                Tab(
                  icon: Icon(
                    Icons.eco,
                  ),
                  text: '나의텃밭',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 1'),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 2)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                child: TextButton(
                child: const Text('Next page'),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Page4()));
                },
              ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 2'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Page 2'),
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 3'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Page 3'),
      ),
    );
  }
}

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page4'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 2)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const Text('Page4');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class CustomNavigator extends StatefulWidget {
  final Widget page;
  final Key navigatorKey;
  const CustomNavigator(
      {Key? key, required this.page, required this.navigatorKey})
      : super(key: key);

  @override
  _CustomNavigatorState createState() => _CustomNavigatorState();
}

class _CustomNavigatorState extends State<CustomNavigator>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: (_) =>
          MaterialPageRoute(builder: (context) => widget.page),
    );
  }
}
