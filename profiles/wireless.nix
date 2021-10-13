{
  # Configures a list of networks I want to connect to.
  networking.wireless.networks = { 
    goatControl.pskRaw = "ec7319b43260eb9127295667cc1d5d2dfc4c9e57574415f0b541c04e30e868ba";
    Astral_Ship_5GHz.pskRaw = "157bddfe695338f0fc6a2cfa88dbb6134a3489579f7e748714fa1ae2e8a82192";
    Astral_Ship.pskRaw = "ff866b7b9494bd6915c28a06c8604d1e2396e590e64f71b2fdf9c0c9709ec2c4";
    Astral_ship_Festri.pskRaw = "a20c6252f348eddc73efc0a0956c7cf66c958a327d7d7b943d72cf477008d8f2";
    DoESLiverpool.pskRaw = "63e49f779a41eda7be1510a275a07e519d407af706d0f2d3cc3140b9aecd412f"; 
    sirGranite.pskRaw = "58f5e6d6058c8b476e7a88f0107d832da12e2ed1b1ecacc071f61345c4731eec"; 
    bebop = { 
      pskRaw = "0c89c6e287005f99efda5199d432f94cf8d08ea7925ba2d24eef24e268aabe67"; 
      priority = 10; 
    }; 
    VM9606636 = {  
      pskRaw = "8f4e924abf1c644cf53b6bbf0dc4d813dc783ff27227580b046164348331966b"; 
      priority = 1; 
    };
  };
}
