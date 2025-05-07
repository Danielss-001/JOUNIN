// Define Macros
#ifndef __Indicators__
#define __Indicators__

// Get price in period current
double Price(){
   return iClose(Symbol(),PERIOD_CURRENT,0);                                  // Get Price close in current period   
}

// Movering Avarage Function
// This method is applicate in current period
// Use a int value to implement different periods
double GetSMA(int period){
   
   return iMA(Symbol(),PERIOD_CURRENT,period,0,MODE_SMA,PRICE_CLOSE,0);       // Get iMA Move Avarage 
   
}

// RSI Function
// This method is applicate in current period
// Use a int value to implement different periods 
double GetRSI(int period){

   return iRSI(Symbol(),PERIOD_CURRENT,period,PRICE_CLOSE,0);                 // Get RSI 

}

// CCI Function
// This methoid use in current period
// Use a int value to implement different periods
double GetCCI(int period){

   return iCCI(Symbol(),PERIOD_CURRENT,period,PRICE_CLOSE,0);                 // Get CCI 
   
}

#endif