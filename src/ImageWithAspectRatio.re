open ReactNative;

let styles =
  Style.{
    "imageContainer": style(~display=`flex, ~overflow=`hidden, ()),
    "image": style(~backgroundColor=Predefined.Colors.lightGrey, ()),
  }
  ->StyleSheet.create;

[@react.component]
let make = (~uri, ~ratio, ~style as styl=?, ()) => {
  <View style=styles##imageContainer>
    <PlaceholderWithAspectRatio ratio>
      <ImageFromUri
        style=Style.(
          arrayOption([|
            Some(StyleSheet.absoluteFill),
            Some(styles##image),
            styl,
          |])
        )
        uri
      />
    </PlaceholderWithAspectRatio>
  </View>;
};
