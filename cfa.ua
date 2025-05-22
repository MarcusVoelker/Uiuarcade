~ "ir.ua" ~ AExpr BExpr Frag Stmt

┌─╴CFA
  ┌─╴Edge
    ~ {Source Label Dest}
  └─╴
  ~ {Vertices Edges Entry Exit}
  FromSkip ↚ (
    °Stmt~Skip
    CFA⊃([⊃(∘|+1)]|[Edge⊃(∘|Frag~Skip|+1)]|∘|+1)
  )
  FromIO ↚ (
    °Stmt~IO
    CFA⊃([⊃(∘|+1)]|[Edge⊃(∘|Frag~IO|+1)]|∘|+1)
  )
  FromAsgn ↚ (
    CFA⊃([⊃(∘|+1)]|[Edge⊃(∘|Frag~Assign⋅°Stmt~Asgn|+1)]|∘|+1):
  )
  EdgeRep ↚ (
    ⊃(⨬(⊙◌|⋅∘)⤚≍:⊙:⊙⊙Edge~Source
    | ⋅⋅Edge~Label
    | ⨬(⊙◌|⋅∘)⤚≍:⊙:⊙⊙Edge~Dest)
    CFA~Edge
  )
  FromSeq! ↚ (
    ^0⊙:°Stmt~Seq
    ⊙(^0:+1)⟜Exit
    ⊃(▽¬⊸⌕⊃(Exit|⊂∩Vertices)
    | ≡EdgeRep⊃(Exit|⋅Entry|⊂∩Edges)
    | Entry
    | ⋅Exit
    )
    CFA
  )
  FromIf! ↚ (
    ⊃(^0⊃(Stmt~If~Then|⋅(+1))|Stmt~If~Else|Stmt~If~Cond|⋅∘)
    ⊃(∘|^0⊃(⋅∘|+1Exit)|⋅⋅∘)
    ⊃(▽¬⊸⌕⊃(Exit|⊂⊂⊃(⋅⋅⋅∘|Vertices|⋅Vertices))
    | ⊂⊃(
        [∩Edge⊃(⋅⋅⋅∘|Frag~Assume ⋅⋅∘|Entry|⋅⋅⋅∘|Frag~Assume BExpr~Not ⋅⋅∘|⋅Entry)]
      | ≡EdgeRep⊃(Exit|⋅Exit|⊂⊃(Edges|⋅Edges)))
    | ⋅⋅⋅∘
    | ⋅Exit
    )
    CFA
  )
  FromWhile! ↚ (
    ⊃(^0⊃(Stmt~While~Body|⋅(+1))|Stmt~While~Cond|⋅∘)
    ⊃(▽¬⊸⌕⊃(Exit|⊂⊂⊃(⋅⋅∘|Vertices|+1Exit))
    | ⊂⊃(
        [∩Edge⊃(⋅⋅∘|Frag~Assume ⋅∘|Entry|⋅⋅∘|Frag~Assume BExpr~Not ⋅∘|+1Exit)]
      | ≡EdgeRep⊃(Exit|⋅⋅∘|Edges))
    | ⋅⋅∘
    | +1Exit
    )
    CFA
  )
  MakeFrom ↚ |2 (
    ⍣(FromSkip
    | FromIO
    | FromAsgn
    | FromSeq!MakeFrom
    | FromIf!MakeFrom
    | FromWhile!MakeFrom
    )
  )
  MakeCFA ← (
    MakeFrom :0
    ⍜°CFA⊃(|⊙⋅⋅◌|⊂⊙(CFA~Edge :Frag~IO:)⋅⊙⊙∘|⋅⋅⊙∘)
  )
  Reverse ← ⍜Edges≡⍜°Edge⊃(⋅⋅∘|⋅⊙◌|⊙⋅◌)
└─╴
