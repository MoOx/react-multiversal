open ReactNative;

let make = (~scrollYAnimatedValue, ~children) => {
  <Animated.View
    style=Style.(
      style(
        ~zIndex=1,
        ~transform=[|
          translateY(
            ~translateY=
              Animated.Interpolation.(
                scrollYAnimatedValue->interpolate(
                  config(
                    ~inputRange=[|0., 1.|],
                    ~outputRange=[|0., 1.|]->fromFloatArray,
                    ~extrapolateLeft=`clamp,
                    ~extrapolate=`identity,
                    ~extrapolateRight=`identity,
                    (),
                  ),
                )
              )
              ->Animated.StyleProp.float,
          ),
        |],
        (),
      )
    )>
    ...children
  </Animated.View>;
};
