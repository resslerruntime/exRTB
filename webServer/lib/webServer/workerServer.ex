defmodule WebServer.WorkerServer do


  # See http://elixir-lang.org/docs/stable/Application.html
  # for more information on OTP Applications
  def init() do
      
  end
  
  def start_link( _args) do
:exometer_report.add_reporter(:exometer_report_graphite,[{:connect_timeout,5000},{:prefix, 'web_stats'},{:host,'172.17.0.11'},{:port,2003},{:api_key,'exRTBnode'}])

:exometer.new([:requests],:spiral)
 

:exometer_report.subscribe( :exometer_report_graphite, [:requests], :one, 5)

 
    state=%{:size=> 1}
    stat=%{:size=>state}
    {:ok,pid}=WebServer.CreativeIndex.start()
    item=[  	
	   "0",
	   320,
	   50,
	   "nikolamandic.github.io/favicon.gif",
	   "apple.com",
	   "IAB9-"
	] 
    IO.puts("p1")
    send pid, {:put,item}
    IO.puts("g1")
    send pid, {:get,{},self()}
    receive do
    	    stat->
    dispatch= :cowboy_router.compile([
    {:_,[
         {"/auctions",WebServer.TopPageHandler,stat},
         {"/wins",WebServer.WinHandler,[]} #,
	 #{"/campaignAdd",WebServer.CampaignManager},
	 #{"/creativeAdd",WebServer.CampaignManager}
    ]}
    ])

    IO.inspect "run server at 8080"
    {:ok,_} = :cowboy.start_http(:http,100,[port: 8080],[env: [dispatch: dispatch]])

    end
  end
end
