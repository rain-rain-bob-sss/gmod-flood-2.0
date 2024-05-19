-- TO DO:REPLACE ALL [FLOOD] MESSAGE TO NEW MESSAGE SYSTEM
local nws="fm_newmessage"
if(SERVER)then
  util.AddNetworkString(nws)
  function FM_MESSAGE(ply,messagetbl)
    net.Start(nws)
      net.WriteTable(messagetbl)
    net.Send(ply)
  end
  function FM_BROADCASTMESSAGE(messagetbl)
    net.Start(nws)
      net.WriteTable(messagetbl)
    net.Broadcast()
  end
  local base={str="NIL",col=Color(255,255,255),a=500,x=100,y=-200,ft="DermaLarge"}
  function FM_MESSAGE_BASE()
    return base
  end
else --NO BUDGET TO THINK ABOUT VAR NAME
  local e=e or {}
  --Some stupid dont update their gmod,fuck you.
  function ScreenScale( width )
    return width * ( ScrW() / 640.0 )
  end
  
  function ScreenScaleH( height )
    return height * ( ScrH() / 480.0 )
  end
  SScale = ScreenScale
  SScaleH = ScreenScaleH
  net.Receive(nws,function(l,_)
    local tbl=net.ReadTable()
    local col=tbl.col or Color(255,255,255)
    local str=tbl.str or "NIL"
    e[#e+1]={c=col,s=str,a=tbl.a or 500,x=SScale(tbl.x) or 0,y=SScaleH(tbl.y) or 0,font=tbl.ft or "DermaLarge"}
    --print("Hah!")
  end)
  concommand.Add("fm_messagecleanup",function()
    e={}
  end)
  local alladjust={x=0,y=0}
  hook.Add("InputMouseApply","fm_message_move",function(c,x,y,a)
    alladjust.x=alladjust.x+x*-0.03
    alladjust.y=alladjust.y+y*-0.03
  end)
  hook.Add("Think","fm_message_velocity_move",function()
    local p=LocalPlayer()
    local moveang=p:EyeAngles()
    moveang[1]=0
    local movevel=WorldToLocal(p:GetVelocity(),Angle(),Vector(),moveang)
    --print(movevel)
    alladjust.x=alladjust.x+movevel.y*0.015
    alladjust.y=alladjust.y+movevel.x*0.005
  end)
  hook.Add("PostDrawHUD","fm_message_Drawing",function()
    local co={}
    alladjust.x=Lerp(0.05,alladjust.x,0)
    alladjust.y=Lerp(0.05,alladjust.y,0)
    for i,v in pairs(e)do
        if(not v)then continue end
        if(v.c.a==0)then e[i]=nil continue end
        --PrintTable(v)
        v.a=v.a-100*FrameTime()
        v.c.a=math.Clamp(v.a,0,255)
        surface.SetFont(v.font)
        local w,h=surface.GetTextSize(v.s)
        if(co["x"..v.x.."y"..v.y]==nil)then
          co["x"..v.x.."y"..v.y]=0
        end
        draw.DrawText(v.s,v.font,ScrW()/2+v.x+alladjust.x,ScrH()/2+v.y+co["x"..v.x.."y"..v.y]+alladjust.y,v.c,TEXT_ALIGN_CENTER)
        --break --only 1
        co["x"..v.x.."y"..v.y]=co["x"..v.x.."y"..v.y]+h
    end
  end)
end
