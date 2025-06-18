// Define Macros
#ifndef __DEPTH_NETWORK__
#define __DEPTH_NETWORK__

#include "Indicators.mqh"

// Remember: if the inputs is negative numbers only divide in 100. However, if the inputs not is negative, is divide in 100 and less 0.5.
// inputs RSI perceptron

// Weights ------------------------weights---------
double w1 = 0.5;
double w2 = 0.5;
double w3 = 0.5;
double w4 = 0.5;
// ------------------------------------------------

double w11 = 0.5;
double w22 = 0.5;
double w33 = 0.5;
double w44 = 0.5;

//---------------------------------------------------

double w111 = 0.5;
double w222 = 0.5;
double w333 = 0.5;
double w444 = 0.5;
//---------------------------------------------------
double RSIPerceptron(){
   
   //  Inputs -------------------------inputs--------
   double a1 = ((GetRSI(7)-50)/50);
   double a2 = ((GetRSI(14)-50)/50);
   double a3 = ((GetRSI(30)-50)/50);
   double a4 = ((GetRSI(50)-50)/50);
   // ------------------------------------------------
   
   // Weighted Sum ---------------------Sum-----------
   double sumWeighted = a1*w1 + a2*w2 + a3*w3 + a4*w4;
   double output = NormalizedRSI(sumWeighted);
   
   // ------------------------------------------------
   
   // TRAINING...
   double target =  (Close[1]<Close[0]) ? 1 : -1 ;    // If change price
   double error  =  target - output;                  // Calculate error with target and output
   double lr = 0.001;                                 // Learning rate
   
   
   if( MathAbs(error) > UmbralAvg(error)){
      
      // Update weights
      w1 += lr * error * a1; 
      w2 += lr * error * a2;
      w3 += lr * error * a3;  
      w4 += lr * error * a4; 
   
      SaveWeightsRSI();
   }
   
   return output;
}

// ---------------------------------------------------
// ---------------------------------------------------
double CCIPerceptron(){
   
   // Inputs ----------------------------inputs-------
   double a1 = NormalizedCCI(GetCCI(7));
   double a2 = NormalizedCCI(GetCCI(14));
   double a3 = NormalizedCCI(GetCCI(30));
   double a4 = NormalizedCCI(GetCCI(50));
   // ------------------------------------------------
      
   // Weighted Sum -------------------------Sum-------
   double output = NormalizedCCI(a1*w11 + a2*w22 + a3*w33 + a4*w44);
   // ------------------------------------------------
   
   // TRAINING...
   double target = (Close[1]<Close[0]) ? 1 : -1;
   double error  = target - output;
   double lr     = 0.001;
   
   if(MathAbs(error) > UmbralAvg(error)){
      
      // Update Weights
      w11 += lr * error * a1;
      w22 += lr * error * a2;
      w33 += lr * error * a3;
      w44 += lr * error * a4;
    
      SaveWeightsCCI();
   }
   
   return output;
   
}

double ATRPerceptron(){

   // Variable use for calculate means number
   // Used for normalized inputs and calculate error 
   double threshold = (Digits == 5 || Digits == 3) ? 0.0005 : 0.05;
   
   // Inputs -----------------------------inputs------
   double a1 = NormalizedATR(GetATR(7));
   double a2 = NormalizedATR(GetATR(14));
   double a3 = NormalizedATR(GetATR(30));
   double a4 = NormalizedATR(GetATR(50));
   // -------------------------------------------------
   
   // Weighted Sum ------------------------------------
   double output = NormalizedATR(a1 * w111 + a2 * w222 + a3 * w333 + a4 * w444);
   
   // TRAINING ----------------------------------------
   double diff   = MathAbs(Close[1]-Close[2]);
   double target = (diff >= threshold) ? 1 : -1;         // If difference price is major or equal to means number ? high volatily : Low volatily
   double error  = target - output;                      // Calculate error
   double lr = 0.001;
   
   if(MathAbs(error) > UmbralAvg(error)){                // If the error is major to umbral error recalculate weights
      w111 += lr * error * a1;
      w222 += lr * error * a2;
      w333 += lr * error * a3;
      w444 += lr * error * a4;
      
      SaveWeightsATR();
   }
    
   
   return output;  
}

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////

double NormalizedRSI(double RSI){
   
   double output = (RSI-50)/50;
   
   if (output < -1.0) output = -1;
   if (output > 1.0) output = 1;
   
   return output;

}

// Normalized CCI 
double NormalizedCCI(double CCI){
   
   double output = CCI/100;
   
   if(output < -1) output = -1;
   if(output > 1)  output = 1;
   
   return output;
}

// Normalized ATR
double NormalizedATR(double ATR){
   // Variable use for calculate means number
   // Used for normalized inputs and calculate error 
   double threshold = (Digits == 5 || Digits == 3) ? 0.0005 : 0.05;
   
   double output = (ATR - threshold)/threshold;
   if (output > 1.0)  output  = 1.0;
   if (output < -1.0) output = -1.0;
   
   return output;
}

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////

// Method Save Weights to RSI 
void SaveWeightsRSI(){
   GlobalVariableSet("RSI_W1",w1);
   GlobalVariableSet("RSI_W2",w2);
   GlobalVariableSet("RSI_W3",w3);
   GlobalVariableSet("RSI_W4",w4);
}

// Method save weights to CCI
void SaveWeightsCCI(){
   GlobalVariableSet("CCI_W11", w11);
   GlobalVariableSet("CCI_W22", w22);
   GlobalVariableSet("CCI_W33", w33);
   GlobalVariableSet("CCI_W44", w44);

}

void SaveWeightsATR(){
   GlobalVariableSet("ATR_W111", w111);
   GlobalVariableSet("ATR_W222", w222);
   GlobalVariableSet("ATR_W333", w333);
   GlobalVariableSet("ATR_W444", w444);
   
}

// Init weights Method 
void InitWeights(){
   
   // RSI Weights
   if(GlobalVariableCheck("RSI_W1")) w1 = GlobalVariableGet("RSI_W1");
   if(GlobalVariableCheck("RSI_W2")) w2 = GlobalVariableGet("RSI_W2");
   if(GlobalVariableCheck("RSI_W3")) w3 = GlobalVariableGet("RSI_W3");
   if(GlobalVariableCheck("RSI_W4")) w4 = GlobalVariableGet("RSI_W4");  
   
   // CCI Weights
   if(GlobalVariableCheck("CCI_W11")) w11 = GlobalVariableGet("CCI_W11");
   if(GlobalVariableCheck("CCI_W22")) w22 = GlobalVariableGet("CCI_W22");
   if(GlobalVariableCheck("CCI_W33")) w33 = GlobalVariableGet("CCI_W33");
   if(GlobalVariableCheck("CCI_W44")) w44 = GlobalVariableGet("CCI_W44");  
   
   // ATR Weights
   if(GlobalVariableCheck("ATR_W111")) w111 = GlobalVariableGet("ATR_W111");
   if(GlobalVariableCheck("ATR_W222")) w222 = GlobalVariableGet("ATR_W222");
   if(GlobalVariableCheck("ATR_W333")) w333 = GlobalVariableGet("ATR_W333");
   if(GlobalVariableCheck("ATR_W444")) w444 = GlobalVariableGet("ATR_W444");  
}

void ResetWeights(){
   w1 = 0.5; GlobalVariableSet("RSI_W1",w1);
   w2 = 0.5; GlobalVariableSet("RSI_W2",w2);
   w3 = 0.5; GlobalVariableSet("RSI_W3",w3);
   w4 = 0.5; GlobalVariableSet("RSI_W4",w4);
   
   w11 = 0.5; GlobalVariableSet("CCI_W11",w11);
   w22 = 0.5; GlobalVariableSet("CCI_W22",w22);
   w33 = 0.5; GlobalVariableSet("CCI_W33",w33);
   w44 = 0.5; GlobalVariableSet("CCI_W44",w44);
   
   w111 = 0.5; GlobalVariableSet("ATR_W111",w111);
   w222 = 0.5; GlobalVariableSet("ATR_W222",w222);
   w333 = 0.5; GlobalVariableSet("ATR_W333",w333);
   w444 = 0.5; GlobalVariableSet("ATR_W444",w444);
}

// Avarage Media error
// Use for umbral update weights
double UmbralAvg(double error){
   
   double avg_error   =  0.0;
   double alpha       =  0.1;
   
   // In each tick
   avg_error = (1 - alpha) * avg_error + alpha * MathAbs(error);
   
   return avg_error;
   
}


// Sigmoide Method
double Sigmoide(double x){
   if(x < -10)  return 0.0;
   if(x >  10)  return 1.0;
   return 1.0 / (1.0 + MathExp(-x));
}
//---------------------------------------------------


#endif