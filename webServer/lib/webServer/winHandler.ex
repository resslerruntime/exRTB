defmodule WebServer.WinHandler do

  def init(_t,r,[]) do
  {:ok,r,nil}
  end
  def findCompatibleCreative() do

  end
  def getBidPrice()do

  end
  def pickCreative()do

  end
  def bid()do

  end
  def handle(req,state) do
  :gen_event.call(:"money",{:registerWin})
  auctionID=false
  {auctionID, Req2} = :cowboy_req.qs_val("auctionID", req)
  if auctionID do
  Agent.update(:inFlight, fn (d)-> 
    priceInFlight=Dict.get(auctionID)
    ##now send to money manager
    :gen_event.call(:money,{:registerWin,priceInFlight})
    Dict.delete(d, auctionID)
end
    
    )
   end 
  IO.puts :cowboy.body(req)
  #decide

  {:ok,req} = :cowboy_req.reply(200,[],"asdasd",req)
  {:ok,req,:state}
  end
  def terminate(_r,_e,s) do
  {:ok}
  end
end