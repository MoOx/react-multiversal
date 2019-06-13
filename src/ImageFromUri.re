open ReactNative;

[@react.component]
let make = (~uri, ~resizeMode=?, ~style=?, ()) => {
  <Image
    ?resizeMode
    ?style
    source={Image.Source.fromUriSource(Image.uriSource(~uri, ()))}
    // SSR workaround https://github.com/necolas/react-native-web/issues/543
    defaultSource={Image.DefaultSource.fromUri(~uri, ())}
  />;
};
