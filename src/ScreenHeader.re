open Belt;
open ReactNative;

// @todo
let topSpace =
  // browser have their own toolbar etc, so we don't need large space
  if (Platform.os === Platform.web) {
    50.; // @todo make this more precise
  } else {
    Dimensions.get(`window)##height > 640. ? 130. : 110.;
  };

type size =
  | Medium
  | Large;

let containerHeight =
  fun
  | Medium => topSpace
  | Large => topSpace +. 44.;

let styles =
  Style.(
    StyleSheet.create({
      "container": style(~zIndex=1, ~justifyContent=`flexEnd, ()),
      "title": style(),
      "children": style(~zIndex=1, ()),
    })
  );

let prerenderedGradient =
  <View style=StyleSheet.absoluteFill>
    <GradientLinear height="100%" width="100%" opacity2="0.5" />
  </View>;

[@react.component]
let make =
    (
      ~titlePre=?,
      ~title,
      ~scrollYAnimatedValue=?,
      ~backgroundSource=?,
      ~backgroundFallbackSource=?,
      ~backgroundGradient=false,
      ~backgroundElastic=false,
      // ~stickyTitle=?,
      // ~animateStickyBackgroundOpacity=`yes,
      // ~left=?,
      // ~right=?,
      ~color as colour=?,
      ~backgroundColor as bgColor="#000",
      ~size: size=Large,
      ~children=?,
    ) => {
  let deviceWidth = Dimensions.get(`window)##width;
  let deviceHeight = Dimensions.get(`window)##height;
  let child = {
    children
    ->Option.map(children =>
        <View
          style=Style.(array([|StyleSheet.absoluteFill, styles##children|]))
          pointerEvents=`boxNone>
          children
        </View>
      )
    ->Option.getWithDefault(React.null);
  };
  let h = containerHeight(size);
  <SpacedView
    vertical=None
    style=Style.(array([|styles##container, style(~height=h->pt, ())|]))>
    {backgroundSource
     ->Option.map(source =>
         <ImageBackgroundWithBlurFallback
           fallbackSource=?backgroundFallbackSource
           source
           width={deviceWidth->Style.pt}
           height={h->Style.pt}
           style=Style.(
             arrayOption([|
               Some(StyleSheet.absoluteFill),
               Some(style(~backgroundColor=bgColor, ())),
               !backgroundElastic
                 ? None
                 : scrollYAnimatedValue->Option.map(scrollYAnimatedValue =>
                     style(
                       ~transform=[|
                         translateY(
                           ~translateY=
                             scrollYAnimatedValue
                             ->Animated.Interpolation.(
                                 interpolate(
                                   config(
                                     ~inputRange=[|-. deviceHeight +. h, 0.|],
                                     ~outputRange=
                                       [|(-. deviceHeight +. h) /. 2., 0.|]
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
                                     ~inputRange=[|-. deviceHeight +. h, 0.|],
                                     ~outputRange=
                                       [|deviceHeight /. h, 1.|]
                                       ->fromFloatArray,
                                     ~extrapolateRight=`clamp,
                                     (),
                                   ),
                                 )
                               )
                             ->Animated.StyleProp.float,
                         ),
                       |],
                       (),
                     )
                   ),
             |])
           )>
           {backgroundGradient ? prerenderedGradient : ReasonReact.null}
           child
         </ImageBackgroundWithBlurFallback>
       )
     ->Option.getWithDefault(child)}
    // <StickyHeader
    //   title={stickyTitle->Option.getWithDefault(title)}
    //   scrollOffsetY={containerHeight(size)}
    //   ?scrollYAnimatedValue
    //   color=?colour
    //   ?left
    //   ?right
    //   animateBackgroundOpacity=animateStickyBackgroundOpacity
    // />
    {titlePre
     ->Option.map(titlePre =>
         <TitlePre> titlePre->ReasonReact.string </TitlePre>
       )
     ->Option.getWithDefault(React.null)}
    <Text
      style=Style.(
        arrayOption([|
          Some(
            style(
              ~fontSize=
                switch (size) {
                | Medium => 28.
                | Large => 34.
                },
              ~fontWeight=`_700,
              (),
            ),
          ),
          colour->Option.map(colour => style(~color=colour, ())),
        |])
      )>
      title->ReasonReact.string
    </Text>
    <Spacer size=XS />
  </SpacedView>;
};
