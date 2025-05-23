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
   OnTickControl();                                             // Method to implement all validation for each operation in ControlBot class
   
   // Debug sell operation
   //
   
   //if(High[1] > GetSMA(50) && Close[1] < GetSMA(50) && CalculateRangeNormalized() > 1.0){
   
   //  StopTake method = GetStopAndTake(1,2,4);         // First: Calculate stop and take distance. Parameters: take and stop multiplier
      
   //  double risk = Risk(1.0);                         // Second: Here put risk in double.         Parameter: cant of risk in double 
   //  double lotes = LotsSize(risk,method.range);      // Three: Lots size calc.                   Parameters: risk calc, pisp distance that result in "StopAndTake" method
     
   //  OpenTrade(1,lotes,method.stop,method.take,808);  // Four: Open trade:                        Parameters: type order, lots, stop distance, take distance, magic number
     
   //}
   
   //if(Low[1] < GetSMA(50) && Close[1] > GetSMA(50) && CalculateRangeNormalized() > 1.0){
   
   //  StopTake method = GetStopAndTake(0,2,4);         // First: Calculate stop and take distance. Parameters: take and stop multiplier
     
   //  double risk = Risk(1.0);                         // Second: Here put risk in double.         Parameter: cant of risk in double 
   //  double lotes = LotsSize(risk,method.range);      // Three: Lots size calc.                   Parameters: risk calc, pisp distance that result in "StopAndTake" method
     
   //  OpenTrade(0,lotes,method.stop,method.take,808);  // Four: Open trade:                        Parameters: type order, lots, stop distance, take distance, magic number
     
     
   //}
   
   
  }














