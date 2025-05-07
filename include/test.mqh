#ifndef TEST
#define TEST

// This method Draw the text in the graph
void DrawTextInGraph(string new_text,int distance_X = 10, int distance_Y = 30){
   
   // Create new object
   bool obj_exist = ObjectCreate(0,"My Text Label",OBJ_LABEL,0,0,0);                            // Create a object with the type object
   
   if(obj_exist){                                                                               // Check if the object is created!
      
      // Config size and color object
      ObjectSetText("My Text Label",new_text,15,"Arial",clrBlack);
      
      // Posicion text in the graph
      ObjectSetInteger(0,"My Text Label",OBJPROP_CORNER,CORNER_LEFT_UPPER);                     // Corner Left Upper position
   }
}

#endif 