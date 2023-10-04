-- TO DO:REPLACE ALL [FLOOD] MESSAGE TO NEW MESSAGE SYSTEM
local nws="fm_newmessage"
if(SERVER)then
  util.AddNetworkString(nws)
  function FM_MESSAGE(ply,messagetbl)
    net.Start(nws)
      net.WriteTable(messagetbl)
    net.Send(ply)
  end
else --NO BUDGET TO THINK ABOUT VAR NAME
  local e={}
  net.Receive(nws,function(l,_)
    local tbl=net.ReadTable()
    local col=tbl.col or Color(255,255,255)
    local str=tbl.str or "NIL"
    e[#e+1]={c=col,s=str,a=tbl.a or 200}
  end)
  hook.Add("PostDrawHUD","fm_message_Drawing",function()
    for i,v in pairs(e)do
        if(not v)then continue end
        v.a=v.a-10*FrameTime()
        v.c.a=math.clamp(v.a,0,255)
        draw.DrawText(v.s,"DermaDefault",ScrW()/2,ScrH()/2,v.c,TEXT_ALIGN_CENTER)
        break --only 1
    end
  end)
end
