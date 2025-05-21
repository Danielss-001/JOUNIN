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
#import "Network.dll"
   int SumInt(int a, int b);
#import


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   //DrawTextInGraph("Daniel is here!!");
   
   int Magic_Number = 808;                                        // Private Number
   
   int total = SumInt(3,3);                                       // Call function in .dll
   
   Print("Total from .dll: ", total);
   
//---
   return(INIT_SUCCEEDED);
  }

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   //OnTickControl();                                             // Method to implement all validation for each operation in ControlBot class
   
   
   StopTake method = GetStopAndTake(1,2,3);
   if(High[1] > GetSMA(50) && Close[1] < GetSMA(50) && CalculateRangeNormalized() > 1.0){
      
     Print("stop ", method.stop);
     Print("take ", method.take);
     Print("Bid ",Bid);
     Print("range: ", method.range);
     
   }
   
   
   // double risk = LotsSize(Risk(1),method.range);
   
   // Print("risk: ", risk);
   // Print("Distance: ",method.range);
   // Print("Range normalized: ",CalculateRangeNormalized());
   
  }














