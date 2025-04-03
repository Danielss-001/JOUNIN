//+------------------------------------------------------------------+
//|                                                 TradeManager.mqh |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property strict
//+------------------------------------------------------------------+
//| TradeManager Order Manager                                       |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+

// Macros define
#ifndef __TRADEMANAGER_MQH__
#define __TRADEMANAGER_MQH__


// This method calculate the risk per operation in 1%
double Risk(){
   
   // Risk per operation 
   double risk_percentage = 1.0;                                                  // 1%
   double risk_amount = AccountBalance() * (risk_percentage / 100);               // Risk calculate in one percentage per operation (1%)
   
   return risk_amount;                                                            // Return risk for calculate in each "TICK"                 
}

// Method operation manager:
// In this method open order depend if order is BUY or SELL
// This method is Dynamic, and used in diferent circumstances
void OpenTrade(int typeOrder, double lotSize, int slPips, int tpPips, int magicNumber){
   
   double sl,tp;                                                                  // I Declare a StopLoss and TakeProfit variables            
   double price = (typeOrder == OP_BUY) ? Ask : Bid;                              // If "typeOrder" is equal OP_BUY or OP_SELL 
   
   // Configure SL and TP depend of the "typeOrder"... We Used Point variable for calculate minim movement in currency pair    
   sl = (typeOrder == OP_BUY) ? price - slPips * Point : price + slPips * Point;  // Calculate stop loss using boolean condition(Dynamic variable). 
   tp = (typeOrder == OP_BUY) ? price + tpPips * Point : price - tpPips * Point;  // Calculate take profit using boolean condition.
   
   // Execute order 
   int ticket = OrderSend(Symbol(),                                               // Current Symbol
                          typeOrder,                                              // Order Type
                          lotSize,                                                // Lots size
                          price,                                                  // price
                          3,                                                      // Slippage
                          sl,                                                     // Stop 
                          tp,                                                     // Take
                          NULL,                                                   // Any comment
                          magicNumber,                                            // Magic number | ID 
                          0,                                                      // Time expiration 
                          clrBlue);                                               // Implement Ticket order that throws order to market
   
   // Check if the ticket or order is throws to market
   // If True, coment "Open Order". Else, throws error.
   if(ticket > 0){
      Print("Open Order!", ticket);
   } else {
      Print("Error Order!!", GetLastError());
   }
   
}

#endif

