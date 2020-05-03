open ReactNative;

let styles = Style.{"container": viewStyle(~flex=1., ())}->StyleSheet.create;

type renderArgs = {
  scrollXAnimatedValue: Animated.Value.t,
  scrollYAnimatedValue: Animated.Value.t,
  scrollViewRef:
    React.Ref.t(Js.Nullable.t(ReactNative.Animated.ScrollView.element)),
};

[@react.component]
let make =
    (
      ~style as s=?,
      ~contentContainerStyle=?,
      ~children: renderArgs => React.element,
    ) => {
  let scrollViewRef = React.useRef(Js.Nullable.null);
  let (scrollXAnimatedValue, _setScrollXAnimatedValue) =
    React.useState(() => Animated.Value.create(0.));
  let (scrollYAnimatedValue, _setScrollYAnimatedValue) =
    React.useState(() => Animated.Value.create(0.));

  <Animated.ScrollView
    ref={scrollViewRef->Ref.value}
    style=Style.(arrayOption([|Some(styles##container), s|]))
    ?contentContainerStyle
    scrollEventThrottle=1
    onScroll=Animated.(
      event1(
        [|
          {
            "nativeEvent": {
              "contentOffset": {
                "x": scrollXAnimatedValue,
                "y": scrollYAnimatedValue,
              },
            },
          },
        |],
        eventOptions(~useNativeDriver=true, ()),
      )
    )
    showsVerticalScrollIndicator=false
    showsHorizontalScrollIndicator=false>
    {children({scrollYAnimatedValue, scrollXAnimatedValue, scrollViewRef})}
  </Animated.ScrollView>;
};
