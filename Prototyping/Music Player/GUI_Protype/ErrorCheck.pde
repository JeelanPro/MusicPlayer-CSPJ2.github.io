// Variables

// Functions to catch errors... super helpful for debugging!
void catchError() {
  println("Welcome to CatchError function");
  println("This function is design for testing and debuging code without ide");
  println("\n\n...\n");
  println("Error: No Variable or Value is provided");
  println("Please Include some Variables or Value to see the result");
  println("\n");
}

void catchError(String text) {
  println(text);
}

void catchError(String text, Boolean variable) {
  println(text);
  println("Value for second Parm is:");
  println(variable);
}

void catchError(String text, int variable) {
  println(text, variable);
  println("Value for second Parm is:");
  println(variable);
}

void catchError(String text, float variable) {
  println(text, variable);
  println("Value for second Parm is:");
  println(variable);
}

void catchError(String text, int var1, float var2) {
  println(text);
  println("Value for second Parm is:");
  println(var1);
  println("Value for third Parm is:");
  println(var2);
}

void catchError(String text, float var1, float var2) {
  println(text);
  println("Value for second Parm is:");
  println(var1);
  println("Value for third Parm is:");
  println(var2);
}

void catchError(String text, float var1, int var2) {
  println(text);
  println("Value for second Parm is:");
  println(var1);
  println("Value for third Parm is:");
  println(var2);
}

void catchError(String name, float[] array) {
  println("\nThe " + name + " are below: ");
  println("=============" + name + "=============");
  printArray(array);
  println("=============" + name + "=============");
}

void catchError(float[] array) {
  println("\nThe result are below: ");
  println("=============" + "list" + "=============");
  printArray(array);
  println("=============" + "list" + "=============");
}
