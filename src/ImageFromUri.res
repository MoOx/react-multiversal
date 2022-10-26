open ReactNative

@react.component
let make = (~uri, ~resizeMode=?, ~style=?, ()) =>
  <Image
    ?resizeMode
    ?style
    source={Image.Source.fromUriSource(Image.uriSource(~uri, ()))}
    defaultSource={
      // SSR workaround https://github.com/necolas/react-native-web/issues/543
      Image.Source.fromUriSource({uri: uri})
    }
  />
