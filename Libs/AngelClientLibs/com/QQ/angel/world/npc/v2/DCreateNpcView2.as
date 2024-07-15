package com.QQ.angel.world.npc.v2
{
   import com.QQ.angel.api.events.BaseEvent;
   import com.QQ.angel.api.events.LoadTaskEvent;
   import com.QQ.angel.api.ui.IBubble;
   import com.QQ.angel.data.entity.NpcViewDes;
   import com.QQ.angel.world.events.SceneEvent;
   import com.QQ.angel.world.magic.IAcceptMagicView;
   import com.QQ.angel.world.magic.IAcceptMagicWithUin;
   import com.QQ.angel.world.npc.INPCElementView;
   import com.QQ.angel.world.npc.INPCTaskView;
   import com.QQ.angel.world.scene.IAcceptSceneEvent;
   import com.QQ.angel.world.scene.IAwareTaskState;
   import com.QQ.angel.world.scene.impl.DCSpriteView;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   
   public class DCreateNpcView2 extends DCSpriteView implements INPCElementView, INPCTaskView, IAcceptMagicView, IAcceptMagicWithUin
   {
       
      
      protected var nameTxt:TextField;
      
      protected var sign:MovieClip;
      
      protected var activeNpc:Boolean = false;
      
      protected var overFilters:Array = null;
      
      protected var mouseMC:MovieClip;
      
      protected var vDes:NpcViewDes;
      
      protected var xVisible:Boolean = true;
      
      protected var taskState:Object;
      
      public var sStage:Sprite;
      
      public var tooltip:String;
      
      public var tooltipType:int;
      
      public var tooltipPos:Point;
      
      public function DCreateNpcView2()
      {
         super();
      }
      
      protected function onMouseEvent(param1:MouseEvent) : void
      {
         var _loc2_:int = 1;
         if(param1.type == MouseEvent.MOUSE_OVER)
         {
            filters = this.overFilters;
            _loc2_ = 2;
         }
         else
         {
            filters = null;
         }
         if(this.mouseMC != null)
         {
            this.mouseMC.gotoAndStop(_loc2_);
         }
      }
      
      protected function stopMouseEvent(param1:MouseEvent) : void
      {
         if(param1.target != this)
         {
            param1.stopImmediatePropagation();
         }
      }
      
      protected function updateNSPos() : void
      {
         var _loc1_:Number = 0;
         if(this.vDes != null && content != null)
         {
            _loc1_ = -11 - (this.vDes.height == -1 ? content.height : this.vDes.height);
         }
         if(this.nameTxt != null)
         {
            this.nameTxt.y = _loc1_;
            this.nameTxt.x = this.vDes.offsetX - this.nameTxt.width >> 1;
            this.nameTxt.visible = this.xVisible;
            setChildIndex(this.nameTxt,0);
         }
         if(this.sign != null)
         {
            this.sign.y = _loc1_ - 5;
            this.sign.x = this.vDes.offsetX;
            this.sign.visible = this.xVisible;
            setChildIndex(this.sign,0);
         }
      }
      
      protected function updateViewTaskState() : void
      {
         if(this.taskState == null || !(content is IAwareTaskState))
         {
            return;
         }
         (content as IAwareTaskState).setTaskState(this.taskState.taskID,this.taskState.state);
      }
      
      protected function sceneEventHandler(param1:BaseEvent) : void
      {
         var _loc2_:IAcceptSceneEvent = content as IAcceptSceneEvent;
         if(_loc2_ != null)
         {
            _loc2_.onSceneEvent(String(param1.data));
         }
      }
      
      protected function setListenSceneEvent(param1:Boolean) : void
      {
         if(this.sStage == null)
         {
            return;
         }
         var _loc2_:IAcceptSceneEvent = content as IAcceptSceneEvent;
         if(_loc2_ == null)
         {
            return;
         }
         if(param1)
         {
            this.sStage.addEventListener(SceneEvent.SCENE_EVENT,this.sceneEventHandler);
         }
         else
         {
            this.sStage.removeEventListener(SceneEvent.SCENE_EVENT,this.sceneEventHandler);
         }
      }
      
      public function setSceneStage(param1:Sprite) : void
      {
         this.sStage = param1;
      }
      
      public function setModal(param1:Boolean) : void
      {
         if(this.sStage != null)
         {
            this.sStage.mouseChildren = !param1;
         }
      }
      
      public function onReady() : void
      {
         if(lazy == false)
         {
            this.load();
         }
         else
         {
            visible = false;
         }
      }
      
      public function setViewDes(param1:NpcViewDes) : void
      {
         this.vDes = param1;
      }
      
      public function setDepth(param1:int) : void
      {
      }
      
      public function getDepth() : int
      {
         return 0;
      }
      
      public function setXVisible(param1:Boolean) : void
      {
         if(this.nameTxt != null)
         {
            this.nameTxt.visible = param1;
         }
         if(this.sign != null)
         {
            this.sign.visible = param1;
         }
         this.xVisible = param1;
      }
      
      public function setMouseEnabled(param1:Boolean) : void
      {
         if(this.vDes != null && !this.vDes.hasClick)
         {
            mouseEnabled = false;
            mouseChildren = true;
            addEventListener(MouseEvent.CLICK,this.stopMouseEvent,false,1);
            this.setXVisible(false);
            return;
         }
         mouseEnabled = param1;
         buttonMode = param1;
         useHandCursor = param1;
         if(param1)
         {
            addEventListener(MouseEvent.MOUSE_OVER,this.onMouseEvent);
            addEventListener(MouseEvent.MOUSE_OUT,this.onMouseEvent);
         }
         else
         {
            removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseEvent);
            removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseEvent);
         }
      }
      
      public function setOverFilter(param1:Array) : void
      {
         this.overFilters = param1;
      }
      
      public function getMouseEnabled() : Boolean
      {
         return this.mouseEnabled;
      }
      
      public function setSelected(param1:Boolean) : void
      {
      }
      
      public function getSelected() : Boolean
      {
         return false;
      }
      
      public function setNameTxt(param1:TextField) : void
      {
         if(param1 == null && this.nameTxt != null)
         {
            removeChild(this.nameTxt);
            this.nameTxt = null;
         }
         else if(this.nameTxt == null && param1 != null)
         {
            this.nameTxt = param1;
            addChildAt(param1,0);
            this.updateNSPos();
         }
      }
      
      public function hasNameTxt() : Boolean
      {
         return this.nameTxt != null;
      }
      
      public function setNpcName(param1:String) : void
      {
         if(this.nameTxt == null)
         {
            return;
         }
         this.nameTxt.htmlText = param1;
         this.nameTxt.x = this.vDes.offsetX - (this.nameTxt.width >> 1);
      }
      
      public function addSign(param1:MovieClip) : void
      {
         if(param1 == null && this.sign != null)
         {
            this.signTO("");
            removeChild(this.sign);
         }
         else if(param1 != null && this.sign == null)
         {
            this.sign = param1;
            addChildAt(this.sign,0);
            this.updateNSPos();
         }
      }
      
      public function hasSign() : Boolean
      {
         return this.sign != null;
      }
      
      public function signTO(param1:String) : void
      {
         if(this.sign == null)
         {
            return;
         }
         this.sign.gotoAndStop(param1 == "" ? 1 : param1);
      }
      
      public function setBubble(param1:IBubble) : void
      {
      }
      
      public function getBubble() : IBubble
      {
         return null;
      }
      
      public function setNPCVisible(param1:Boolean) : void
      {
         if(!param1 && content != null && visible)
         {
            if(content.hasOwnProperty("delayHide") && content["delayHide"] == true)
            {
               return;
            }
         }
         this.visible = param1;
         if(param1)
         {
            if(lazy && state <= 0)
            {
               this.load();
            }
         }
      }
      
      override public function load(param1:String = "") : void
      {
         var _loc2_:DisplayObject = null;
         if(param1 != "")
         {
            this.path = param1;
         }
         if(this.vDes != null && this.vDes.resPool != null)
         {
            _loc2_ = this.vDes.resPool.borrowObject(this.path) as DisplayObject;
            if(_loc2_ != null)
            {
               this.onLoadComplete(null,_loc2_);
               return;
            }
         }
         super.load(param1);
      }
      
      public function getNPCVisible() : Boolean
      {
         return this.visible;
      }
      
      public function setActiveNPC(param1:String) : void
      {
         if(content != null && content.hasOwnProperty(param1))
         {
            content[param1](true);
         }
      }
      
      public function onAcceptedMagic(param1:int, param2:Number = 0, param3:Number = 0) : Boolean
      {
         var _loc4_:IAcceptMagicView;
         if((_loc4_ = content as IAcceptMagicView) != null)
         {
            return _loc4_.onAcceptedMagic(param1,param2,param3);
         }
         return false;
      }
      
      public function onAcceptedUinMagic(param1:int, param2:Number = 0, param3:Number = 0, param4:uint = 0) : Boolean
      {
         var _loc5_:IAcceptMagicWithUin;
         if((_loc5_ = content as IAcceptMagicWithUin) != null)
         {
            return _loc5_.onAcceptedUinMagic(param1,param2,param3,param4);
         }
         return false;
      }
      
      override protected function onLoadComplete(param1:LoadTaskEvent, param2:DisplayObject = null) : void
      {
         var _loc3_:MovieClip = null;
         super.onLoadComplete(param1,param2);
         if(content == null)
         {
            trace("[DCreateNpcView] 一个NPC视图加载失败!");
            return;
         }
         if(content is Bitmap)
         {
            content.x = (content.width >> 1) * -1;
            content.y = content.height * -1;
         }
         if(this.vDes.ver != 0 && content is MovieClip)
         {
            _loc3_ = content as MovieClip;
            hitArea = _loc3_;
            if(_loc3_.totalFrames > 1)
            {
               this.mouseMC = _loc3_;
               this.mouseMC.gotoAndStop(1);
            }
         }
         this.updateNSPos();
         this.updateViewTaskState();
         this.setListenSceneEvent(true);
         if(this.vDes != null && this.vDes.resViewLogic != null)
         {
            this.vDes.resViewLogic.bind(content);
         }
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      public function setTaskState(param1:int, param2:String) : void
      {
         if(this.taskState == null)
         {
            this.taskState = {
               "taskID":param1,
               "state":param2
            };
         }
         else
         {
            if(this.taskState.taskID == param1 && this.taskState.state == param2)
            {
               return;
            }
            this.taskState.taskID = param1;
            this.taskState.state = param2;
         }
         this.updateViewTaskState();
      }
      
      override public function unload() : void
      {
         this.setListenSceneEvent(false);
         this.setNameTxt(null);
         this.addSign(null);
         if(this.overFilters != null)
         {
            filters = this.overFilters = null;
            cacheAsBitmap = false;
         }
         if(this.vDes != null)
         {
            if(!this.vDes.hasClick)
            {
               removeEventListener(MouseEvent.CLICK,this.stopMouseEvent);
            }
            if(this.vDes.resViewLogic != null)
            {
               this.vDes.resViewLogic.unbind();
            }
            if(content != null && this.vDes.resPool != null)
            {
               content && content.parent && content.parent.removeChild(content);
               this.vDes.resPool.returnObject(content,path);
               content = null;
            }
         }
         this.vDes = null;
         this.mouseMC = null;
         this.taskState = null;
         super.unload();
      }
   }
}
