package com.QQ.angel.world.impl
{
   import com.QQ.angel.api.events.IRenderListener;
   import com.QQ.angel.api.ui.IBubble;
   import com.QQ.angel.api.world.scene.IActivityView;
   import com.QQ.angel.world.render.BDFrameEvent;
   import com.QQ.angel.world.render.BDRenderPlayer;
   import com.QQ.angel.world.vo.Avatar;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class BaseObjectView extends Sprite implements IActivityView
   {
       
      
      protected var depth:int;
      
      protected var locXY:Point;
      
      protected var body:BDRenderPlayer;
      
      protected var isSelected:Boolean = false;
      
      protected var renderList:Array;
      
      protected var bubble:IBubble;
      
      protected var currentAvatar:Avatar;
      
      public function BaseObjectView()
      {
         super();
         this.mouseChildren = false;
         this.mouseEnabled = false;
         this.locXY = new Point(x,y);
         addChild(this.body = new BDRenderPlayer());
         this.renderList = [this.body];
      }
      
      protected function add_remove_RenderList(param1:IRenderListener, param2:Boolean = true) : void
      {
         var _loc3_:int = 0;
         if(param1 == null)
         {
            return;
         }
         if(param2)
         {
            this.renderList.push(param1);
         }
         else
         {
            _loc3_ = this.renderList.indexOf(param1);
            if(_loc3_ != -1)
            {
               this.renderList.splice(_loc3_,1);
            }
         }
      }
      
      protected function createClickArea() : void
      {
         addChild(hitArea = new Sprite());
         hitArea.graphics.beginFill(16711680,0);
         hitArea.graphics.drawEllipse(-20,-70,40,60);
         hitArea.graphics.endFill();
      }
      
      public function setBubble(param1:IBubble) : void
      {
         if(param1 == null)
         {
            if(this.bubble != null)
            {
               this.bubble.unload();
               this.bubble = null;
            }
         }
         else
         {
            this.bubble = param1;
            this.bubble.setContainer(this);
            this.bubble.y = -85;
         }
      }
      
      public function getBubble() : IBubble
      {
         return this.bubble;
      }
      
      public function setDepth(param1:int) : void
      {
         this.depth = param1;
      }
      
      public function getDepth() : int
      {
         return this.depth;
      }
      
      public function setMouseEnabled(param1:Boolean) : void
      {
         if(hitArea == null)
         {
            this.createClickArea();
            this.buttonMode = true;
            this.useHandCursor = true;
         }
         if(hitArea != null)
         {
            hitArea.visible = param1;
         }
         this.mouseEnabled = param1;
      }
      
      public function getMouseEnabled() : Boolean
      {
         return hitArea != null && hitArea.visible;
      }
      
      public function onRender(param1:Event) : void
      {
         this.body.onRender(param1);
      }
      
      public function hasRender() : Boolean
      {
         return true;
      }
      
      public function setBodyVisible(param1:Boolean) : void
      {
         if(this.body)
         {
            this.body.visible = param1;
         }
      }
      
      public function setXYLocation(param1:Number, param2:Number) : void
      {
         this.locXY.x = param1;
         this.locXY.y = param2;
         this.x = int(param1 + 0.5);
         this.y = int(param2 + 0.5);
      }
      
      public function setLocation(param1:Point) : void
      {
         this.setXYLocation(param1.x,param1.y);
      }
      
      public function getLocation() : Point
      {
         return this.locXY.clone();
      }
      
      public function setSelected(param1:Boolean) : void
      {
      }
      
      public function getSelected() : Boolean
      {
         return false;
      }
      
      public function addLabelEvent(param1:Function) : void
      {
         this.body.addEventListener(BDFrameEvent.ON_ENTERLABEL,param1);
      }
      
      public function removeLabelEvent(param1:Function) : void
      {
         this.body.removeEventListener(BDFrameEvent.ON_ENTERLABEL,param1);
      }
      
      public function addEndFrameEvent(param1:Function) : void
      {
         this.body.addEventListener(BDFrameEvent.ON_ENDFRAME,param1);
      }
      
      public function removeEndFrameEvent(param1:Function) : void
      {
         this.body.removeEventListener(BDFrameEvent.ON_ENDFRAME,param1);
      }
      
      public function get display() : DisplayObject
      {
         return this;
      }
      
      public function unload() : void
      {
         if(this.bubble != null)
         {
            this.bubble.unload();
         }
         this.body.dispose();
         this.body = null;
         this.bubble = null;
      }
   }
}
