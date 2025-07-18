// Define Macros
#ifndef __CONTROL__
#define __CONTROL__

#include "./TEST.mqh"
#include "./TradeManager.mqh"                                                  // Include of the TradeManager
#include "./Indicators.mqh"
#include "./PerceptronsData.mqh"
#include "./Schedule.mqh"

extern int EMA = 50;                                  //Here is the EMA value.

// Show anything data in init event bot
void ShowData(int stop_Loss){

   Print("the balance is: ", AccountBalance());
   Print("The lots per transaction is: ", LotsSize(Risk(1),stop_Loss));
   Print("The risk is: ",Risk(1));
}

// Here, Find method control a open or manage orders
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void OnRSI(){
   
   int op;
   StopTake st;
   double risk;
   double lots;
   
   // This call schedule function limits and manage money
   ScheduleTick();
   
   if(OrdersTotal() == 0){             
      if(CanOperate){          // If is session active and CanOPerate
   
         double signal     = RSIPerceptron();
         double volatility = ATRPerceptron();
      
         string comment;
         
         if(signal > 0.5 ){                                 // Buy perceptron
         
            op = 0;                                         // Buy order type
            Print("BUY!!");
         
            if(volatility > 0.3 && volatility < 0.8){       // ATR Perceptron
         
         
               if(Low[1] < GetSMA(EMA) && Close[1] > GetSMA(EMA)){
            
                  st   = (signal > 0.7) ? GetStopAndTake(op,1,2) : GetStopAndTake(op,1,1);      
                  risk = (signal > 0.7) ? Risk(2.0) : Risk(1.0);
                  lots = LotsSize(risk,st.range);
                  
                  // Comment CCI entire
                  comment = StringFormat("RSI:%.2f ATR=%.2f", signal, volatility);
                  
                  OpenTrade(op,lots,st.stop,st.take,comment,808);
               }
            }
         }
      
         // SELL SIGNAL
         if(signal < -0.5){                                 // Sell perceptron
         
            op = 1;
            Print("SELL!!");
         
            if(volatility > 0.3 && volatility < 0.8){       // Volatility perceptron
         
               if(High[1] > GetSMA(EMA) && Close[1] < GetSMA(EMA)){
            
                  st = (signal < -0.7) ? GetStopAndTake(op,1,2) : GetStopAndTake(op,1,1);       
                  risk = (signal < -0.7) ? Risk(2.0) : Risk(1.0);
                  lots = LotsSize(risk,st.range);
                  
                  // Comment CCI entire
                  comment = StringFormat("RSI:%.2f ATR=%.2f", signal, volatility);
                  
                  OpenTrade(op,lots,st.stop,st.take,comment,808);
               }
            }
         }
   
   
      }
   }
   

}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
void OnCCI(){
   
   int op;
   StopTake st;
   double risk;
   double lots;
   
   // limits and money control
   ScheduleTick();
   
   if(CanOperate){          // If CanOPerate
      if(OrdersTotal() == 0){
   
         double signal     = CCIPerceptron();
         double volatility = ATRPerceptron();
         
         string comment;
         
         if(signal > 0.5){                                 // Buy Signal using CCI perceptron 
         
            op = 0;                                         // Buy order type
            Print("BUY!!");
         
            if(volatility > 0.3 && volatility < 0.8){
         
               if(Low[1] < GetSMA(EMA) && Close[1] > GetSMA(EMA)){
            
                  st   = (signal > 0.7) ? GetStopAndTake(op,1,2) : GetStopAndTake(op,1,1);      // signal > 0.7
                  risk = Risk(1.0);                                                             // signal > 0.7
                  lots = LotsSize(risk,st.range);
                  
                  // Comment CCI entire
                  comment = StringFormat("CCI:%.2f ATR=%.2f", signal, volatility);
                  
                  OpenTrade(op,lots,st.stop,st.take,comment,808);
               }
            }
         }
         if(signal < -0.5){                                 // Sell perceptron
         
            op = 1;
            Print("SELL!!");
         
            if(volatility > 0.3 && volatility < 0.8){       // Volatility perceptron
         
               if(High[1] > GetSMA(EMA) && Close[1] < GetSMA(EMA)){
            
                  st   = (signal < -0.7) ? GetStopAndTake(op,1,2) : GetStopAndTake(op,1,1);       // signal < - 0.7
                  risk = Risk(1.0);                                                               // signal < - 0.7
                  lots = LotsSize(risk,st.range);
                  
                  // Comment CCI entire
                  comment = StringFormat("CCI:%.2f ATR=%.2f", signal, volatility);
                  
                  OpenTrade(op,lots,st.stop,st.take,comment,808);
               }
            }
         }
   
   
      }
   }
   
}

#endif