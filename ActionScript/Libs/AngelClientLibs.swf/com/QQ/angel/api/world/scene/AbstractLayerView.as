package com.QQ.angel.api.world.scene
{
   import com.QQ.angel.api.display.IDisplay;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class AbstractLayerView extends Sprite implements IDisplay
   {
      
      public function AbstractLayerView()
      {
         super();
      }
      
      public function addViewItem(param1:*) : Object
      {
         return null;
      }
      
      public function removeViewItem(param1:String) : void
      {
      }
      
      public function get display() : DisplayObject
      {
         return this;
      }
      
      public function onRender(param1:Event) : void
      {
      }
      
      public function hasRender() : Boolean
      {
         return false;
      }
      
      public function unload() : void
      {
      }
   }
}

