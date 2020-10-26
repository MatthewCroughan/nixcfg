{
  # Configures a list of networks I want to connect to.
  networking.wireless.networks = { 
    Astral_Ship.pskRaw = "ff866b7b9494bd6915c28a06c8604d1e2396e590e64f71b2fdf9c0c9709ec2c4";
    Astral_ship_Festri.pskRaw = "a20c6252f348eddc73efc0a0956c7cf66c958a327d7d7b943d72cf477008d8f2";
    DoESLiverpool.pskRaw = "63e49f779a41eda7be1510a275a07e519d407af706d0f2d3cc3140b9aecd412f"; 
    bebop = { 
      pskRaw = "0c89c6e287005f99efda5199d432f94cf8d08ea7925ba2d24eef24e268aabe67"; 
      priority = 2; 
    }; 
    VM9606636 = {  
      pskRaw = "8f4e924abf1c644cf53b6bbf0dc4d813dc783ff27227580b046164348331966b"; 
      priority = 1; 
    };
  };
}
