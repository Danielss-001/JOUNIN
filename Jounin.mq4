//+------------------------------------------------------------------+
//|                                                       Jounin.mq4 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

//+------------------------------------------------------------------+
//| Expert Advisor - Trading Bot                                     |
//+------------------------------------------------------------------+
#include "./include/TradeManager.mqh"                                          // Include of the TradeManager


extern string text_in; 

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
   
   
   Print("the balance is: ", AccountBalance());
   Print("The risk is: ",Risk());
   
//---
   return(INIT_SUCCEEDED);
  }

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
    DrawTextInGraph(text_in);
   
  }







//////////////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//|  Here, Put The differents functions (METHODS)                    |
//+------------------------------------------------------------------+
//////////////////////////////////////////////////////////////////////

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


