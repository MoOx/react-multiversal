open Belt;
open ReactNative;

[@react.component]
let make =
    (
      ~style as styl=?,
      ~width: float,
      ~height: float,
      ~scrollYAnimatedValue,
      ~backgroundChild,
      ~children=?,
    ) => {
  let deviceHeight = Dimensions.get(`window)##height;
  <View
    style=Style.(arrayOption([|Some(style(~height=height->dp, ())), styl|]))>
    <Animated.View
      style=Style.(
        array([|
          StyleSheet.absoluteFill,
          style(
            ~width=width->Style.dp,
            ~height=height->Style.dp,
            ~transform=[|
              translateY(
                ~translateY=
                  scrollYAnimatedValue
                  ->Animated.Interpolation.(
                      interpolate(
                        config(
                          ~inputRange=[|-. deviceHeight +. height, 0.|],
                          ~outputRange=
                            [|(-. deviceHeight +. height) /. 2., 0.|]
                            ->fromFloatArray,
                          ~extrapolateRight=`clamp,
                          (),
                        ),
                      )
                    )
                  ->Animated.StyleProp.float,
              ),
              scale(
                ~scale=
                  scrollYAnimatedValue
                  ->Animated.Interpolation.(
                      interpolate(
                        config(
                          ~inputRange=[|-. deviceHeight +. height, 0.|],
                          ~outputRange=
                            [|deviceHeight /. height, 1.|]->fromFloatArray,
                          ~extrapolateRight=`clamp,
                          (),
                        ),
                      )
                    )
                  ->Animated.StyleProp.float,
              ),
            |],
            (),
          ),
        |])
      )>
      backgroundChild
    </Animated.View>
    {children->Option.getWithDefault(React.null)}
  </View>;
};
