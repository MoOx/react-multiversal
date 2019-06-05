open Belt;
open ReactNative;

let size = 44.;
let scrollOffsetYGap = 10.;
let styles =
  Style.(
    StyleSheet.create({
      "wrapper":
        style(
          ~zIndex=100,
          ~position=`absolute,
          ~top=0.->dp,
          ~left=0.->dp,
          ~right=0.->dp,
          ~height=size->dp,
          ~justifyContent=`center,
          ~alignItems=`center,
          (),
        ),
      "overlay": style(~backgroundColor="rgba(255,255,255,0.8)", ()),
      "textWrapper":
        style(
          ~borderBottomWidth=Predefined.hairlineWidth,
          ~borderBottomColor="#e2e2e2",
          ~justifyContent=`center,
          ~alignItems=`center,
          ~width=100.->pct,
          ~height=100.->pct,
          (),
        ),
      "text":
        style(
          ~textAlign=`center,
          ~width=50.->pct,
          ~fontSize=16.,
          ~fontWeight=`bold,
          (),
        ),
      "left":
        style(
          ~position=`absolute,
          ~top=0.->dp,
          ~left=10.->dp,
          ~height=size->dp,
          ~justifyContent=`center,
          ~alignItems=`center,
          (),
        ),
      "right":
        style(
          ~position=`absolute,
          ~top=0.->dp,
          ~right=10.->dp,
          ~height=size->dp,
          ~justifyContent=`center,
          ~alignItems=`center,
          (),
        ),
    })
  );

type sideArgs = {color: Color.t};

[@react.component]
let make =
    (
      ~scrollYAnimatedValue=?,
      ~title=?,
      ~scrollOffsetY=?,
      ~left: option(sideArgs => React.element)=?,
      ~leftAlwaysVisible=false,
      ~right: option(sideArgs => React.element)=?,
      ~rightAlwaysVisible=false,
      ~color as colour="#000",
      ~color2 as colour2="#000",
      ~animateBackgroundOpacity: [ | `yes | `no | `delayed]=?,
    ) => {
  let (
    animatedStickyTranslation,
    animatedOpacityToVisible,
    animatedDelayedOpacityToVisible,
    animatedDelayedOpacityToTransparent,
  ) =
    Style.(
      scrollYAnimatedValue
      ->Option.map(scrollYAnimatedValue => {
          let animatedStickyTranslation =
            Platform.os == Platform.web
              ? unsafeStyle({"position": "fixed"})
              : style(
                  ~transform=[|
                    translateY(
                      ~translateY=
                        scrollYAnimatedValue
                        ->Animated.Interpolation.(
                            interpolate(
                              config(
                                ~inputRange=[|0., 1.|],
                                ~outputRange=[|0., 1.|]->fromFloatArray,
                                ~extrapolateLeft=`clamp,
                                ~extrapolateRight=`identity,
                                (),
                              ),
                            )
                          )
                        ->Animated.StyleProp.float,
                    ),
                  |],
                  (),
                );
          let animatedOpacityToVisible =
            style(
              ~opacity=
                scrollYAnimatedValue
                ->Animated.Interpolation.(
                    interpolate(
                      config(
                        ~inputRange=[|0., scrollOffsetYGap|],
                        ~outputRange=[|0., 1.|]->fromFloatArray,
                        ~extrapolateLeft=`clamp,
                        ~extrapolate=`identity,
                        ~extrapolateRight=`identity,
                        (),
                      ),
                    )
                  )
                ->Animated.StyleProp.float,
              (),
            );

          let animatedDelayedOpacityToVisible =
            scrollOffsetY
            ->Option.map(scrollOffsetY =>
                style(
                  ~opacity=
                    scrollYAnimatedValue
                    ->Animated.Interpolation.(
                        interpolate(
                          config(
                            ~inputRange=[|
                              scrollOffsetY -. size -. scrollOffsetYGap,
                              scrollOffsetY -. size,
                            |],
                            ~outputRange=[|0., 1.|]->fromFloatArray,
                            ~extrapolateLeft=`clamp,
                            ~extrapolate=`identity,
                            ~extrapolateRight=`identity,
                            (),
                          ),
                        )
                      )
                    ->Animated.StyleProp.float,
                  (),
                )
              )
            ->Option.getWithDefault(style(~opacity=1., ()));
          let animatedDelayedOpacityToTransparent =
            scrollOffsetY
            ->Option.map(scrollOffsetY =>
                style(
                  ~opacity=
                    scrollYAnimatedValue
                    ->Animated.Interpolation.(
                        interpolate(
                          config(
                            ~inputRange=[|
                              scrollOffsetY -. size -. scrollOffsetYGap,
                              scrollOffsetY -. size,
                            |],
                            ~outputRange=[|1., 0.|]->fromFloatArray,
                            ~extrapolateLeft=`clamp,
                            ~extrapolate=`identity,
                            ~extrapolateRight=`identity,
                            (),
                          ),
                        )
                      )
                    ->Animated.StyleProp.float,
                  (),
                )
              )
            ->Option.getWithDefault(style(~opacity=0., ()));
          (
            animatedStickyTranslation,
            animatedOpacityToVisible,
            animatedDelayedOpacityToVisible,
            animatedDelayedOpacityToTransparent,
          );
        })
      ->Option.getWithDefault((
          style(),
          style(~opacity=0., ()),
          style(~opacity=0., ()),
          style(~opacity=1., ()),
        ))
    );
  <Animated.View
    style=Style.(array([|styles##wrapper, animatedStickyTranslation|]))>
    {
      let centerChild =
        // <>
        //   <View
        //     style={Style.array([|
        //       StyleSheet.absoluteFill,
        //       styles##overlay,
        //     |])}
        //   />
        //   <BlurView blur=`light style=StyleSheet.absoluteFill />
        // </>;
        <BlurView
          style={ReactDOMRe.Style.make(
            ~position="absolute",
            ~top="0",
            ~bottom="0",
            ~left="0",
            ~right="0",
            (),
          )}
        />;
      switch (animateBackgroundOpacity) {
      | `yes =>
        <Animated.View
          style=Style.(
            array([|StyleSheet.absoluteFill, animatedOpacityToVisible|])
          )>
          centerChild
        </Animated.View>
      | `delayed =>
        <Animated.View
          style=Style.(
            array([|
              StyleSheet.absoluteFill,
              animatedDelayedOpacityToVisible,
            |])
          )>
          centerChild
        </Animated.View>
      | `no => <View style=StyleSheet.absoluteFill> centerChild </View>
      };
    }
    {title
     ->Option.map(title =>
         <Animated.View
           key={Predefined.hairlineWidth->Js.Float.toString}
           // key=Predefined.hairlineWidth is to avoid SSR/hydrate issue
           style=Style.(
             array([|styles##textWrapper, animatedDelayedOpacityToVisible|])
           )>
           <SafeArea.Top />
           <Text style=styles##text numberOfLines=1>
             title->React.string
           </Text>
         </Animated.View>
       )
     ->Option.getWithDefault(React.null)}
    {left
     ->Option.map(left =>
         <>
           {leftAlwaysVisible
              ? <Animated.View
                  style=Style.(
                    array([|
                      styles##left,
                      animatedDelayedOpacityToTransparent,
                    |])
                  )>
                  <SafeArea.Top />
                  <Row> {left({color: colour})} </Row>
                </Animated.View>
              : React.null}
           <Animated.View
             style=Style.(
               array([|styles##left, animatedDelayedOpacityToVisible|])
             )>
             <SafeArea.Top />
             <Row> {left({color: colour2})} </Row>
           </Animated.View>
         </>
       )
     ->Option.getWithDefault(React.null)}
    {right
     ->Option.map(right =>
         <>
           {rightAlwaysVisible
              ? <Animated.View
                  style=Style.(
                    array([|
                      styles##right,
                      animatedDelayedOpacityToTransparent,
                    |])
                  )>
                  <SafeArea.Top />
                  <Row> {right({color: colour})} </Row>
                </Animated.View>
              : React.null}
           <Animated.View
             style=Style.(
               array([|styles##right, animatedDelayedOpacityToVisible|])
             )>
             <SafeArea.Top />
             <Row> {right({color: colour2})} </Row>
           </Animated.View>
         </>
       )
     ->Option.getWithDefault(React.null)}
  </Animated.View>;
};
