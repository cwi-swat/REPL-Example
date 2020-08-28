module CalcREPL

import IO;
import String;
import Content;
import Exception;
import Syntax;
import ParseTree;


import util::REPL;


REPL myRepl() {
  Env env = ();
  
  Content myHandler(str input) {
    try {
    	// Parsing the input snippet
    	Syntax::Cmd cmd = parse(#start[Cmd], input).top;
    	
    	if ((Cmd)`show <Exp e>` := cmd) {
 			return text("<e>");
		}
		else {
      		<env, n> = exec(cmd, env);
      		return text("<n>");
      	}
    }
    catch ParseError(loc l):
    	return text("Error");
  }

  Completion myCompletor(str prefix, int offset)
    =  <0, [ x | x <- env, startsWith(x, prefix) ]>; 

	return repl(title = "Calc REPL", welcome = "Welcome to the Calc REPL", prompt = "\nIn: ",handler = myHandler, completor = myCompletor);
}
