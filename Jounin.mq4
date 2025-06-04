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

#include "./include/ControlBot.mqh"

// Here implement dll library
#import "Ronin.dll"
   int Suma(int a, int b);
   
#import

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   //DrawTextInGraph("Daniel is here!!");
   
   int Magic_Number = 808;                                        // Private Number
   
   Print("RONIN!!"); 
   
//---
   return(INIT_SUCCEEDED);
  }

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   OnTickControl();                                             // Method to implement all validation for each operation in ControlBot class
   
   Comment("Jounin " + IntegerToString(808) + "\nDaniels made fucker!" );
  
   
  }














