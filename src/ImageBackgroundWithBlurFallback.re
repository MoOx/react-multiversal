open Belt;
open ReactNative;

type action =
  | FallbackLoaded
  | Loaded;

type state = {
  fallbackLoaded: bool,
  animation: Animated.Value.t,
};

/*
 width & height are required, per RN internal Image implementation
 https://github.com/facebook/react-native/blob/f741d338406d518c4f81fada723991b2938b8cc5/Libraries/Image/ImageBackground.js#L72-L80
 */
[@react.component]
let make =
    (
      ~fallbackSource: option(Image.Source.t)=?,
      ~source: option(Image.Source.t)=?,
      ~style as s=?,
      ~styleImage=?,
      ~width as w,
      ~height as h,
      ~blurRadius=2.,
      ~children,
    ) => {
  let (state, dispatch) =
    React.useReducer(
      (state, action) =>
        switch (action) {
        | FallbackLoaded => {...state, fallbackLoaded: true}
        | Loaded =>
          Animated.(
            start(
              state.animation
              ->timing(
                  Value.Timing.(
                    config(
                      ~toValue=1.->fromRawValue,
                      ~duration=300.,
                      ~useNativeDriver=true,
                      (),
                    )
                  ),
                ),
              (),
            )
          );
          state;
        },
      {
        fallbackLoaded: false,
        animation:
          Animated.Value.create(fallbackSource->Option.isSome ? 0. : 1.),
      },
    );
  let dimStyle = Style.(style(~width=w, ~height=h, ()));
  let fillImageStyle =
    Style.(
      arrayOption([|
        Some(StyleSheet.absoluteFill),
        Some(dimStyle),
        styleImage,
      |])
    );
  <Animated.View style=Style.(arrayOption([|Some(dimStyle), s|]))>
    {fallbackSource
     ->Option.map(source =>
         <Animated.View style=StyleSheet.absoluteFill>
           <Image
             style=fillImageStyle
             resizeMode=`cover
             source
             onLoad={_ => dispatch(FallbackLoaded)}
             blurRadius
           />
         </Animated.View>
       )
     ->Option.getWithDefault(React.null)}
    {fallbackSource->Option.isSome && !state.fallbackLoaded
       ? React.null
       : source
         ->Option.map(source =>
             <Animated.View
               style=Style.(
                 array([|
                   StyleSheet.absoluteFill,
                   style(
                     ~opacity=state.animation->Animated.StyleProp.float,
                     (),
                   ),
                 |])
               )>
               <Image
                 style=fillImageStyle
                 resizeMode=`cover
                 source
                 onLoad={_ => dispatch(Loaded)}
               />
             </Animated.View>
           )
         ->Option.getWithDefault(React.null)}
    <View style=StyleSheet.absoluteFill> ...children </View>
  </Animated.View>;
};
