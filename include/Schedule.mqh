// Here implement hours

#ifndef __SCHEDULE__
#define __SCHEDULE__

// EXTERN VARIABLES
// IMPORTANT
// Use the Schedule the broker hours | ST.Petersburgh
extern int    ActiveSesion      = 1;      // 1 = LONDON, 2 = TOKIO, 3 = NEW_YORK
extern double MaxProfitPerDay   = 2.0;    // Percentage profit day
extern double MaxLossPerDay     = 2.0;    // Percentage loss day
extern double MaxProfitPerMonth = 5.0;    // Max profit per month
extern double MaxLossPerMonth   = 3.0;    // Max Loss per month

/////////////////////////////////////////////////////////////////////////
// Create percentage calculate method for use in MaxProfit and MaxLoss //
/////////////////////////////////////////////////////////////////////////

enum sesion {
  LONDON  = 1,
  TOKIO   = 2, 
  NEWYORK = 3  
};

bool CanOperate = false;                     // Control variable if is possible operate | Depends of profit limits


////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void ScheduleTick(){
   
   // Second check if the day adn month for can operate
   CheckNewDay();
   CheckNewMonth();
   
   // Third get profit limit calculate
   ProfitLimitDay();
   ProfitLimitMonth();

}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
double PercentageInAccount(double risk){                             // Risk calculator
   
   double Risk = AccountBalance() * (risk/ 100);
   return Risk;
   
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Verification new day in each tick
void CheckNewDay(){
 
   if(!GlobalVariableCheck("LastDay")){
      GlobalVariableSet("LastDay",Day());
      CanOperate = true;
      return;
   }
     
   int lastDay      = (int)GlobalVariableGet("LastDay");
   int currentDay   = Day();
   
   if(lastDay != currentDay){                   // If is different day, update day and can operate in true

      GlobalVariableSet("LastDay", currentDay);
      CanOperate   = true;
   
   }
}

// Verification new month in each tick
void CheckNewMonth(){
   
   if(!GlobalVariableCheck("LastMonth")){
      GlobalVariableSet("LastMonth",Month());
      CanOperate = true;
      return;
   }
   
   int lastMonth    = (int)GlobalVariableGet("LastMonth");   
   int currentMonth = Month();                  // Get current Month  variable

   if(lastMonth != currentMonth){               // Check if is different month, update month and can operate in true
      
      GlobalVariableSet("LastMonth", currentMonth);
      CanOperate = true;
   }
   
}

bool SessionHour(int activeSession){         // if is possible operate in active session

   bool result;
   
   switch (activeSession){
      case 1 : 
         result = (Hour() >= 10 && Hour() <= 18) ? true : false;
         break;
      case 2:
         result = (Hour() >= 2 && Hour() <= 10)  ? true : false;
         break;
      case 3:
         result = (Hour() >= 15 && Hour() <= 23) ? true : false;
         break;
      default:
         Print("This value ActiveSession is invalid");
   }
   
   return result;
   
}

// in each tick check profit in the day
double GetProfit(datetime fromTime){

   double profit = 0;
   
   for(int i=OrdersHistoryTotal()-1; i >= 0; i--){
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)){
         if(OrderSymbol() == Symbol()){
            if(OrderCloseTime() >= fromTime){
               profit += OrderProfit() + OrderSwap() + OrderCommission();
            }
            else {
               break;
            }
         }
      }
   }  
   
   return profit;

}

// Check if can operate with profit limits in each tick
void ProfitLimitDay(){
   
   double profitToday     = GetProfit(StrToTime(TimeToString(TimeCurrent(),TIME_DATE)));
   double maxProfitPerDay = PercentageInAccount(MaxProfitPerDay);
   double maxLossPerDay   = -PercentageInAccount(MaxLossPerDay);
   
   if(profitToday >= maxProfitPerDay || profitToday <= maxLossPerDay){ CanOperate = false; }

}

void ProfitLimitMonth(){

   double profitMonth     = GetProfit(StrToTime(StringFormat("%d.%02d.01",TimeYear(TimeCurrent()),TimeMonth(TimeCurrent()))));
   double maxProfitMonth  = PercentageInAccount(MaxProfitPerMonth);
   double maxLossMonth    = -PercentageInAccount(MaxLossPerMonth);
   
   if(profitMonth >= maxProfitMonth || profitMonth <= maxLossMonth){ CanOperate = false; }
}



#endif