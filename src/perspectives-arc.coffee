# Run this file to regenerate the grammars/purescript.cson file, as follows:
# $ ./node_modules/.bin/coffee src/perspectives-arc.coffee

makeGrammar = require './syntax-tools'

toString = (rx) ->
  if rx instanceof RegExp
    rx.source
  else
    rx

list = (item,s,sep) ->
  #recursive regexp, caution advised
  "(?<#{item}>(?:#{toString s})(?:\\s*(?:#{toString sep})\\s*\\g<#{item}>)?)"

listMaybe = (item,s,sep) ->
  #recursive regexp, caution advised
  "(?<#{item}>(?:#{toString s})(?:\\s*(?:#{toString sep})\\s*\\g<#{item}>)?)?"

concat = (list...) ->
  r=''.concat (list.map (i) -> "(?:#{toString i})")...
  "(?:#{r})"

arcGrammar =
  name: 'Perspectives Arc'
  fileTypes: [ 'arc' ]
  scopeName: 'source.perspectives-arc'

  macros:
    CapitalizedString: /[\p{Lu}\p{Lt}][\p{Ll}_\p{Lu}\p{Lt}\p{Nd}']*/
    UncapitalizedString: /[\p{Ll}_][\p{Ll}_\p{Lu}\p{Lt}\p{Nd}']*/
    LowerCaseString: /[\p{Ll}_][\p{Ll}_\p{Lt}\p{Nd}']*/
    Prefix: /{LowerCaseString}\:/
    maybeBirdTrack: /^/
    character: ///
      (?:
        [\ -\[\]-~]                # Basic Char
        | (\\(?:NUL|SOH|STX|ETX|EOT|ENQ|ACK|BEL|BS|HT|LF|VT|FF|CR|SO|SI|DLE
          |DC1|DC2|DC3|DC4|NAK|SYN|ETB|CAN|EM|SUB|ESC|FS|GS|RS
          |US|SP|DEL|[abfnrtv\\\"'\&]))    # Escapes
        | (\\o[0-7]+)                # Octal Escapes
        | (\\x[0-9A-Fa-f]+)            # Hexadecimal Escapes
        | (\^[A-Z@\[\]\\\^_])            # Control Chars
      )
      ///
    ranges: /(?:String|Boolean|Number|Date)/

  patterns: [
      name: 'meta.entity.textdeclaration'
      begin: /^(Tekstnaam)\s+/
      end: /$/
      beginCaptures:
        1: name: 'keyword.other'
      patterns: [
          include: '#comments'
        ,
          include: '#characters'
      ]
    ,
      name: 'keyword.control'
      match: /als|met properties/
    ,
      name: 'support.other'
      match: /import/
    ,
      name: 'section'
      match: /(Partijen|Zaken|Activiteiten|Toestanden|Acties|Rollen|Properties|Acties|Views|intern|extern)/
      captures:
        1: name: 'keyword.other'
    ,
      name: 'meta.entity.contexdeclaration'
      begin: /(?=.*heeft)/
      end: /$/
      patterns: [
          include: '#context'
        ,
          name: 'support.other'
          match: /heeft/
      ]
    ,
      name: 'meta.entity.roldeclaration'
      begin: /^\s*(?=.*gevuld door)/
      end: /\n{1,1}?/
      patterns: [
          name: 'support.other'
          match: /gevuld door|heeft/
        ,
          include: '#verplicht'
        ,
          include: '#functioneel'
        ,
          include: '#rol'
        ,
          include: '#context'
        ,
          include: '#comments'
      ]
    ,
      name: 'meta.entity.propertydeclaration'
      begin: /^\s*(?=.*{ranges})/
      end: /\n{1,1}?/
      patterns: [
          include: '#verplicht'
        ,
          include: '#functioneel'
        ,
          include: '#range'
        ,
          include: '#property'
        ,
          include: '#context'
        ,
          include: '#comments'
      ]
    ,
      name: 'meta.entity.import'
      begin: /^\s*(import)/
      end: /\n{1,1}?/
      beginCaptures:
        1: name: 'support.other'
      patterns: [
          include: '#domein_name'
        ,
          name: 'support.other.alias'
          match: /(als)\s*({Prefix})/
          captures:
            1: name: 'support.other'
            2: name: 'entity.name.tag.prefix'
      ]
    ,
      include: '#comments'
    ,
      name: 'string.quoted.double'
      begin: /"/
      end: /"/
      beginCaptures:
        0: name: 'punctuation.definition.string.begin'
      endCaptures:
        0: name: 'punctuation.definition.string.end'
      patterns: [
          include: '#characters'
        ,
          begin: /\\\s/
          end: /\\/
          beginCaptures:
            0: name: 'markup.other.escape.newline.begin'
          endCaptures:
            0: name: 'markup.other.escape.newline.end'
          patterns: [
              match: /\S+/
              name: 'invalid.illegal.character-not-allowed-here'
          ]
        ]
  ]
  repository:
    range:
      name: 'constant.language.propertytypes'
      match: /{ranges}/
    ###
      CONTEXT NAMES
    ###
    verplicht:
      name: 'storage.modifier.verplicht'
      match: /Verplicht|Niet\s*Verplicht/
    functioneel:
      name: 'storage.modifier.functioneel'
      match: /Functioneel|Niet\s*Functioneel/
    context:
      patterns: [
          include: '#localcontextName'
        ,
          include: '#qualifiedContextName'
        ,
          include: '#prefixedContextName'
        ]
    localcontextName:
      name: 'localcontextName'
      match: /(\$)({CapitalizedString})/
      captures:
        1: name: 'entity.name.tag.separator'
        2: name: 'entity.name.type.localcontextname'
    domein_name:
      name: 'domein_name'
      match: /(model\:)({CapitalizedString})/
      captures:
          1: name: 'entity.name.tag.model'
          2: name: 'entity.name.type.localcontextname'
    qualifiedContextName:
      patterns:[
          include: '#domein_name'
        ,
          include: '#localcontextName'
      ]
    prefixedContextName:
      patterns:[
          name: 'entity.name.tag.prefix'
          match: /{Prefix}/
        ,
          name: 'entity.name.type.localcontextname'
          match: /{CapitalizedString}/
        ,
          include: '#localcontextName'
      ]
    rol:
      patterns: [
          include: '#localrolname'
        ,
          include: '#qualifiedContextName'
        ,
          include: '#prefixedContextName'
        ]
    property:
      patterns: [
          include: '#rolsegment'
        ,
          include: '#localpropertyname'
        ,
          include: '#qualifiedContextName'
        ,
          include: '#prefixedContextName'
        ]
    localrolname:
      match: /(\$)({UncapitalizedString})\b/
      captures:
        1: name: 'entity.name.tag.separator'
        2: name: 'entity.other.tag.localrolname'
    rolsegment:
      match: /(\$)({UncapitalizedString})(?=\$)/
      captures:
        1: name: 'entity.name.tag.separator'
        2: name: 'entity.other.tag.rolsegment'
    localpropertyname:
      match: /(\$)({UncapitalizedString})(?!\$)/
      captures:
        1: name: 'entity.name.tag.separator'
        2: name: 'entity.other.attribute-name.localpropertyname'
    ###
      COMMENTS
    ###
    comments:
      patterns: [
          begin: /({maybeBirdTrack}[ \t]+)?(?=--+\s+\|)/
          end: /(?!\G)/
          beginCaptures:
            1: name: 'punctuation.whitespace.comment.leading'
          patterns: [
              name: 'comment.line.double-dash.documentation'
              begin: /(--+)\s+(\|)/
              end: /\n/
              beginCaptures:
                1: name: 'punctuation.definition.comment'
                2: name: 'punctuation.definition.comment.documentation'
          ]
        ,
          ###
          Operators may begin with -- as long as they are not
          entirely composed of - characters. This means comments can't be
          immediately followed by an allowable operator character.
          ###
          begin: /({maybeBirdTrack}[ \t]+)?(?=--+)/
          end: /(?!\G)/
          beginCaptures:
            1: name: 'punctuation.whitespace.comment.leading'
          patterns: [
              name: 'comment.line.double-dash'
              begin: /--/
              end: /\n/
              beginCaptures:
                0: name: 'punctuation.definition.comment'
          ]
        ,
          include: '#block_comment'
      ]
    block_comment:
      patterns: [
          name: 'comment.block.documentation'
          begin: /\{-\s*\|/
          end: /-\}/
          applyEndPatternLast: 1
          beginCaptures:
            0: name: 'punctuation.definition.comment.documentation'
          endCaptures:
            0: name: 'punctuation.definition.comment.documentation'
          patterns: [
              include: '#block_comment'
          ]
        ,
          name: 'comment.block'
          begin: /\{-/
          end: /-\}/
          applyEndPatternLast: 1
          beginCaptures:
            0: name: 'punctuation.definition.comment'
          patterns: [
              include: '#block_comment'
          ]
      ]
    characters:
      match: /{character}/
      captures:
        1: name: 'constant.character.escape'
        2: name: 'constant.character.escape.octal'
        3: name: 'constant.character.escape.hexadecimal'
        4: name: 'constant.character.escape.control'



makeGrammar arcGrammar, "grammars/perspectives-arc.cson"
