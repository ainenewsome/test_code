class GDP {
  
  String country_code;
  String currency;
  String year;
  float gdp_amount;
  
  GDP(String line){
    
    String[] parts = line.split(",");
    country_code = parts[0];
    currency = parts[1];
    year = parts[3];
    gdp_amount = Float.parseFloat(parts[4]);
    
  }// end gdp
  
}// end class GDP