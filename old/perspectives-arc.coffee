# Run this file to regenerate the grammars/perspectives-arc.cson file, as follows:
# $ ./node_modules/.bin/coffee src/perspectives-arc.coffee
# Refresh with ctrl-alt-cmd-l

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
    keywordlimit: /[\:|\s]/

  patterns: [
      name: 'keyword.control' # purple
      match: /mandatory|functional|not\s|on\s|with\s|for\s|\sif\s|\sthen\s/
    ,
      name: 'comment.propertyrange.arc' # gray
      match: /String|Number|Boolean|DateTime|Consult|Change|Delete|Create|Bind/
    ,
      name: 'entity.name.type.contextkinds.arc' # yellow
      match: /domain|case|party|activity|state/
    ,
      name: 'string.rolekinds.arc' # green
      match: /external|thing|context|user|bot/
    ,
      name: 'entity.name.function.rolepart.arc'
      match: /property|view|perspective/
    ,
      name: 'variable.aspect.arc' # red.
      match: /aspect|use{keywordlimit}|filledBy|indexed/
    ,
      name: 'variable.interpolation.actionparts.arc'
      match: /indirectObject|subjectView/
    ,
      include: '#comments'
  ]
  repository:
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
