true (TRUE)
false (FALSE)
digit [0-9]
char [A-Za-z]
charOrDigit ({digit}|{char})
spaceOrTab [ \t]
varID (VAR)
consID (CONS)
and "&&"
or "||"
implies "->"
not "~"
lp "("
rp ")"
lbrace "{"
rbrace "}"
if (IF)
else (ELSE)
return (RETURN)
comma ","
callerID (FUNC)
assignment (=)
while (WHILE)
output (OUTPUT)
input (INPUT)
listID (LIST)
lsquare "["
rsquare "]"
main (MAIN)
nl "\n"

%%
{digit}+ { return (INTEGER); }

{true} { return (TRUE); }
{false} { return (FALSE); }

{callerID}{spaceOrTab}+{char}{charOrDigit}* { sscanf(yytext, "%s", &yylval.str); return (PREDICATE); }

{consID}{spaceOrTab}+{char}{charOrDigit}* { sscanf(yytext, "%s", &yylval.str); return (CONSTANT); }

{varID}{spaceOrTab}+{char}{charOrDigit}* { sscanf(yytext, "%s", &yylval.str); return (VARIABLE); }

{listID}{spaceOrTab}+{char}{charOrDigit}* { sscanf(yytext, "%s", &yylval.str); return (LIST); }

{main} { return (MAIN); }
{and} { return (AND); }
{or} { return (OR); }
{implies} { return (IMPLIES); }
{not} { return (NOT); }
{lp} { return (LP); }
{rp} { return (RP); }
{lbrace} { return (LBRACE); }
{rbrace} { return (RBRACE); }
{if} { return (IF); }
{else} { return (ELSE); }
{return} { return (RETURN); }
{comma} { return (COMMA); }

{assignment} { return (ASSIGNMENT); }
{while} { return (WHILE); }
{output} { return (OUTPUT); }
{input} { return (INPUT); }
{lsquare} { return (LSQUARE); }
{rsquare} { return (RSQUARE); }

{nl} {extern int lineno; lineno++; return (NL); }

"." { return (yytext[0]); }
%%
int yywrap() { return 1; }