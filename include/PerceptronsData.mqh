// Define Macros
#ifndef __DEPTH_NETWORK__
#define __DEPTH_NETWORK__

#include "Indicators.mqh"

// Remember: if the inputs is negative numbers only divide in 100. However, if the inputs not is negative, is divide in 100 and less 0.5.
// inputs RSI perceptron

// Weights ------------------------weights---------
double w1   = 0.5;
double w2   = 0.5;
double w3   = 0.5;
double w4   = 0.5;
double bias = 0.1;
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



// Tahn Activation function return planar values in -1 or 1
double TahnActivation(double _input){
   
   return (MathExp(_input) - MathExp(-_input)) / (MathExp(_input) + MathExp(-_input));

}

// Sigmoide function return values beetwen 0 or 1
double SigmoideActivation(double _input){

   return 1 / (1 + MathExp(-_input));

}


// --------------------------------------------------------------------------------
// -------------------------------------------------------------------------------- 
// ----------------------------------------------------------------RSI-PERCEPTRON--
double RSIPerceptron(){
   
   //  Inputs -------------------------inputs--------
   double a1 = ((GetRSI(7)-50)/50);
   double a2 = ((GetRSI(14)-50)/50);
   double a3 = ((GetRSI(30)-50)/50);
   double a4 = ((GetRSI(50)-50)/50);
   // ------------------------------------------------
   
   // Weighted Sum ---------------------Sum-----------
   double sumWeighted = a1*w1 + a2*w2 + a3*w3 + a4*w4;
   double output = TahnActivation(sumWeighted);                                               // Than activation function
   
   // ------------------------------------------------
   
   // TRAINING...
   // Calculate target
   
   double diference = Close[0] - Close[1];
   double threshold = Point * 10;                                                             // Here, implement the difference in price close with price close before candle
   double target    = (diference > threshold) ? 1 : (diference < -threshold ? -1 : 0);        // If change price
   
   /////////////////////////////////////////////////////////////////////////////////////////////
   
   double error  =  target - output;                                                          // Calculate error with target and output
   double lr     =  0.001;                                                                    // Learning rate
   double delta  =  (target - output) * (1 - MathPow(output,2));                              // Derivade Tahn ::: Use for update weights
   
   
   if( target != 0 && MathAbs(error) > 0.2){
      
      // Update weights with tahn derivade
      w1 += lr * delta * a1; 
      w2 += lr * delta * a2;
      w3 += lr * delta * a3;  
      w4 += lr * delta * a4; 
   
      SaveWeightsRSI();
   }
   
   return output;
}



// Method Save Weights to RSI 
void SaveWeightsRSI(){
   GlobalVariableSet("RSI_W1",w1);
   GlobalVariableSet("RSI_W2",w2);
   GlobalVariableSet("RSI_W3",w3);
   GlobalVariableSet("RSI_W4",w4);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// --------------------------------------------------------------------------------------------- //
// --------------------------------------------------------------------------------------------- //
///////////////////////////////////////////////////////////////////////////////////////////////////
// ----------------------------------------------------------------------------- CCI-Perceptron----
double CCIPerceptron(){
   
   // Inputs ----------------------------inputs-------
   double a1 = TahnActivation(GetCCI(7));
   double a2 = TahnActivation(GetCCI(14));
   double a3 = TahnActivation(GetCCI(30));
   double a4 = TahnActivation(GetCCI(50));
   // ------------------------------------------------
      
   // Weighted Sum -------------------------Sum-------
   double SumWeighted = a1*w11 + a2*w22 + a3*w33 + a4*w44;
   double output = TahnActivation(SumWeighted);
   // ------------------------------------------------
   
   // TRAINING...
   double diference = Close[0] - Close[1];
   double threshold = Point * 10;
   double target    = (diference > threshold) ? 1 : (diference < -threshold ? -1 : 0); 
   
   ///////////////////////////////////////////////////////////////////////////////////////
   
   double error  = target - output;
   double lr     = 0.001;
   double delta  = (target - output) * (1 - MathPow(output,2));
   
   if(target != 0 && MathAbs(error) > 0.2){
      
      // Update Weights
      w11 += lr * delta * a1;
      w22 += lr * delta * a2;
      w33 += lr * delta * a3;
      w44 += lr * delta * a4;
    
      SaveWeightsCCI();
   }
   
   return output;
   
}

// Method save weights to CCI
void SaveWeightsCCI(){
   GlobalVariableSet("CCI_W11", w11);
   GlobalVariableSet("CCI_W22", w22);
   GlobalVariableSet("CCI_W33", w33);
   GlobalVariableSet("CCI_W44", w44);

}



///////////////////////////////////////////////////////////////////////////////////////////
// ------------------------------------------------------------------------------------- //
// ------------------------------------------------------------------------------------- //
///////////////////////////////////////////////////////////////////////////////////////////
// --------------------------------------------------------------------ATR-Perceptron------
double ATRPerceptron(){

   // Variable use for calculate means number
   // Used for normalized inputs and calculate error 
   int scalar = 10000;
   
   // Inputs -----------------------------inputs------
   double a1 = SigmoideActivation(GetATR(7) * scalar);
   double a2 = SigmoideActivation(GetATR(14)* scalar);
   double a3 = SigmoideActivation(GetATR(30)* scalar);
   double a4 = SigmoideActivation(GetATR(50)* scalar);
   // -------------------------------------------------
   
   // Weighted Sum ------------------------------------
   double weightedSum = a1 * w111 + a2 * w222 + a3 * w333 + a4 * w444;
   double output      =  SigmoideActivation(weightedSum);
   
   // Target ----------------------------------------
   double avg_atr = (GetATR(7)+GetATR(14)+GetATR(30)+GetATR(50))/4;      // Means promedio beetwen all inputs
   double move    = MathAbs(Close[0] - Close[1]);                        // diference in close price in actually candle and before clandle
   double ratio   = move / (avg_atr + 0.00001);                          // Is add 0.00001, prevent divide in zero 
   double target  = (ratio > 1.5 ) ? 1 : (ratio < 0.5 ? 0 : 0.5);        // 
    
   // TRAINING -------------------------------------------
   double error = target - output;                      // Calculate error
   double lr    = 0.001;
   double delta = (target - output) * output * (1 - output);
   
   
   if( target != 0 && MathAbs(error) > 0.2){                // If the error is major to umbral error recalculate weights
      w111 += lr * delta * a1;
      w222 += lr * delta * a2;
      w333 += lr * delta * a3;
      w444 += lr * delta * a4;
      
      SaveWeightsATR();
   }
    
   
   return output;  
}


// Here save weights 
void SaveWeightsATR(){
   GlobalVariableSet("ATR_W111", w111);
   GlobalVariableSet("ATR_W222", w222);
   GlobalVariableSet("ATR_W333", w333);
   GlobalVariableSet("ATR_W444", w444);
   
}

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////




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

//---------------------------------------------------


#endif