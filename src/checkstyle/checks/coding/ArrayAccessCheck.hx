package checkstyle.checks.coding;

import haxe.macro.Expr;
import checkstyle.utils.ExprUtils;

@name("ArrayAccess")
@desc("Spacing check on array access")
class ArrayAccessCheck extends Check {

	public var spaceBefore:Bool;
	public var spaceInside:Bool;

	public function new() {
		super(AST);
		spaceBefore = false;
		spaceInside = false;
	}

	override function actualRun() {
		var lastExpr = null;

		ExprUtils.walkFile(checker.ast, function(e:Expr) {
			if (lastExpr == null) {
				lastExpr = e;
				return;
			}

			switch (e.expr) {
				case EArray(e1, e2):
					if (!spaceBefore) {
						var e1length = e1.pos.max - e1.pos.min;
						var eString = checker.getString(e.pos.min, e.pos.max);
						if (eString.substr(e1length, 1) == " ") logPos('Space between array and [', e.pos);
					}

					if (!spaceInside) {
						var eString = checker.getString(e.pos.min, e.pos.max);
						if (checker.file.content.substr(e2.pos.min - 1, 1) == " ") logPos('Space between [ and index', e.pos);
						if (checker.file.content.substr(e2.pos.max, 1) == " ") logPos('Space between index and ]', e.pos);
					}
				default:
			}

			lastExpr = e;
		});
	}
}