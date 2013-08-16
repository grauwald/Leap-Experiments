class TUIOServer
{
  
  NetAddress remote;
  OscP5 oscP5;
  int fid;
  
  public TUIOServer(String host, int port)
  {
    
    oscP5 = new OscP5(this, 12000);
    remote = new NetAddress(host, port);
    fid = 0;
  }
  
  public void send(String type, TouchPoint tp)
  {
    TouchPoint[] tps = {tp};
    send(type, tps);
  }
  
  public void send(String type, TouchPoint[] tps)
  {
   
    int len = tps.length;
    
    OscBundle myBundle = new OscBundle();
    
    OscMessage myMessage = new OscMessage("/tuio/2Dcur");
    myMessage.add("source"); /* add an int to the osc message */
    myMessage.add("rencontre_i");
    myBundle.add(myMessage);
    
    myMessage.clear();
    
    /* refill the osc message object again */
    myMessage.setAddrPattern("/tuio/2Dcur");
    myMessage.add("alive");
    
    if(type.equals("update") || type.equals("alive"))
    {
      for(int i=0;i<tps.length;i++)
      {
        myMessage.add(tps[i].id);
      }
      
    }
    
    myBundle.add(myMessage);
      
    if(type.equals("update"))
    {
      for(int i=0;i<tps.length;i++)
      {
        //println("set "+tps[i].id);
        myMessage.clear();
        myMessage.setAddrPattern("/tuio/2Dcur");
        myMessage.add("set");
        myMessage.add(tps[i].id);
        myMessage.add(tps[i].x);
        myMessage.add(tps[i].y);
        myMessage.add(tps[i].speedX);
        myMessage.add(tps[i].speedY);
        myMessage.add(tps[i].acc);
        myBundle.add(myMessage);
      }
      
    }
    
    myMessage.clear();
    myMessage.setAddrPattern("/tuio/2Dcur");
    myMessage.add("fseq");
    myMessage.add(fid);
    myBundle.add(myMessage);
  
    /* send the message */
    oscP5.send(myBundle, remote); 
    
    
    
    fid++;
    
  }
  
}
