open Belt
open ReactNative

let size = 44. *. 1.2
let scrollOffsetYGap = 10.
let styles = {
  open Style
  {
    "wrapper": viewStyle(
      ~zIndex=100,
      ~position=#absolute,
      ~top=0.->dp,
      ~left=0.->dp,
      ~right=0.->dp,
      ~height=size->dp,
      ~justifyContent=#center,
      ~alignItems=#center,
      (),
    ),
    "textWrapper": viewStyle(
      ~justifyContent=#center,
      ~alignItems=#center,
      ~width=100.->pct,
      ~height=100.->pct,
      (),
    ),
    "text": textStyle(
      ~textAlign=#center,
      ~width=50.->pct,
      ~fontSize=18.,
      ~fontWeight=FontWeight._600,
      (),
    ),
    "left": viewStyle(
      ~position=#absolute,
      ~top=0.->dp,
      ~left=20.->dp,
      ~height=size->dp,
      ~justifyContent=#center,
      ~alignItems=#center,
      (),
    ),
    "leftText": textStyle(~fontSize=17., ~fontWeight=FontWeight._600, ()),
    "right": viewStyle(
      ~position=#absolute,
      ~top=0.->dp,
      ~right=20.->dp,
      ~height=size->dp,
      ~justifyContent=#center,
      ~alignItems=#center,
      (),
    ),
    "rightText": textStyle(~fontSize=17., ~fontWeight=FontWeight._600, ()),
  }
}->StyleSheet.create

type sideArgs = {
  defaultStyle: Style.t,
  color: Color.t,
}

type animateBackgroundOpacity =
  | True
  | False
  | Delayed

@react.component
let make = (
  ~safeArea=true,
  ~scrollYAnimatedValue=?,
  ~title=?,
  ~scrollOffsetY=?,
  ~left: option<sideArgs => React.element>=?,
  ~leftAlwaysVisible=false,
  ~right: option<sideArgs => React.element>=?,
  ~rightAlwaysVisible=false,
  ~color as colour="#000",
  ~color2 as colour2="#000",
  ~animateTranslateY=true,
  ~animateBackgroundOpacity: animateBackgroundOpacity=True,
  ~backgroundElement=?,
  ~style as additionalStyle=?,
  ~titleStyle as additionalTitleStyle=?,
  ~textStyle as additionalTextStyle=?,
) => {
  let insets = ReactNativeSafeAreaContext.useSafeAreaInsets()
  let safeAreaTopStyle = {
    open Style
    safeArea ? style(~height=(size +. insets.top)->dp, ~paddingTop=insets.top->dp, ()) : style()
  }
  let (
    animatedStickyTranslation,
    animatedOpacityToVisible,
    animatedDelayedOpacityToVisible,
    animatedDelayedOpacityToTransparent,
  ) = {
    open Style
    scrollYAnimatedValue
    ->Option.map(scrollYAnimatedValue => {
      let animatedStickyTranslation = !animateTranslateY
        ? style()
        : switch Platform.os == #web {
          | true => unsafeStyle({"position": "fixed"})
          | false =>
            style(
              ~transform=[
                translateY(
                  ~translateY=scrollYAnimatedValue
                  ->{
                    open Animated.Interpolation
                    interpolate(
                      config(
                        ~inputRange=[0., 1.],
                        ~outputRange=[0., 1.]->fromFloatArray,
                        ~extrapolateLeft=#identity,
                        ~extrapolateRight=#identity,
                        (),
                      ),
                    )
                  }
                  ->Animated.StyleProp.float,
                ),
              ],
              (),
            )
          }
      let animatedOpacityToVisible = style(
        ~opacity=scrollYAnimatedValue
        ->{
          open Animated.Interpolation
          interpolate(
            config(
              ~inputRange=[0., scrollOffsetYGap],
              ~outputRange=[0., 1.]->fromFloatArray,
              ~extrapolateLeft=#clamp,
              ~extrapolate=#identity,
              ~extrapolateRight=#identity,
              (),
            ),
          )
        }
        ->Animated.StyleProp.float,
        (),
      )

      let animatedDelayedOpacityToVisible =
        scrollOffsetY
        ->Option.map(scrollOffsetY =>
          style(
            ~opacity=scrollYAnimatedValue
            ->{
              open Animated.Interpolation
              interpolate(
                config(
                  ~inputRange=[scrollOffsetY -. size -. scrollOffsetYGap, scrollOffsetY -. size],
                  ~outputRange=[0., 1.]->fromFloatArray,
                  ~extrapolateLeft=#clamp,
                  ~extrapolate=#identity,
                  ~extrapolateRight=#identity,
                  (),
                ),
              )
            }
            ->Animated.StyleProp.float,
            (),
          )
        )
        ->Option.getWithDefault(style(~opacity=1., ()))
      let animatedDelayedOpacityToTransparent =
        scrollOffsetY
        ->Option.map(scrollOffsetY =>
          style(
            ~opacity=scrollYAnimatedValue
            ->{
              open Animated.Interpolation
              interpolate(
                config(
                  ~inputRange=[scrollOffsetY -. size -. scrollOffsetYGap, scrollOffsetY -. size],
                  ~outputRange=[1., 0.]->fromFloatArray,
                  ~extrapolateLeft=#clamp,
                  ~extrapolate=#identity,
                  ~extrapolateRight=#identity,
                  (),
                ),
              )
            }
            ->Animated.StyleProp.float,
            (),
          )
        )
        ->Option.getWithDefault(style(~opacity=0., ()))
      (
        animatedStickyTranslation,
        animatedOpacityToVisible,
        animatedDelayedOpacityToVisible,
        animatedDelayedOpacityToTransparent,
      )
    })
    ->Option.getWithDefault((
      style(),
      style(~opacity=0., ()),
      style(~opacity=0., ()),
      style(~opacity=1., ()),
    ))
  }
  <Animated.View
    style={
      open Style
      arrayOption([
        Some(styles["wrapper"]),
        Some(animatedStickyTranslation),
        Some(safeAreaTopStyle),
        additionalStyle,
      ])
    }>
    {backgroundElement
    ->Option.map(backgroundElement =>
      switch animateBackgroundOpacity {
      | True =>
        <Animated.View
          style={
            open Style
            array([
              StyleSheet.absoluteFill,
              animatedOpacityToVisible,
              //  safeAreaTopStyle,
            ])
          }>
          backgroundElement
        </Animated.View>
      | Delayed =>
        <Animated.View
          style={
            open Style
            array([
              StyleSheet.absoluteFill,
              animatedDelayedOpacityToVisible,
              //  safeAreaTopStyle,
            ])
          }>
          backgroundElement
        </Animated.View>
      | False =>
        <View
          style={
            open Style
            array([StyleSheet.absoluteFill, safeAreaTopStyle])
          }>
          backgroundElement
        </View>
      }
    )
    ->Option.getWithDefault(React.null)}
    {title
    ->Option.map(title =>
      <Animated.View
      // key=Predefined.hairlineWidth is to avoid SSR/hydrate issue
        key={Predefined.hairlineWidth->Js.Float.toString}
        style={
          open Style
          arrayOption([
            Some(styles["textWrapper"]),
            Some(animatedDelayedOpacityToVisible),
            additionalTitleStyle,
            //  safeAreaTopStyle,
          ])
        }>
        <Text
          allowFontScaling=false
          numberOfLines=1
          style={
            open Style
            arrayOption([Some(styles["text"]), additionalTextStyle])
          }>
          {title->React.string}
        </Text>
      </Animated.View>
    )
    ->Option.getWithDefault(React.null)}
    {left
    ->Option.map(left => <>
      {leftAlwaysVisible
        ? <Animated.View
            style={
              open Style
              array([styles["left"], animatedDelayedOpacityToTransparent, safeAreaTopStyle])
            }>
            <Row> {left({color: colour, defaultStyle: styles["leftText"]})} </Row>
          </Animated.View>
        : React.null}
      <Animated.View
        style={
          open Style
          array([styles["left"], animatedDelayedOpacityToVisible, safeAreaTopStyle])
        }>
        <Row> {left({color: colour2, defaultStyle: styles["leftText"]})} </Row>
      </Animated.View>
    </>)
    ->Option.getWithDefault(React.null)}
    {right
    ->Option.map(right => <>
      {rightAlwaysVisible
        ? <Animated.View
            style={
              open Style
              array([styles["right"], animatedDelayedOpacityToTransparent, safeAreaTopStyle])
            }>
            <Row> {right({color: colour, defaultStyle: styles["rightText"]})} </Row>
          </Animated.View>
        : React.null}
      <Animated.View
        style={
          open Style
          array([styles["right"], animatedDelayedOpacityToVisible, safeAreaTopStyle])
        }>
        <Row> {right({color: colour2, defaultStyle: styles["rightText"]})} </Row>
      </Animated.View>
    </>)
    ->Option.getWithDefault(React.null)}
  </Animated.View>
}
