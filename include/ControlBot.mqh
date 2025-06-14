// Define Macros
#ifndef __CONTROL__
#define __CONTROL__

#include "./TEST.mqh"
#include "./TradeManager.mqh"                                                  // Include of the TradeManager
#include "./Indicators.mqh"
#include "./PerceptronsData.mqh"

// Show anything data in init event bot
void ShowData(int stop_Loss){

   Print("the balance is: ", AccountBalance());
   Print("The lots per transaction is: ", LotsSize(Risk(1),stop_Loss));
   Print("The risk is: ",Risk(1));
}

// Here, Find method control a open or manage orders
void OnTickControl(){

   int op;
   StopTake st;
   double risk;
   double lots;

   if(OrdersTotal() == 0){
      
       if(GetRSI(14) > 50 && GetCCI(14) > 70){       // Test in BUY || Simulate perceptrons SubRed indicators "If is Buy" 
         
         op = 0;                                      // Here implement the enum(int) for use OP Order Properties. IMPORTANT 0 value is BUY
         Print("Buy");
         
         if(Low[1] < GetSMA(50) && Close[1] > GetSMA(50) && CalculateRangeNormalized() > 1.0){       // Here, calculate the volatility more that 1.0 high volatility
            
            st = GetStopAndTake(op,1,2);           // Here, implement stop and take using the multiply parameters in the stop and take. REMEMBER the take control, multiply stop range
            risk = Risk(1.0);                      // Implement the risk per trade
            lots = LotsSize(risk,st.range);        // Here, implemenbt lotSize using the risk and range value in integers
            
            OpenTrade(op,lots,st.stop,st.take,808);// Open order using variables
            
         }
         else{                                     // Descarted order for low Volatility
         
            Print("Descarted order, Low Volatility buy ",CalculateRangeNormalized());// Descarted for Low Volatility 
            
         }
         
       }
       else if(GetRSI(14) < 50 && GetCCI(14) < -70){  // Test in SELL || Simulate perceptrons SubRed indicators "If is Sell"
           
           
         op = 1;                                   // Here implement the enum(int) for use OP Order Properties. IMPORTANT 1 value is SELL
         Print("Sell");
         
         if(High[1] > GetSMA(50) && Close[1] < GetSMA(50) && CalculateRangeNormalized() > 1.0){     // Here, Calculate the volatility more that 1.0 high volatility
                  
            st = GetStopAndTake(op,1,2);           // Here, implement stop and take using the multiply parameters in the stop and take. REMEMBER the take control, multiply stop range
            risk = Risk(1.0);                      // Implement the risk per trade
            lots = LotsSize(risk,st.range);        // Here, implemenbt lotSize using the risk and range value in integers
                     
            OpenTrade(op,lots,st.stop,st.take,808);// Open order using variables
         
         }
         else{                                      // Descarted order for low Volatility
         
            Print("Descarted order, Low Volatility sell ", CalculateRangeNormalized());// Descarted for Low Volatility 
         
         }
         
       }    
   }
   
   
}

#endif