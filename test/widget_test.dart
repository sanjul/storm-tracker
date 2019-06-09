import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stormtr/ui/config/Config.dart';
import 'package:stormtr/ui/navigation/app_navigator_view.dart';


void main() {
  testWidgets('Home View Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    AppNavigatorView navigatorView = AppNavigatorView(Config.navigatables);
    await tester.pumpWidget(buildTestableWidget(navigatorView));
    
    // Verify the tab icons
    var homeIcon = find.byIcon(Icons.home);
    var timelineIcon = find.byIcon(Icons.view_list);
    expect(homeIcon, findsOneWidget);
    expect(timelineIcon, findsOneWidget);

    // expect(find.byIcon(Icons.add),findsOneWidget);
    // expect(HomeView(), findsOneWidget);

    // // Verify that our counter starts at 0.
    // expect(find.text('0'), findsOneWidget);
    // expect(find.text('1'), findsNothing);

    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();

    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}

 Widget buildTestableWidget(Widget widget) {
   return MediaQuery(data: MediaQueryData(), child: MaterialApp(home: widget));
 }