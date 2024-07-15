package com.QQ.angel.world.npc.v2
{
   import com.QQ.angel.data.entity.NpcDes;
   import com.QQ.angel.data.entity.world.CareTaskID;
   import com.QQ.angel.data.entity.world.events.NpcModelEvent;
   import com.QQ.angel.world.npc.INPCElement;
   import com.QQ.angel.world.npc.INPCElementView;
   import com.QQ.angel.world.npc.INPCTaskView;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class TaskNPCElement2 extends AbstractNPC2 implements INPCElement
   {
       
      
      protected var npcView:INPCElementView;
      
      protected var iconView:MovieClip;
      
      public function TaskNPCElement2()
      {
         super();
      }
      
      protected function onTStateChange(param1:Event) : void
      {
         var _loc4_:INPCTaskView = null;
         var _loc2_:NpcDes = npcProxy.getNpcDes();
         var _loc3_:CareTaskID = _loc2_.tState as CareTaskID;
         if(_loc3_ != null)
         {
            if((_loc4_ = this.npcView as INPCTaskView) != null)
            {
               _loc4_.setTaskState(_loc3_.taskID,_loc3_.sourceCare);
            }
         }
      }
      
      protected function onHeadIconChange(param1:Event) : void
      {
         var _loc2_:int = npcProxy.getHeadIcon();
         if(_loc2_ == 0 && this.iconView == null)
         {
            return;
         }
         if(this.iconView == null)
         {
            this.iconView = npclistener.getCommIcon("taskSign") as MovieClip;
            this.npcView.addSign(this.iconView);
         }
         var _loc3_:String = "";
         if(_loc2_ != 0)
         {
            _loc3_ = _loc2_ == 2 ? "?" : "!";
         }
         this.npcView.signTO(_loc3_);
      }
      
      override public function initialize(... rest) : void
      {
         super.initialize();
         this.npcView.setMouseEnabled(npcProxy.getClick() != null);
         var _loc2_:NpcDes = npcProxy.getNpcDes();
         this.onTStateChange(null);
         this.onHeadIconChange(null);
         if(_loc2_.npcViewDes != null && _loc2_.npcViewDes.hasBorder)
         {
            this.npcView.setOverFilter(listener.getOverFilters());
         }
         npcProxy.addEventListener(NpcModelEvent.ON_TSTATE_CHANGE,this.onTStateChange);
         npcProxy.addEventListener(NpcModelEvent.ON_HEADICON_CHANGE,this.onHeadIconChange);
      }
      
      override public function finalize() : void
      {
         if(this.iconView != null)
         {
            listener.returnCommIcon("taskSign",this.iconView);
            this.iconView = null;
         }
         this.npcView.setMouseEnabled(false);
         npcProxy.removeEventListener(NpcModelEvent.ON_TSTATE_CHANGE,this.onTStateChange);
         npcProxy.removeEventListener(NpcModelEvent.ON_HEADICON_CHANGE,this.onHeadIconChange);
         this.npcView = null;
         super.finalize();
      }
      
      override public function attachView(param1:*) : void
      {
         super.attachView(param1);
         this.npcView = param1 as INPCElementView;
      }
   }
}
