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
   int Magic_Number = 808;                                        // Private Number
   
   // ----------------------------------------------------------------+
   // Update Weights
   // ResetWeights();
   InitWeights();                                                 // Method in PerceptronsData 
   
   Print("JOUNIN Daniels!!"); 
   
//---
   return(INIT_SUCCEEDED);
  }

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   // OnTickControl();                                             // Method to implement all validation for each operation in ControlBot class
   
   double RSIn = RSIPerceptron();
   double CCIn = CCIPerceptron();
   double ATRn = ATRPerceptron();
   
   //OnRSI();
   OnCCI();
   
   string comentary =  "Jounin Testing Perceptrons RSI | CCI | ATR" + ".-." + IntegerToString(808) + ".-." + 
                       "\nDaniels: WIZARD SUPER CLASS!_! " + "Month: " + IntegerToString(GlobalVariableGet("LastMonth")) + " Day: " + IntegerToString(GlobalVariableGet("LastDay")) +
                       "\nThis is active session: " + IntegerToString(SessionHour(ActiveSesion)) +  
                       "\nCan Operate: " + IntegerToString(CanOperate) +
                       "\n" +
                       "\nRSI Network: " + DoubleToStr(RSIn) +
                       "\nRSI WEIGHTS:" +
                       "\nW1: " + DoubleToStr(w1) +
                       "\nW2: " + DoubleToStr(w2) +
                       "\nW3: " + DoubleToStr(w3) +
                       "\nW4: " + DoubleToStr(w4) +
                       "\n" +
                       "\nCCI Network: " + DoubleToStr(CCIn) +
                       "\nCCI WEIGHTS:" +
                       "\nW11: " + DoubleToStr(w11) +
                       "\nW22: " + DoubleToStr(w22) +
                       "\nW33: " + DoubleToStr(w33) +
                       "\nW44: " + DoubleToStr(w44) +
                       "\n" +
                       "\nATR Network: " + DoubleToStr(ATRn) +
                       "\nATR WEIGHTS:" +
                       "\nW111: " + DoubleToStr(w111) +
                       "\nW222: " + DoubleToStr(w222) +
                       "\nW333: " + DoubleToStr(w333) +
                       "\nW444: " + DoubleToStr(w444)
                       ;
   
   
   Comment( comentary );
  
   
  }














