// Define Macros
#ifndef __DEPTH_NETWORK__
#define __DEPTH_NETWORK__


// Method to normalize values in [0,1]
// This method is use to normalize all values, all tickets
double Normalize(double value, double min, double max){
   
   return (value- min)/ (max - min);

}

#endif