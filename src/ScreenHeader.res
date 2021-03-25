open Belt
open ReactNative

// @todo
let topSpace = // browser have their own toolbar etc, so we don't need large space
if Platform.os === Platform.web {
  50. // @todo make this more precise
} else if Dimensions.get(#window).height > 640. {
  130.
} else {
  110.
}

type size =
  | Medium
  | Large

let containerHeight = x =>
  switch x {
  | Medium => topSpace
  | Large => topSpace +. 44.
  }

let styles = {
  open Style
  {
    "container": style(~zIndex=1, ~justifyContent=#flexEnd, ()),
    "title": style(),
    "children": style(~zIndex=1, ()),
  }
}->StyleSheet.create

let prerenderedGradient =
  <View style=StyleSheet.absoluteFill>
    <GradientLinear height="100%" width="100%" opacity2="0.5" />
  </View>

@react.component
let make = (
  ~titlePre=?,
  ~title,
  ~scrollYAnimatedValue=?,
  ~backgroundSource=?,
  ~backgroundFallbackSource=?,
  ~backgroundGradient=false,
  ~backgroundElastic=false,
  ~color as // ~stickyTitle=?,
  // ~animateStickyBackgroundOpacity=`yes,
  // ~left=?,
  // ~right=?,
  colour=?,
  ~backgroundColor as bgColor="#000",
  ~size: size=Large,
  ~children=?,
) => {
  let dimensions = Dimensions.useWindowDimensions()
  let child =
    children
    ->Option.map(children =>
      <View
        style={
          open Style
          array([StyleSheet.absoluteFill, styles["children"]])
        }
        pointerEvents=#boxNone>
        children
      </View>
    )
    ->Option.getWithDefault(React.null)
  let h = containerHeight(size)
  <SpacedView
    vertical=None
    style={
      open Style
      array([styles["container"], style(~height=h->dp, ())])
    }>
    {backgroundSource
    ->Option.map(source =>
      <ImageBackgroundWithBlurFallback
        fallbackSource=?backgroundFallbackSource
        source
        width={dimensions.width->Style.dp}
        height={h->Style.dp}
        style={
          open Style
          arrayOption([
            Some(StyleSheet.absoluteFill),
            Some(style(~backgroundColor=bgColor, ())),
            !backgroundElastic
              ? None
              : scrollYAnimatedValue->Option.map(scrollYAnimatedValue =>
                  style(
                    ~transform=[
                      translateY(
                        ~translateY=scrollYAnimatedValue
                        ->{
                          open Animated.Interpolation
                          interpolate(
                            config(
                              ~inputRange=[-.dimensions.height +. h, 0.],
                              ~outputRange=[(-.dimensions.height +. h) /. 2., 0.]->fromFloatArray,
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
                              ~inputRange=[-.dimensions.height +. h, 0.],
                              ~outputRange=[dimensions.height /. h, 1.]->fromFloatArray,
                              ~extrapolateRight=#clamp,
                              (),
                            ),
                          )
                        }
                        ->Animated.StyleProp.float,
                      ),
                    ],
                    (),
                  )
                ),
          ])
        }>
        {backgroundGradient ? prerenderedGradient : ReasonReact.null} child
      </ImageBackgroundWithBlurFallback>
    )
    ->Option.getWithDefault(child)}
    {
      // <StickyHeader
      //   title={stickyTitle->Option.getWithDefault(title)}
      //   scrollOffsetY={containerHeight(size)}
      //   ?scrollYAnimatedValue
      //   color=?colour
      //   ?left
      //   ?right
      //   animateBackgroundOpacity=animateStickyBackgroundOpacity
      // />
      titlePre
      ->Option.map(titlePre => <TitlePre> {titlePre->ReasonReact.string} </TitlePre>)
      ->Option.getWithDefault(React.null)
    }
    <Text
      style={
        open Style
        arrayOption([
          Some(
            style(
              ~fontSize=switch size {
              | Medium => 28.
              | Large => 34.
              },
              ~fontWeight=#_700,
              (),
            ),
          ),
          colour->Option.map(colour => style(~color=colour, ())),
        ])
      }>
      {title->ReasonReact.string}
    </Text>
    <Spacer size=XS />
  </SpacedView>
}
