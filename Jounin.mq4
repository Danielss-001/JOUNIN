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





//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   //DrawTextInGraph("Daniel is here!!");
   
   int Magic_Number = 808;                                          // Private Number
   
   
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
   
   StopTake method = GetStopAndTake(0,1,2);
   double risk = LotsSize(Risk(1),method.range);
   
   // Print("risk: ", risk);
   // Print("Distance: ",method.range);
   // Print("Range normalized: ",CalculateRangeNormalized());
  }














