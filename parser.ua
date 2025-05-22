~ "ir.ua" ~ AExpr And Asgn BExpr Constant Equals Greater IO If Minus Plus Seq Skip Stmt Times Variable While

Digit  ← ×⊃(≥@0|≤@9)
Letter ← ±+∩×⊃(≥@A|≤@Z|≥@a|≤@z)
Alnum  ← ±+⊃(Digit|Letter)

┌─╴Token
  ┌─╴Operator
    |Asgn
    |Seq
    |Plus
    |Minus
    |Times
    |Equals
    |Greater
    |Geq
    |Less
    |Leq
    |ANot
    |BNot
    |And
    |LParen
    |RParen
    New ← (
      ⍣(Asgn⍤.≍":="
      | Seq⍤.≍";"
      | Plus⍤.≍"+"
      | Minus⍤.≍"-"
      | Times⍤.≍"*"
      | Equals⍤.≍"="
      | Greater⍤.≍">"
      | Geq⍤.≍">="
      | Less⍤.≍"<"
      | Leq⍤.≍"<="
      | And⍤.≍"&&"
      | ANot⍤.≍"?"
      | BNot⍤.≍"!"
      | LParen⍤.≍"("
      | RParen⍤.≍")"
      )
    )
  └─╴
  ┌─╴Keyword ~ Do Else Fi IO If Od Skip Then While
    |Skip
    |If
    |Then
    |Else
    |Fi
    |IO
    |While
    |Do
    |Od
    New ← (
      ⍣(Skip⍤.≍"skip"
      | If⍤.≍"if"
      | Then⍤.≍"then"
      | Else⍤.≍"else"
      | Fi⍤.≍"fi"
      | IO⍤.≍"IO"
      | While⍤.≍"while"
      | Do⍤.≍"do"
      | Od⍤.≍"od"
      )
    )
  └─╴
  |Id {Name}
  |Int {Val}
  |Op {Op}
  |KW {KW}
  |EOI

  New ← (
    ⍣(KW Keyword°□⍤.⊸∊{"skip" "if" "then" "else" "fi" "IO" "while" "do" "od"}
    | Id⍤.Letter⊸⊢°□
    | Int⋕⍤.Digit⊸⊢°□
    | Op Operator°□
    )
  )
└─╴
┌─╴Tokenizer
  ┌─╴State ~ Id Int Op Wait
    |Wait |Id |Int |Op
  └─╴
  ~ {Buffer ← ""|CurState ← Wait|Tokens ← []}
  WaitConsume ← ⍣(
    °@ 
  | °⊸CurState Id ⍜Buffer⊂: ⍤.⊸Letter
  | °⊸CurState Int ⍜Buffer⊂: ⍤.⊸Digit
  | °⊸CurState Op ⍜Buffer⊂:
  )
  IdConsume ← ⍣(
    °⊸Buffer "" ⍜Tokens(⊂⊙□): ⊸Buffer °⊸CurState Wait °@ 
  | ⍜Buffer⊂ : ⍤.⊸Alnum
  | °⊸CurState Op °⊸Buffer[∘]: ⍜Tokens(⊂⊙□): ⊸Buffer :
  )
  IntConsume ← ⍣(
    °⊸Buffer "" ⍜Tokens(⊂⊙□): ⊸Buffer °⊸CurState Wait °@ 
  | °⊸CurState Id °⊸Buffer[∘]: ⍜Tokens(⊂⊙□): ⊸Buffer : ⍤.⊸Letter
  | ⍜Buffer⊂ : ⍤.⊸Digit
  | °⊸CurState Op °⊸Buffer[∘]: ⍜Tokens(⊂⊙□): ⊸Buffer :
  )
  OpConsume ← ⍣(
    °⊸Buffer "" ⍜Tokens(⊂⊙□): ⊸Buffer °⊸CurState Wait °@ 
  | °⊸CurState Id °⊸Buffer[∘]: ⍜Tokens(⊂⊙□): ⊸Buffer : ⍤.⊸Letter
  | °⊸CurState Int °⊸Buffer[∘]: ⍜Tokens(⊂⊙□): ⊸Buffer : ⍤.⊸Digit
  | ⍜Buffer⊂ :
  )
  Consume ← |2 (
    ⊃(⋅CurState|⊙∘)
    ⍣(WaitConsume°Wait
    | IdConsume°Id
    | IntConsume°Int
    | OpConsume°Op
    )
  )
  EOI ← |1 (
    ⊸CurState
    ⍣(∘°Wait
    | °⊸CurState Wait °⊸Buffer"" ⍜Tokens(⊂⊙□): ⊸Buffer◌
    )
  )
  Run ← (
    ∧Consume
    EOI
    ≡Token Tokens
  )
└─╴
┌─╴Parser
  ParseAExpr ← |1.2 (
    ⍣(Variable °Token~Id °⊂
    | Constant °Token~Int °⊂
    | :°(⊂Token~Op Token~Operator~RParen) : ParseAExpr °(Token~Op Token~Operator~LParen) °⊂
    | AExpr~Not ParseAExpr °(Token~Op Token~Operator~ANot) °⊂
    )
    ⍣(Plus⊙(⍩(ParseAExpr)°(⊂Token~Op Token~Operator~Plus))
    | Minus⊙(⍩(ParseAExpr)°(⊂Token~Op Token~Operator~Minus))
    | Times⊙(⍩(ParseAExpr)°(⊂Token~Op Token~Operator~Times))
    | ∘
    )
  )
  ParseBExpr ← |1.2 (
    ⍣(:°(⊂Token~Op Token~Operator~RParen) : ParseBExpr °(Token~Op Token~Operator~LParen) °⊂
    | BExpr~Not ParseBExpr °(Token~Op Token~Operator~BNot) °⊂
    | Equals⊙(⍩(ParseAExpr)°(⊂Token~Op Token~Operator~Equals)) ParseAExpr
    | Greater⊙(⍩(ParseAExpr)°(⊂Token~Op Token~Operator~Greater)) ParseAExpr
    )
    ⍣(And⊙(⍩(ParseBExpr)°(⊂Token~Op Token~Operator~And)))
  )
  ParseIf! ← |1.2 (
    :ParseBExpr
    °(⊂ Token~KW Token~Keyword~Then)
    :^0
    °(⊂ Token~KW Token~Keyword~Else)
    :^0
    °(⊂ Token~KW Token~Keyword~Fi)
    :⊙(If⊃(⋅⋅∘|⋅⊙◌|⊙⋅◌))
  )
  ParseWhile! ← |1.2 (
    :ParseBExpr
    °(⊂ Token~KW Token~Keyword~Do)
    :^0
    °(⊂ Token~KW Token~Keyword~Od)
    :⊙(While:)
  )
  ParseAsgn ← |1.2 (
    °Token~Id°⊂
    ⊙(ParseAExpr°(⊂ Token~Op Token~Operator~Asgn))
    Asgn
  )
  ParseStatement ← |1.2 (
    ⍣(⍩ParseIf!ParseStatement °(⊂ Token~KW Token~Keyword~If)
    | ⍩ParseWhile!ParseStatement °(⊂ Token~KW Token~Keyword~While)
    | IO °(⊂ Token~KW Token~Keyword~IO)
    | Skip °(⊂ Token~KW Token~Keyword~Skip)
    | ⍩ParseAsgn
    )
    ⍣(Seq⊙(ParseStatement °(⊂Token~Op Token~Operator~Seq)))
  )
  Run ← (
    Tokenizer!(
      New
      Run:
    )
    ˜⊂(Token~EOI)
    ParseStatement
    ⊙(⍤ "Did not consume full input"=1⧻)
  )
└─╴
