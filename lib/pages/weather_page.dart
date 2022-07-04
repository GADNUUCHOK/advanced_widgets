import 'package:flutter/material.dart';
import 'package:weather_application/images/weather_picture.dart';
import 'package:weather_application/widgets/inner_shadow_text.dart';
import 'package:weather_application/widgets/text_style_theme.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 2));
  late Animation _animation;

  double _opacity = 0.0;
  Color _textColor = Colors.blue;
  Color _background = Colors.white;
  Color _appBar = Colors.blue;
  double _fontSize = 30;

  @override
  void initState() {
    super.initState();
    _animation = Tween(begin: 1.0, end: 3.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextStyleTheme(
        theme: TextThemeMy(
            background: _background,
            appBar: _appBar,
            textColor: _textColor,
            fontSizeDescriptionWeather: _fontSize),
        child: Builder(
          builder: (innerContext) {
            return Scaffold(
              backgroundColor: TextStyleTheme.of(innerContext).background,
              appBar: AppBar(
                backgroundColor: TextStyleTheme.of(innerContext).appBar,
              ),
              body: Column(
                children: [
                  Center(
                      child: SizedBox(
                    height: MediaQuery.of(context).size.height - 250,
                    width: MediaQuery.of(context).size.width,
                    child: GestureDetector(
                      onTap: () {
                        if (!_controller.isCompleted) {
                          _controller.forward();
                        } else {
                          _controller.reverse();
                        }
                      },
                      child: Transform(
                        alignment: FractionalOffset.center,
                        transform: Matrix4.diagonal3Values(_animation.value,
                            _animation.value, _animation.value),
                        child: CustomPaint(
                          painter: SunCloudRain(_opacity),
                        ),
                      ),
                    ),
                  )),
                  _controller.isCompleted
                      ? InnerShadow(
                          child: Text(
                            'Солнечно 12 градусов',
                            style: TextStyle(
                                fontSize: TextStyleTheme.of(innerContext)
                                    .fontSizeDescriptionWeather),
                          ),
                          color: TextStyleTheme.of(innerContext).textColor,
                          blur: 10,
                          offset: const Offset(5, 5),
                        )
                      : const SizedBox(),
                  Slider(
                    activeColor: TextStyleTheme.of(innerContext).appBar,
                    value: _opacity,
                    onChanged: (opacity) {
                      setState(
                        () {
                          _opacity = opacity;
                        },
                      );
                    },
                    min: 0.0,
                    max: 1.0,
                  )
                ],
              ),
              floatingActionButton: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FloatingActionButton(
                      backgroundColor: TextStyleTheme.of(innerContext).appBar,
                      child: const Icon(Icons.wb_sunny_outlined),
                      onPressed: () {
                        setState(() {
                          _textColor = Colors.blue;
                          _background = Colors.white;
                          _appBar = Colors.blue;
                          _fontSize = 30;
                        });
                      }),
                  const SizedBox(
                    width: 10,
                  ),
                  FloatingActionButton(
                      backgroundColor: TextStyleTheme.of(innerContext).appBar,
                      child: const Icon(Icons.nightlight_outlined),
                      onPressed: () {
                        setState(() {
                          _textColor = Colors.yellow;
                          _background = Colors.grey;
                          _appBar = Colors.red;
                          _fontSize = 30;
                        });
                      }),
                ],
              ),
            );
          },
        ));
  }
}
