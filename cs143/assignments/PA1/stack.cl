(*
 *  CS164 Fall 94
 *
 *  Programming Assignment 1
 *    Implementation of a simple stack machine.
 *
 *  Skeleton file
 *)

class Stack {
	
	item: String;
	contents: Stack;
	
	getItem(): String {
		item
	};

	getContents(): Stack {
		contents
	};

	pop(): Stack {
		contents
	};
	
	init (item_n: String,contents_n: Stack): Stack {
		{
			item <- item_n;
			contents <- contents_n;
			self;
		}
	};

	insert (item_n: String,index: Int): Stack {
		let nil: Stack in {
			if(index = 0)
			then {
				init(item_n,nil);
				self;
			}
			else (new Stack).init(item_n,self)
			fi;
		}
	};
	
	stringBuilder (): String {
		{
			if(isvoid contents)
			then item.concat("\n")
			else item.concat("\n").concat(contents.stringBuilder())
			fi;
		}	
	};

	display(): Int {
		{
			(new IO).out_string(stringBuilder());
			0;
		}
	};
	
	add(): Stack {
		let pckg1: A2I <-(new A2I),val1: Int,val2: Int in{
			val1 <- pckg1.a2i(item);
			val2 <- pckg1.a2i(contents.getItem()) + val1;
			(new Stack).init(pckg1.i2a(val2),contents.getContents());
		}
	};

	swap(): Stack {
		let val2: String, val1: String in {
			val1 <- item;
			val2 <- contents.getItem();
			(new Stack).init(val2,(new Stack.init(val1,contents.getContents())));
		}
	};
	
};

class StackCommand inherits IO {
	
	index: Int <- 0;
	pckg1: A2I <- (new A2I);
	main: Stack <- (new Stack);

	execute(a: String) : Int {
		{
			if(a = "e")
			then {
				if(main.getItem() = "+")
				then {
					main <- main.pop();
					main <- main.add();
				}
				else {
					if(main.getItem() = "s")
					then {
						main <- main.pop();
						main <- main.swap();
					} else ""
					fi;
				}
				fi;
			}
			else {
				if(a = "d")
				then main.display()
				else {
					main <- main.insert(a,index);
					index <- index + 1;
				}
				fi;
			}
			fi;
			0;
		}
	};

};

class Main inherits IO {
	
	main(): Int {
		let stackcmd: StackCommand <- (new StackCommand),chr: String <- "" in{
			while (not (chr = "x")) loop
				{
					out_string(">");
					chr <- in_string();
					stackcmd.execute(chr);
				}
			pool;
			0;
		}
	};
};

