package ;

import sys.io.File;

import haxe.macro.Expr;

import haxeparser.HaxeLexer;

import haxeparser.Data.Token;
import haxeparser.Data.TokenDef;

import checkstyle.TokenTree;
import checkstyle.TokenTreeBuilder;

class TokenTest {
    public static inline var TOKENTREE_BUILDER_TEST:String = "
/*
* üä
*/
class Test {
  public function new ()
  {}
}";

    public static function main() {

        var code = TOKENTREE_BUILDER_TEST;
        var tokens:Array<Token> = [];
        var lexer = new HaxeLexer(byte.ByteData.ofString(code), "test.hx");
        var t:Token = lexer.token(HaxeLexer.tok);

        while (t.tok != Eof) {
            tokens.push(t);
            t = lexer.token(haxeparser.HaxeLexer.tok);
        }

        var root:TokenTree = TokenTreeBuilder.buildTokenTree(tokens);
        trace(root);
    }
}