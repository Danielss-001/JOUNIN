//+------------------------------------------------------------------+
//| TradeManager Order Manager                                       |
//+------------------------------------------------------------------+

// +-----------------------------------------------------------------+
// | 1). Implement stop and take, depend typeOrder                   | 
// | 2). Assign risk                                                 |
// | 3). Implement Lots Size                                         |
// | 4). Implement OpenTrade                                         |
// +-----------------------------------------------------------------+

// Macros define
#ifndef __TRADEMANAGER_MQH__
#define __TRADEMANAGER_MQH__


// This method calculate the risk per operation in 1%
double Risk(double risk){                                                         // This value in parameter use a double example 1.0 for one percentage (1%)
   
   // Risk per operation 
   double risk_percentage = risk;                                                 // 1%
   double risk_amount = AccountBalance() * (risk_percentage / 100);               // Risk calculate in one percentage per operation (1%)
   
   return risk_amount;                                                            // Return risk for calculate in each "TICK"                 
}

// --------------------------------------------------------------------------------------------
// Construct the stop and take for use in lotsize and OpenTrade
// This struct is used in GetStopAndTake method. 
struct StopTake {
   double stop;
   double take;
   int range;
};

// This method modify the stop and take, include the range for implement in lots size 
// This method return a struct for use in next methods as parameters
StopTake GetStopAndTake(int typeOrder, int stopControl, int takeControl){         // The typeOrder and stopControl as takeControl is handle to bot
   
   StopTake st;                                                                   // Here implement struct variable 
   
   // The next values are boolean variables for dynamic, depend if buy and sell
   // The construct to Stop Loss, Range distance, and Take Profit
   st.stop      = (typeOrder == OP_BUY)     ? Low[1] - (10 * stopControl) * Point    : High[1] + (10 * stopControl) * Point;
   double range = (typeOrder == OP_BUY)     ? MathAbs(st.stop - Ask) / Point         : MathAbs(st.stop - Bid) / Point;
   st.range     = (int)range/10;
   st.take      = (typeOrder == OP_BUY)     ? Ask + (st.range * takeControl) * Point : Bid - (st.range * takeControl) * Point;
      
   return st;
}

// Method calculate range with volatily
double CalculateRangeNormalized(){
   
   double atr = iATR(Symbol(),0,14,1);                                           // Use ATR for measure absolute volatily in 14 periods
   double range = High[1] - Low[1];                                              // Measure difference in high and low the last candle
   
   return range/atr;                                                             // Return range normalized
   
}



// --------------------------------------------------------------------------------------------

// Method for calculate lots based on risk per transaction
// Here, use the "MarketInfo" function, for get tick value of the pair
// IMPORTANT: Calculate the pip size with 10 * Point (the min movement of the pair)
// Using the risk / (pip_value * stop_loss)
// Don´t forget normalize double before to return value
// first: tick_value. second: pip_size. third: pip_value.
double LotsSize(double risk, int slRange){
   
   ///////////////////////////////////////////////
   double tickValue = MarketInfo(Symbol(), MODE_TICKVALUE);                        // Get tick value
   double pipSize = 10 * Point;                                                   // Calculate the pip size with the math calculate "10 * Point"
   double pipValue = tickValue / Point * pipSize ;                                // The use of the "tick_value" / "Point" * "Pip_size" is equal the value to each pip
   ///////////////////////////////////////////////
   
   double lots = risk /(pipValue * slRange);                                       // Use the math operation
   
   return NormalizeDouble(lots,2);                                                // Return value normalized
   

}

// Method operation manager:
// In this method open order depend if order is BUY or SELL
// This method is Dynamic, and used in diferent circumstances
void OpenTrade(int typeOrder, double lotSize, double sl, double tp, int magicNumber){
   

   double price = (typeOrder == OP_BUY) ? Ask : Bid;                              // If "typeOrder" is equal OP_BUY or OP_SELL 
   
   
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

