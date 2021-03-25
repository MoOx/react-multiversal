open Belt
open ReactNative

@react.component
let make = (
  ~style as styl=?,
  ~width: float,
  ~height: float,
  ~scrollYAnimatedValue,
  ~backgroundChild,
  ~children=?,
) => {
  let deviceHeight = Dimensions.useWindowDimensions().height
  <View
    style={
      open Style
      arrayOption([Some(style(~height=height->dp, ())), styl])
    }>
    <Animated.View
      style={
        open Style
        array([
          StyleSheet.absoluteFill,
          style(
            ~width=width->Style.dp,
            ~height=height->Style.dp,
            ~transform=[
              translateY(
                ~translateY=scrollYAnimatedValue
                ->{
                  open Animated.Interpolation
                  interpolate(
                    config(
                      ~inputRange=[-.deviceHeight +. height, 0.],
                      ~outputRange=[(-.deviceHeight +. height) /. 2., 0.]->fromFloatArray,
                      ~extrapolateRight=#clamp,
                      (),
                    ),
                  )
                }
                ->Animated.StyleProp.float,
              ),
              scale(
                ~scale=scrollYAnimatedValue
                ->{
                  open Animated.Interpolation
                  interpolate(
                    config(
                      ~inputRange=[-.deviceHeight +. height, 0.],
                      ~outputRange=[deviceHeight /. height, 1.]->fromFloatArray,
                      ~extrapolateRight=#clamp,
                      (),
                    ),
                  )
                }
                ->Animated.StyleProp.float,
              ),
            ],
            (),
          ),
        ])
      }>
      backgroundChild
    </Animated.View>
    {children->Option.getWithDefault(React.null)}
  </View>
}
