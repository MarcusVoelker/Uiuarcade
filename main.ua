LVA ~ "lva.ua"
~ "parser.ua" ~ Parser
~ "cfa.ua" ~ CFA

Parser~Run "if 16 > i1 then x := i2; o := x else x := i3; o := x fi"
CFA~MakeCFA
LVA~Run {"i1" "i2" "i3"} {"o"}
