package com.QQ.angel.world.scene.impl
{
   import com.QQ.angel.api.display.IDisplay;
   import com.QQ.angel.api.events.IRenderListener;
   import com.QQ.angel.api.world.scene.IElement;
   import com.QQ.angel.api.world.scene.ILayer;
   import com.QQ.angel.api.world.scene.ISPlace;
   import com.QQ.angel.utils.LocalFile;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class SimpleLayer extends EventDispatcher implements ILayer
   {
      
      private static const ME_LABEL:String = "instance";
       
      
      protected var container:DisplayObjectContainer;
      
      protected var layerID:int;
      
      protected var children:Dictionary;
      
      protected var renders:Array;
      
      protected var runLevel:int = 0;
      
      public function SimpleLayer(param1:DisplayObjectContainer = null, param2:int = 0)
      {
         super();
         if(param1 == null)
         {
            throw new Error("SimpleLayer的container不为能NULL");
         }
         this.container = param1;
         this.container.mouseEnabled = false;
         this.setLayerID(param2);
      }
      
      protected function add_remove_render(param1:IElement, param2:Boolean = false) : void
      {
         var _loc4_:int = 0;
         var _loc3_:IRenderListener = param1.getView() as IRenderListener;
         if(_loc3_ != null && _loc3_.hasRender())
         {
            if(param2)
            {
               this.renders.push(_loc3_);
            }
            else if((_loc4_ = this.renders.indexOf(_loc3_)) != -1)
            {
               this.renders.splice(_loc4_,1);
            }
         }
      }
      
      public function initialize(... rest) : void
      {
         var _loc5_:DisplayObject = null;
         var _loc6_:IElement = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc2_:Dictionary = rest[0];
         this.runLevel = int(rest[1]);
         this.container.mouseEnabled = false;
         this.children = new Dictionary();
         var _loc3_:int = this.container.numChildren;
         this.renders = [];
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if((_loc5_ = this.container.getChildAt(_loc4_)) is ISPlace)
            {
               _loc8_ = int(_loc5_.x + 0.5) + "-" + int(_loc5_.y + 0.5);
               _loc2_[_loc8_] = _loc5_;
            }
            this.setMouseEnabled(_loc5_);
            _loc4_++;
         }
      }
      
      public function finalize() : void
      {
         this.clear();
         this.children = null;
      }
      
      protected function setMouseEnabled(param1:DisplayObject) : void
      {
         var _loc2_:InteractiveObject = param1 as InteractiveObject;
         if(_loc2_ != null && param1.name.indexOf(ME_LABEL) != -1)
         {
            _loc2_.mouseEnabled = false;
            if(_loc2_ is DisplayObjectContainer)
            {
               (_loc2_ as DisplayObjectContainer).mouseChildren = false;
            }
         }
      }
      
      public function setRunLevel(param1:int = 0) : void
      {
         var _loc2_:Object = null;
         if(this.runLevel == param1)
         {
            return;
         }
         this.runLevel = param1;
         for each(_loc2_ in this.children)
         {
            if(_loc2_.hasOwnProperty("setRunLevel"))
            {
               _loc2_["setRunLevel"](param1);
            }
         }
      }
      
      public function setLayerID(param1:int) : void
      {
         this.layerID = param1;
      }
      
      public function getLayerID() : int
      {
         return this.layerID;
      }
      
      public function getContainer() : DisplayObjectContainer
      {
         return this.container;
      }
      
      public function addElement(param1:IElement) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:DisplayObject = param1.display;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:* = param1.getView();
         if(_loc3_ is IDisplay)
         {
            this.add_remove_render(param1,true);
         }
         this.container.addChild(_loc2_);
         this.children[param1.getName()] = param1;
      }
      
      public function onRender(param1:Event) : void
      {
         if(this.renders == null)
         {
            return;
         }
         var _loc2_:int = int(this.renders.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            (this.renders[_loc3_] as IRenderListener).onRender(param1);
            _loc3_++;
         }
      }
      
      public function hasRender() : Boolean
      {
         return true;
      }
      
      public function removeElement(param1:IElement) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         return this.removeElementByName(param1.getName()) != null;
      }
      
      public function getElement(param1:int) : IElement
      {
         var _loc2_:DisplayObject = this.container.getChildAt(param1);
         return _loc2_ == null ? null : this.children[_loc2_.name];
      }
      
      public function getElement2(param1:String) : IElement
      {
         return this.children[param1];
      }
      
      public function findInstanceAt(param1:Point) : DisplayObject
      {
         var _loc4_:DisplayObject = null;
         if(this.container == null)
         {
            return null;
         }
         var _loc2_:int = this.container.numChildren;
         var _loc3_:int = _loc2_ - 1;
         while(_loc3_ >= 0)
         {
            if((_loc4_ = this.container.getChildAt(_loc3_)).hitTestPoint(param1.x,param1.y,true))
            {
               return _loc4_;
            }
            _loc3_--;
         }
         return null;
      }
      
      public function removeElement2(param1:int) : void
      {
         var _loc2_:DisplayObject = this.container.removeChildAt(param1);
         var _loc3_:IElement = this.children[_loc2_.name] as IElement;
         if(_loc3_ != null)
         {
            this.add_remove_render(_loc3_);
            _loc3_.finalize();
         }
         delete this.children[_loc2_.name];
      }
      
      public function removeElementByName(param1:String) : IElement
      {
         var _loc3_:DisplayObject = null;
         var _loc2_:IElement = this.children[param1] as IElement;
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.display;
            this.container.removeChild(_loc3_);
            this.add_remove_render(_loc2_);
            delete this.children[param1];
            return _loc2_;
         }
         return null;
      }
      
      public function removeAll() : void
      {
         while(this.container.numChildren > 0)
         {
            this.removeElement2(0);
         }
      }
      
      public function clear() : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:IElement = null;
         var _loc1_:int = this.container.numChildren - 1;
         while(_loc1_ >= 0)
         {
            _loc2_ = this.container.getChildAt(_loc1_);
            _loc3_ = this.children[_loc2_.name] as IElement;
            if(_loc3_ != null)
            {
               this.add_remove_render(_loc3_);
               _loc3_.finalize();
               delete this.children[_loc2_.name];
            }
            else if(_loc2_ is DisplayObjectContainer)
            {
               LocalFile.STOPContainer(_loc2_ as DisplayObjectContainer);
            }
            _loc1_--;
         }
      }
   }
}
